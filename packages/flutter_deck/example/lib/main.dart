import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_example/l10n/l10n.dart';
import 'package:flutter_deck_example/shortcuts/shortcuts.dart';
import 'package:flutter_deck_example/slides/slides.dart';
import 'package:flutter_deck_example/templates/templates.dart';
import 'package:flutter_deck_pdf_export/flutter_deck_pdf_export.dart';
import 'package:flutter_deck_pptx_export/flutter_deck_pptx_export.dart';
import 'package:flutter_deck_web_client/flutter_deck_web_client.dart';

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
        // Update controls and add custom shortcuts.
        controls: const FlutterDeckControlsConfiguration(
          shortcuts: FlutterDeckShortcutsConfiguration(customShortcuts: [SkipSlideShortcut()]),
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
        // Override default slide templates.
        templateOverrides: FlutterDeckTemplateOverrideConfiguration(
          titleSlideBuilder: (_, title, subtitle, _, _, _, _) => TitleSlideTemplate(title: title, subtitle: subtitle),
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
      // Add custom functionality using plugins.
      plugins: [FlutterDeckAutoplayPlugin(), FlutterDeckPptxExportPlugin(), FlutterDeckPdfExportPlugin()],
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
        const PresenterSlide(),
        const PluginsSlide(),
        // You can use any widget as a slide.
        const _CounterSlideWidget().withSlideConfiguration(
          const FlutterDeckSlideConfiguration(
            route: '/custom-widget-as-slide',
            title: 'Using custom widgets as slides',
          ),
        ),
        // You can use the FlutterDeckSlide widgets without subclassing them.
        FlutterDeckSlide.title(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/end',
            title: 'Thank you!',
            speakerNotes: '- Please consider using flutter_deck for your next Flutter presentation.',
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
          title: 'Thank you! 👋',
          subtitle: 'Please consider using flutter_deck for your next Flutter presentation.',
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

class _CounterSlideWidget extends StatefulWidget {
  const _CounterSlideWidget();

  @override
  State<_CounterSlideWidget> createState() => _CounterSlideWidgetState();
}

class _CounterSlideWidgetState extends State<_CounterSlideWidget> {
  var _count = 0;

  void _increment() => setState(() => _count++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You can use any widget as a slide!', style: FlutterDeckTheme.of(context).textTheme.title),
            const SizedBox(height: 32),
            Transform.scale(
              scale: 2,
              child: FilledButton(onPressed: _increment, child: Text('Click counter: $_count')),
            ),
          ],
        ),
      ),
    );
  }
}
