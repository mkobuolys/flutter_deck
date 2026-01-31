// ignore_for_file: use_build_context_synchronously, cascade_invocations

import 'package:file/memory.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_example/l10n/l10n.dart';
import 'package:flutter_deck_example/slides/slides.dart';
import 'package:flutter_deck_web_client/flutter_deck_web_client.dart';
import 'package:open_xml/open_xml.dart' as open_xml;

void main() {
  runApp(const FlutterDeckExample());
}

class FlutterDeckExample extends StatelessWidget {
  const FlutterDeckExample({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterDeckApp(
      client: FlutterDeckWebClient(),
      // You could use the default configuration or create your own.
      configuration: FlutterDeckConfiguration(
        // Define a global background for the light and dark themes separately.
        background: const FlutterDeckBackgroundConfiguration(
          light: FlutterDeckBackground.gradient(
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFDEE9), Color(0xFFB5FFFC)],
            ),
          ),
          dark: FlutterDeckBackground.gradient(
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF16222A), Color(0xFF3A6073)],
            ),
          ),
        ),
        controls: FlutterDeckControlsConfiguration(
          presenterToolbarVisible: true,
          menuItems: [
            Builder(
              builder: (context) {
                final messenger = ScaffoldMessenger.of(context);
                final deck = context.flutterDeck;
                final navigator = Navigator.of(context);

                return MenuItemButton(
                  leadingIcon: const Icon(Icons.slideshow_rounded),
                  onPressed: () async {
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
                      await _exportPptx(
                        navigator.overlay!.context,
                        deck,
                        onProgress: (progress) => progressNotifier.value = progress,
                      );

                      messenger.hideCurrentSnackBar();
                      messenger.showSnackBar(const SnackBar(content: Text('Exported presentation as PPTX!')));
                    } catch (e, t) {
                      debugPrint('Failed to export presentation: $e\n$t');
                      messenger.hideCurrentSnackBar();
                      messenger.showSnackBar(SnackBar(content: Text('Failed to export presentation: $e')));
                    }
                  },
                  child: const Text('Export as PPTX'),
                );
              },
            ),
          ],
        ),
        // Set defaults for the footer.
        footer: const FlutterDeckFooterConfiguration(showSlideNumbers: true, showSocialHandle: true),
        // Set defaults for the header.
        header: const FlutterDeckHeaderConfiguration(showHeader: false),
        // Override the default marker configuration.
        marker: const FlutterDeckMarkerConfiguration(color: Colors.cyan, strokeWidth: 8),
        // Show progress indicator with specifc gradient and background color.
        progressIndicator: const FlutterDeckProgressIndicator.gradient(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink, Colors.purple],
          ),
          backgroundColor: Colors.black,
        ),
        // Use a custom slide size.
        slideSize: FlutterDeckSlideSize.fromAspectRatio(
          aspectRatio: const FlutterDeckAspectRatio.ratio16x9(),
          resolution: const FlutterDeckResolution.fhd(),
        ),
        // Use a custom transition between slides.
        transition: const FlutterDeckTransition.fade(),
      ),
      // You can also define your own light...
      lightTheme: FlutterDeckThemeData.fromTheme(
        ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB5FFFC)), useMaterial3: true),
      ),
      // ...and dark themes.
      darkTheme: FlutterDeckThemeData.fromTheme(
        ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF16222A), brightness: Brightness.dark),
          useMaterial3: true,
        ),
      ),
      // Presentation is build automatically from the list of slides.
      slides: [
        const TitleSlide(),
        const LayoutStructureSlide(),
        const BlankSlide(),
        const SplitSlide(),
        const ImageSlide(),
        const BigFactSlide(),
        const QuoteSlide(),
        const FooterSlide(),
        const HiddenSlide(),
        const DrawerSlide(),
        const MarkerSlide(),
        const ThemingSlide(),
        const BackgroundSlide(),
        const LocalizationSlide(),
        const TransitionsSlide(),
        const StepsSlide(),
        const CodeHighlightSlide(),
        // You can use any widget as a slide.
        Scaffold(
          backgroundColor: Colors.blue,
          body: Builder(
            builder: (context) => Center(
              child: Text('You can use any widget as a slide!', style: FlutterDeckTheme.of(context).textTheme.title),
            ),
          ),
        ),
        // You can use the FlutterDeckSlide widgets without subclassing them.
        FlutterDeckSlide.title(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/end',
            title: 'Thank you!',
            speakerNotes: '- Use flutter_deck to create your own slides.',
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
          title: 'Thank you! 👋',
          subtitle: "Now it's your turn to use flutter_deck!",
        ),
      ],
      // Do not forget to introduce yourself!
      speakerInfo: const FlutterDeckSpeakerInfo(
        name: 'Flutter Deck',
        description: 'The power of Flutter, in your presentations.',
        socialHandle: 'flutter_deck',
        imagePath: 'assets/flutter_logo.png',
      ),
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

Future<void> _exportPptx(BuildContext context, FlutterDeck deck, {required ValueChanged<double> onProgress}) async {
  final fs = MemoryFileSystem();
  final pres = await open_xml.Presentation.create(fs);
  final slides = deck.router.slides;

  if (context.mounted) {
    await precacheImage(const AssetImage('assets/header.png'), context);
    await precacheImage(const AssetImage('assets/flutter_logo.png'), context);
    await precacheImage(const AssetImage('assets/dog_complete_drawing.jpeg'), context);
  }

  // Use a custom configuration for export (e.g. 16:9 1080p)
  final exportConfig = deck.globalConfiguration.copyWith(
    slideSize: FlutterDeckSlideSize.fromAspectRatio(
      aspectRatio: const FlutterDeckAspectRatio.ratio16x9(),
      resolution: const FlutterDeckResolution.fhd(),
    ),
    showProgress: false,
  );
  pres.setAspectRatio(open_xml.PresentationAspectRatio.widescreen_16_9);

  var slideIndex = 0;

  for (var i = 0; i < slides.length; i++) {
    final slide = slides[i];
    final steps = slide.configuration.steps;
    final speakerNotes = slide.configuration.speakerNotes;

    for (var step = 1; step <= steps; step++) {
      onProgress((i + 1) / slides.length);
      debugPrint('Exporting Slide $i, Step $step');

      final bytes = await deck.exportSlide(
        context,
        slide.widget, // Pass the widget directly
        configuration: exportConfig,
        stepNumber: step,
      );

      final fileName = 'slide_${(slideIndex++).toString().padLeft(5, '0')}.png';

      // Write image to memory fs
      final imageFile = fs.file(fileName);
      await imageFile.writeAsBytes(bytes);

      final pptxSlide = pres.addSlide();

      // Add image as background
      pptxSlide.setBackground(open_xml.ImageBackground(fileName, mode: open_xml.ImageStretchMode()));

      // Set transition
      pptxSlide.setTransition(open_xml.FadeTransition());

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

  await FileSaver.instance.saveFile(
    name: 'flutter_deck_presentation.pptx',
    bytes: pptxBytes,
    mimeType: MimeType.microsoftPresentation,
  );
}
