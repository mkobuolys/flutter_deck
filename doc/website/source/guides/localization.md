---
title: Localization
navOrder: 7
---
This package comes with a built-in localization support. You can change the locale of the slide deck at runtime (see [controls](#controls)). The updated locale will be applied to the whole slide deck.

To localize the slide deck, follow the instructions provided in the [official Flutter documentation](https://flutter.dev/docs/development/accessibility-and-localization/internationalization).

Then, provide `AppLocalizations` when creating the slide deck:

```dart
FlutterDeckApp(
  <...>
  locale: const Locale('en'), // The initial locale of the slide deck
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
);
```