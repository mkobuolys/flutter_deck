import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_example/l10n/l10n.dart';
import 'package:flutter_deck_example/slides/slides.dart';
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
        // Set defaults for the footer.
        footer: const FlutterDeckFooterConfiguration(
          showSlideNumbers: true,
          showSocialHandle: true,
        ),
        // Set defaults for the header.
        header: const FlutterDeckHeaderConfiguration(
          showHeader: false,
        ),
        // Override the default marker configuration.
        marker: const FlutterDeckMarkerConfiguration(
          color: Colors.cyan,
          strokeWidth: 8,
        ),
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
        ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFB5FFFC),
          ),
          useMaterial3: true,
        ),
      ),
      // ...and dark themes.
      darkTheme: FlutterDeckThemeData.fromTheme(
        ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF16222A),
            brightness: Brightness.dark,
          ),
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
              child: Text(
                'You can use any widget as a slide!',
                style: FlutterDeckTheme.of(context).textTheme.title,
              ),
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
