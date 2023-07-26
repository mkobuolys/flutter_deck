import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class SplitSlide extends FlutterDeckSplitSlide {
  const SplitSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/split-slide',
            header: FlutterDeckHeaderConfiguration(
              title: 'Split slide template',
            ),
          ),
        );

  @override
  Widget left(BuildContext context) {
    return Center(
      child: Text(
        'Split Slide template renders two columns, one on the left and one on '
        'right.',
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget right(BuildContext context) {
    return Center(
      child: Text(
        'If 50/50 split is not your thing, you can change the ratio based on '
        'your needs.\nAs well as background colors of each section.\nAs well '
        'as header.\nAs well as footer...',
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
