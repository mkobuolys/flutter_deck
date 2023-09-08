import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class ThemingSlide extends FlutterDeckSlideWidget {
  const ThemingSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/theming-slide',
            header: FlutterDeckHeaderConfiguration(title: 'Theming'),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          'Theming',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
