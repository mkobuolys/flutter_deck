---
title: Get Started
---

## First Steps

First, create a new Flutter project for your slideshow.

Next, add `flutter_deck` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_deck:
```

You're now ready to leverage the power of `flutter_deck` to quickly assemble a great
slideshow presentation with Flutter widgets and Dart code!

## Hello flutter_deck!

Use `FlutterDeckApp` as your slide deck's root widget and pass a list of widgets as slides:

```dart
void main() {
  runApp(const FlutterDeckExample());
}

class FlutterDeckExample extends StatelessWidget {
  const FlutterDeckExample({super.key});

  @override
  Widget build(BuildContext context) {
    // This is an entry point for the Flutter Deck app.
    return FlutterDeckApp(
      configuration: const FlutterDeckConfiguration(...),
      slides: [
        <...>
      ],
    );
  }
}
```

Also, you can define a global configuration for your slide deck:

```dart
FlutterDeckApp(
  configuration: FlutterDeckConfiguration(
    background: const FlutterDeckBackgroundConfiguration(
      light: FlutterDeckBackground.solid(Color(0xFFB5FFFC)),
      dark: FlutterDeckBackground.solid(Color(0xFF16222A)),
    ),
    controls: const FlutterDeckControlsConfiguration(
      presenterToolbarVisible: true,
      shortcuts: FlutterDeckShortcutsConfiguration(
        enabled: true,
        nextSlide: SingleActivator(LogicalKeyboardKey.arrowRight),
        previousSlide: SingleActivator(LogicalKeyboardKey.arrowLeft),
        toggleMarker: SingleActivator(
          LogicalKeyboardKey.keyM,
          control: true,
          meta: true,
        ),
        toggleNavigationDrawer: SingleActivator(
          LogicalKeyboardKey.period,
          control: true,
          meta: true,
        ),
      ),
    ),
    footer: const FlutterDeckFooterConfiguration(
      showSlideNumbers: true,
      widget: FlutterLogo(),
    ),
    header: const FlutterDeckHeaderConfiguration(
      showHeader: false,
    ),
    marker: const FlutterDeckMarkerConfiguration(
      color: Colors.cyan,
      strokeWidth: 8.0,
    ),
    progressIndicator: const FlutterDeckProgressIndicator.gradient(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.pink, Colors.purple],
      ),
      backgroundColor: Colors.black,
    ),
    slideSize: FlutterDeckSlideSize.fromAspectRatio(
      aspectRatio: const FlutterDeckAspectRatio.ratio16x10(),
      resolution: const FlutterDeckResolution.fromWidth(1440),
    ),
    transition: const FlutterDeckTransition.fade(),
  ),
  <...>
);
```

Use any colors you like:

```dart
FlutterDeckApp(
  lightTheme: FlutterDeckThemeData.light(),
  darkTheme: FlutterDeckThemeData.dark(),
  themeMode: ThemeMode.system,
  <...>
);
```

And do not forget to introduce yourself!

```dart
FlutterDeckApp(
  speakerInfo: const FlutterDeckSpeakerInfo(
    name: 'John Doe',
    description: 'CEO of flutter_deck',
    socialHandle: '@john_doe',
    imagePath: 'assets/me.png',
  ),
  <...>
);
```

## Next Steps

You have a Flutter project with a configured `FlutterDeckApp` widget. Consider exploring the
following guides to build up your slide show:

- [Start theming your presentation](/guides/theming/)
- Create predefined slide types: [titles](/slide-templates/title-slide/), [images](/slide-templates/image-slide/), and [split slides](/slide-templates/split-slide/)
- [Localize your presentation](/guides/localization/)
- [Control your presentation playback](/playback/controls)
