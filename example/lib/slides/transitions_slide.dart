import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class TransitionsSlide extends FlutterDeckSplitSlide {
  const TransitionsSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/transitions',
            header: FlutterDeckHeaderConfiguration(title: 'Slide transitions'),
            transition: FlutterDeckTransition.rotation(),
          ),
        );

  @override
  Widget left(BuildContext context) {
    return FlutterDeckBulletList(
      items: const [
        'None (default)',
        'Fade',
        'Scale',
        'Slide',
        'Rotation',
        'Custom',
      ],
    );
  }

  @override
  Widget right(BuildContext context) {
    return Center(
      child: Text(
        'flutter_deck comes with a few built-in transitions. You can also '
        'create your own.\n\nYou can set the transition for the whole deck '
        'or for individual slides.\n\nAs you saw, this slide uses a "Rotation" '
        'transition 😵‍💫',
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
