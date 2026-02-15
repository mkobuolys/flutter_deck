import 'package:file/memory.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_pptx_export/src/flutter_slide_image_renderer.dart';
import 'package:open_xml/open_xml.dart' as open_xml;

/// A [FlutterDeckPlugin] that exports the presentation as a PPTX file.
class FlutterDeckPptxExportPlugin extends FlutterDeckPlugin {
  /// Creates a [FlutterDeckPptxExportPlugin].
  FlutterDeckPptxExportPlugin();

  late final FlutterSlideImageRenderer _slideImageRenderer;

  @override
  void init(FlutterDeck flutterDeck) {
    _slideImageRenderer = FlutterSlideImageRenderer(flutterDeck: flutterDeck);
  }

  @override
  List<Widget> buildControls(BuildContext context, FlutterDeckPluginMenuItemBuilder menuItemBuilder) => [
    menuItemBuilder(
      context,
      icon: const Icon(Icons.slideshow_rounded),
      label: 'Export PPTX',
      onPressed: () => _onPressed(context),
    ),
  ];

  Future<void> _onPressed(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final progressNotifier = ValueNotifier<double>(0);

    messenger.showSnackBar(
      SnackBar(
        duration: const Duration(minutes: 5),
        content: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: ValueListenableBuilder<double>(
                valueListenable: progressNotifier,
                builder: (context, value, _) => CircularProgressIndicator(
                  value: value,
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  strokeWidth: 2,
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Text('Exporting PPTX...'),
          ],
        ),
      ),
    );

    try {
      await Future.delayed(const Duration(seconds: 1));
      final overlayContext = navigator.overlay?.context;

      if (overlayContext == null || !overlayContext.mounted) {
        throw Exception('No overlay context available');
      }

      await _exportPptx(overlayContext, onProgress: (progress) => progressNotifier.value = progress);

      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Exported presentation as PPTX!')));
    } catch (e) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Failed to export presentation: $e')));
    }
  }

  Future<void> _exportPptx(BuildContext context, {required ValueChanged<double> onProgress}) async {
    final flutterDeck = context.flutterDeck;
    final slides = flutterDeck.router.slides;

    final fs = MemoryFileSystem();
    final pres = await open_xml.Presentation.create(fs);

    if (!context.mounted) {
      throw Exception('No context available after initialising a new presentation');
    }

    pres.setAspectRatio(open_xml.PresentationAspectRatio.widescreen_16_9);

    var slideIndex = 0;

    for (var i = 0; i < slides.length; i++) {
      final slide = slides[i];
      final steps = slide.configuration.steps;
      final speakerNotes = slide.configuration.speakerNotes;

      for (var step = 1; step <= steps; step++) {
        onProgress((i + 1) / slides.length);

        if (!context.mounted) {
          throw Exception('No context available at slide $i, step $step');
        }

        final bytes = await _slideImageRenderer.render(context, slide.widget, stepNumber: step);

        final fileName = 'slide_${(slideIndex++).toString().padLeft(5, '0')}.png';

        // Write image to memory fs
        final imageFile = fs.file(fileName);
        await imageFile.writeAsBytes(bytes);

        final pptxSlide = pres.addSlide()
          // Add image as background
          ..setBackground(open_xml.ImageBackground(fileName, mode: open_xml.ImageStretchMode()))
          // Set transition
          ..setTransition(open_xml.FadeTransition());

        if (speakerNotes.isNotEmpty) {
          pptxSlide.addNote(speakerNotes);
        }
      }
    }

    // Save PPTX to memory fs
    const pptxPath = 'presentation.pptx';
    await pres.save(fs.file(pptxPath));

    // Read bytes and save to user device
    final pptxFile = fs.file(pptxPath);
    final pptxBytes = await pptxFile.readAsBytes();
    await pres.close(); // Clean up resources

    final saveFn = kIsWeb ? FileSaver.instance.saveFile : FileSaver.instance.saveAs;

    await saveFn(
      name: 'flutter_deck_presentation.pptx',
      fileExtension: 'pptx',
      includeExtension: false,
      bytes: pptxBytes,
      mimeType: MimeType.microsoftPresentation,
    );
  }
}
