import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';

const _navigationDrawerWidth = 400.0;
const _navigationItemHeight = 48.0;

/// A widget that is used as a navigation drawer for the [FlutterDeck].
///
/// This widget renders a list of all the slides in the deck. The user can tap
/// on any slide to navigate to it.
class FlutterDeckDrawer extends StatefulWidget {
  /// Creates a [FlutterDeckDrawer].
  const FlutterDeckDrawer({super.key});

  @override
  State<FlutterDeckDrawer> createState() => _FlutterDeckDrawerState();
}

class _FlutterDeckDrawerState extends State<FlutterDeckDrawer> {
  late final ScrollController _controller;

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller = ScrollController(initialScrollOffset: _initialScrollOffset);
  }

  double get _initialScrollOffset {
    final router = context.flutterDeck.router;
    final itemsCount = router.slides.length;
    final viewHeight = MediaQuery.sizeOf(context).height;

    if (viewHeight >= itemsCount * _navigationItemHeight) return 0;

    final index = router.getCurrentSlideIndex();
    final itemsInView = (viewHeight / _navigationItemHeight).floor();

    if (index < itemsInView / 2) return 0;

    final remainingOffset = viewHeight - itemsInView * _navigationItemHeight;
    final scrollToIndex = math.min(
      index - itemsInView ~/ 3,
      itemsCount - itemsInView,
    );

    return scrollToIndex * _navigationItemHeight - remainingOffset;
  }

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final slides = flutterDeck.router.slides;

    return Drawer(
      width: _navigationDrawerWidth,
      child: ListView.builder(
        controller: _controller,
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
      title: Text(
        _getSlideTitle(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        if (!isActive) context.flutterDeck.goToSlide(slideNumber);

        Navigator.of(context).pop();
      },
    );
  }
}
