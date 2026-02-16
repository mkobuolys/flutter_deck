import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// A [FlutterDeckPlugin] that exports the presentation as a PDF file.
class FlutterDeckPdfExportPlugin extends FlutterDeckPlugin {
  /// Creates a [FlutterDeckPdfExportPlugin].
  FlutterDeckPdfExportPlugin();

  late final FlutterDeckSlideImageRenderer _slideImageRenderer;

  @override
  void init(FlutterDeck flutterDeck) {
    _slideImageRenderer = FlutterDeckSlideImageRenderer(flutterDeck: flutterDeck);
  }

  @override
  List<Widget> buildControls(BuildContext context, FlutterDeckPluginMenuItemBuilder menuItemBuilder) => [
    menuItemBuilder(
      context,
      icon: const Icon(Icons.picture_as_pdf_rounded),
      label: 'Export PDF',
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
            const Text('Exporting PDF...'),
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

      await _exportPdf(overlayContext, onProgress: (progress) => progressNotifier.value = progress);

      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Exported presentation as PDF!')));
    } catch (e) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Failed to export presentation: $e')));
    }
  }

  Future<void> _exportPdf(BuildContext context, {required ValueChanged<double> onProgress}) async {
    final flutterDeck = context.flutterDeck;
    final slides = flutterDeck.router.slides;

    final pdf = pw.Document();

    if (!context.mounted) {
      throw Exception('No context available after initialising a new presentation');
    }

    for (var i = 0; i < slides.length; i++) {
      final slide = slides[i];
      final configuration = slide.configuration;
      final steps = configuration.steps;

      for (var step = 1; step <= steps; step++) {
        onProgress((i + 1) / slides.length);

        if (!context.mounted) {
          throw Exception('No context available at slide $i, step $step');
        }

        final view = View.of(context);
        final slideSize = configuration.slideSize;
        final logicalSize = slideSize.isResponsive
            ? view.physicalSize / view.devicePixelRatio
            : Size(slideSize.width!, slideSize.height!);

        final bytes = await _slideImageRenderer.render(context, slide.widget, stepNumber: step);
        final image = pw.MemoryImage(bytes);

        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat(logicalSize.width, logicalSize.height),
            build: (pw.Context context) => pw.Center(child: pw.Image(image)),
          ),
        );
      }
    }

    final pdfBytes = await pdf.save();

    final saveFn = kIsWeb ? FileSaver.instance.saveFile : FileSaver.instance.saveAs;
    final fileExtension = MimeType.pdf.name.toLowerCase();

    await saveFn(
      name: 'flutter_deck_presentation.$fileExtension',
      fileExtension: fileExtension,
      includeExtension: false,
      bytes: pdfBytes,
      mimeType: MimeType.pdf,
    );
  }
}
