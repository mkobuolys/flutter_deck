---
title: Theming
navOrder: 1
---

You can customize the theme of your slide deck by providing a `FlutterDeckThemeData` to the `FlutterDeckApp` widget:

```dart
return FlutterDeckApp(
  // You can define light...
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
);
```

It's also possible to override the theme for a specific slide. The provided theme data will be merged with the global theme. Meaning, only the properties you specify there are overridden:

```dart
class ThemingSlide extends FlutterDeckSlideWidget {
  const ThemingSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/theming-slide',
            header: FlutterDeckHeaderConfiguration(title: 'Theming'),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      theme: FlutterDeckTheme.of(context).copyWith(
        splitSlideTheme: const FlutterDeckSplitSlideThemeData(
          leftBackgroundColor: Colors.blue,
          leftColor: Colors.yellow,
          rightBackgroundColor: Colors.yellow,
          rightColor: Colors.blue,
        ),
      ),
      leftBuilder: (context) => <...>
      rightBuilder: (context) => <...>
    );
  }
}
```

Also, you can override the theme for a specific flutter deck widget that supports theming (e.g. header, footer, bullet list, code highlight, etc.). Simply, wrap the widget with a corresponding theme widget:

```dart
FlutterDeckSlide.template(
  // Wrap header with a theme widget to override the theme.
  headerBuilder: (context) => FlutterDeckHeaderTheme(
    data: FlutterDeckHeaderThemeData(
      color: Colors.red,
      textStyle: FlutterDeckTheme.of(context).textTheme.header,
    ),
    child: const FlutterDeckHeader(title: 'Header'),
  ),
  // Wrap footer with a theme widget to override the theme.
  footerBuilder: (context) => FlutterDeckFooterTheme(
    data: FlutterDeckFooterThemeData(
      socialHandleColor: Colors.blue,
      socialHandleTextStyle:
          FlutterDeckTheme.of(context).textTheme.bodyMedium,
    ),
    child: const FlutterDeckFooter(showSlideNumber: false),
  ),
  contentBuilder: (context) => Center(
    // Wrap code highlight with a theme widget to override the theme.
    child: FlutterDeckCodeHighlightTheme(
      data: FlutterDeckCodeHighlightThemeData(
        backgroundColor: Colors.green,
        textStyle: FlutterDeckTheme.of(context).textTheme.bodyLarge,
      ),
      child: const FlutterDeckCodeHighlight(code: '<...>'),
    ),
  ),
);
```
