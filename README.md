# flutter_deck

![Pub Version](https://img.shields.io/pub/v/flutter_deck?colorB=blue)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/mkobuolys/flutter_deck/build-gh-pages.yaml?logo=github)
![GitHub Repo stars](https://img.shields.io/github/stars/mkobuolys/flutter_deck?style=flat&logo=github&colorB=deeppink&label=stars)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![flutter_deck docs](https://img.shields.io/badge/flutter__deck-docs-blueviolet?style=flat&label=flutter_deck)](https://flutterdeck.dev)
![FlutterDeck Header](https://github.com/mkobuolys/flutter_deck/blob/main/images/header.png?raw=true)

A lightweight, customizable, and easy-to-use framework to create presentations in Flutter.

Live demo: [https://flutterdeck.dev/demo](https://flutterdeck.dev/demo)

## 🪄 Features

- 💙 Slide deck is built as any other Flutter app.
- 🧭 Navigator 2.0 support - each slide is rendered as an individual page with a deep link to it.
- 🐾 Steps - each slide can have multiple steps that can be navigated through.
- 🎓 Presenter view - control your presentation from a separate screen or (even) device.
- ⚙️ Define a global configuration once and override it per slide if needed.
- 🚀 Predictable API to access the slide deck state and its methods from anywhere in the app.
- 📦 Out of the box slide templates, widgets, transitions and controls.
- 🎨 Custom theming and light/dark mode support.
- 🌍 Built-in localization support.

## 📚 Documentation

The official documentation is available at https://flutterdeck.dev.

## 📦 Packages

| Package                                                                                                       | Pub                                                                               | Description                                                                                                      |
| ------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| [flutter_deck](https://pub.dev/packages/flutter_deck)                                                         | ![Pub Version](https://img.shields.io/pub/v/flutter_deck?colorB=blue)             | The core package that provides the main functionality to create presentations.                                   |
| [flutter_deck_client](https://pub.dev/packages/flutter_deck_client)                                           | ![Pub Version](https://img.shields.io/pub/v/flutter_deck_client?colorB=blue)      | A common client interface and models for the flutter_deck presenter view.                                        |
| [flutter_deck_web_client](https://pub.dev/packages/flutter_deck_web_client)                                   | ![Pub Version](https://img.shields.io/pub/v/flutter_deck_web_client?colorB=blue)  | A Web client implementation for the flutter_deck presenter view.                                                 |
| [flutter_deck_ws_client](https://pub.dev/packages/flutter_deck_ws_client)                                     | ![Pub Version](https://img.shields.io/pub/v/flutter_deck_ws_client?colorB=blue)   | A WebSocket client implementation for the flutter_deck presenter view.                                           |
| [flutter_deck_ws_server](https://github.com/mkobuolys/flutter_deck/tree/main/packages/flutter_deck_ws_server) | -                                                                                 | A WebSocket server for flutter_deck_ws_client implemented using [dart_frog](https://pub.dev/packages/dart_frog). |
| [flutter_deck_pdf_export](https://pub.dev/packages/flutter_deck_pdf_export)                                   | ![Pub Version](https://img.shields.io/pub/v/flutter_deck_pdf_export?colorB=blue)  | A flutter_deck plugin to export presentations to PDF format.                                                     |
| [flutter_deck_pptx_export](https://pub.dev/packages/flutter_deck_pptx_export)                                 | ![Pub Version](https://img.shields.io/pub/v/flutter_deck_pptx_export?colorB=blue) | A flutter_deck plugin to export presentations to PPTX format.                                                    |

## 💻 Installation

**❗ In order to start using flutter_deck you must have the [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.**

Add `flutter_deck` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_deck:
```

Install it:

```sh
flutter packages get
```

## 👋 Hello flutter_deck!

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
      gestures: FlutterDeckGesturesConfiguration.mobileOnly(),
      shortcuts: FlutterDeckShortcutsConfiguration(
        enabled: true,
        nextSlide: const {SingleActivator(LogicalKeyboardKey.arrowRight)},
        previousSlide: const {SingleActivator(LogicalKeyboardKey.arrowLeft)},
        toggleMarker: const {
          SingleActivator(
            LogicalKeyboardKey.keyM,
            control: true,
            meta: true,
          ),
        },
        toggleNavigationDrawer: const {
          SingleActivator(
            LogicalKeyboardKey.period,
            control: true,
            meta: true,
          ),
        },
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

## 🧑‍💻 Maintainers

- [Mangirdas Kazlauskas](https://github.com/mkobuolys)
