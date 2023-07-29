import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_example/slides/slides.dart';

void main() {
  runApp(const FlutterDeckExample());
}

class FlutterDeckExample extends StatelessWidget {
  const FlutterDeckExample({super.key});

  @override
  Widget build(BuildContext context) {
    // This is an entry point for the Flutter Deck app.
    return FlutterDeckApp(
      // You could use the default configuration or create your own.
      configuration: const FlutterDeckConfiguration(
        footer: FlutterDeckFooterConfiguration(
          showSlideNumbers: true,
          showSocialHandle: true,
        ),
        transition: FlutterDeckTransition.fade(),
      ),
      slides: const [
        TitleSlide(),
        LayoutStructureSlide(),
        BlankSlide(),
        SplitSlide(),
        ImageSlide(),
        TransitionsSlide(),
        DrawerSlide(),
        StepsSlide(),
        CodeHighlightSlide(),
        EndSlide(),
      ],
      // Introduce yourself!
      speakerInfo: const FlutterDeckSpeakerInfo(
        name: 'Flutter Deck',
        description: 'The power of Flutter, in your presentations.',
        socialHandle: 'flutter_deck',
        imagePath: 'assets/flutter_logo.png',
      ),
    );
  }
}
