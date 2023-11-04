import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';

/// A widget that used as a navigation drawer for the [FlutterDeck].
///
/// This widget renders a [FlutterDeckThemeSwitcher] to switch between light and
/// dark themes and a list of all the slides in the deck. The user can tap on
/// any slide to navigate to it.
class FlutterDeckDrawer extends StatelessWidget {
  /// Creates a [FlutterDeckDrawer].
  const FlutterDeckDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final slides = flutterDeck.router.slides;

    return Drawer(
      child: Column(
        children: [
          const FlutterDeckThemeSwitcher(),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => _SlideCard(
                slide: slides[index],
                index: index,
              ),
              itemCount: slides.length,
            ),
          ),
          const Divider(),
          const _Actions(),
        ],
      ),
    );
  }
}

class _SlideCard extends StatelessWidget {
  const _SlideCard({
    required this.slide,
    required this.index,
  });

  final FlutterDeckRouterSlide slide;
  final int index;

  @override
  Widget build(BuildContext context) {
    final currentSlideNumber = context.flutterDeck.slideNumber;
    final slideNumber = index + 1;
    final isActive = currentSlideNumber == slideNumber;

    return ListTile(
      selected: isActive,
      leading: Text('$slideNumber.'),
      title: Text(slide.configuration.route),
      onTap: () {
        if (!isActive) context.flutterDeck.goToSlide(slideNumber);

        Navigator.of(context).pop();
      },
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            onPressed: () {
              context.flutterDeck.controlsNotifier.toggleMarker();
              Navigator.of(context).pop();
            },
            tooltip: 'Use marker',
          ),
        ],
      ),
    );
  }
}
