import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_example/l10n/l10n.dart';

class LocalizationSlide extends FlutterDeckSlideWidget {
  const LocalizationSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/localization',
            header: FlutterDeckHeaderConfiguration(
              title: 'Slide deck localization',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    final locale = context.l10n.localeName;

    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.l10n.helloWorld,
              style: FlutterDeckTheme.of(context).textTheme.display,
            ),
            const SizedBox(height: 32),
            Text(
              'Current locale: $locale',
              style: FlutterDeckTheme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            Text(
              'It is possible to localize your slide deck using the same '
              'approach as any other Flutter app.\nUse deck controls to change '
              'the locale and see the text change without restarting your '
              'presentation!',
              style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
