import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';

/// A widget that is used as a navigation drawer for the [FlutterDeck].
///
/// This widget renders a list of all the slides in the deck. The user can tap
/// on any slide to navigate to it.
class FlutterDeckDrawer extends StatelessWidget {
  /// Creates a [FlutterDeckDrawer].
  const FlutterDeckDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final slides = flutterDeck.router.slides;

    return Drawer(
      child: ListView.builder(
        itemBuilder: (context, index) => _SlideCard(
          slide: slides[index],
          index: index,
        ),
        itemCount: slides.length,
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

  String _getSlideTitle() {
    final configuration = slide.configuration;
    final title = configuration.title;

    if (title != null) return title;

    final header = configuration.header;

    if (header.showHeader) return header.title;

    return configuration.route;
  }

  @override
  Widget build(BuildContext context) {
    final currentSlideNumber = context.flutterDeck.slideNumber;
    final slideNumber = index + 1;
    final isActive = currentSlideNumber == slideNumber;

    return ListTile(
      selected: isActive,
      leading: Text('$slideNumber.'),
      title: Text(_getSlideTitle()),
      onTap: () {
        if (!isActive) context.flutterDeck.goToSlide(slideNumber);

        Navigator.of(context).pop();
      },
    );
  }
}
