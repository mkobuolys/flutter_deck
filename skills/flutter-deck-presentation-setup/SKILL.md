---
name: flutter-deck-presentation-setup
description: >
  Scaffold a new flutter_deck presentation from an empty Flutter project —
  wiring up FlutterDeckApp with slides, light/dark themes, speaker info,
  plugins, the web client for presenter view, and localization — and laying
  out a scalable lib/slides/ + barrel-file architecture with optional
  plugins/, shortcuts/, templates/, l10n/, theme.dart, widgets/, and embedded
  packages/ directories. Use this skill when starting a new presentation,
  converting the default Flutter counter app into a deck, restructuring an
  ad-hoc presentation, or wiring up the entry point in main.dart — even when
  the user only says "set up flutter_deck", "build a slide deck app", or
  "make a Flutter presentation" without naming the architecture.
compatibility: >
  Requires the Flutter SDK. The skill will add flutter_deck as a dependency.
---

# Creating a New Presentation with Flutter Deck

## Overview

This skill covers the standard architecture and implementation steps to transform an empty Flutter project into a scalable `flutter_deck` presentation. Based on official examples and complex real-world talks, the community-standard architecture separates the entry point (`main.dart`), the unified theme data (`theme.dart`), and individual slide definitions. For large presentations, slides are grouped into logical sub-folders within the `slides` directory, and their groupings are exported via barrel files. This pattern prevents `main.dart` from bloating when your presentation grows past 20 slides.

## When to Use This Skill

- When starting a brand new presentation.
- When scaffolding the default flutter counter app into a presentation workspace.
- When restructuring an ad-hoc presentation into the officially recommended architecture.

## Implementation Checklist

- [ ] Create a new Flutter project (`flutter create my_presentation`).
- [ ] Add `flutter_deck` dependency (`flutter pub add flutter_deck`).
- [ ] Create the `lib/slides/` directory and a root `lib/slides/slides.dart` barrel file.
- [ ] Group related slides into sub-folders (e.g., `lib/slides/intro/`), exporting `const introSlides = [...]` from a section barrel (`intro/intro.dart`).
- [ ] Clear `lib/main.dart` and initialize `FlutterDeckApp` with `slides:`, `lightTheme:`, `darkTheme:`, and `speakerInfo:`. Define themes inline at first; extract to `lib/theme.dart` only when they grow.
- [ ] (Optional) Add `client: FlutterDeckWebClient()` for presenter view on web, `plugins:` for autoplay/exports, and `localizationsDelegates`/`supportedLocales` for localized decks.

---

## Architecture & File Structure

A maintainable presentation project structures its files systematically. The example app at `packages/flutter_deck/example/` is the canonical reference — its layout is reproduced below. Directories marked **(optional)** only matter once the deck reaches that complexity.

```text
my_presentation/
 ├── lib/
 │   ├── main.dart       <- The entry point, configuring FlutterDeckApp
 │   ├── slides/         <- All individual slides
 │   │   ├── slides.dart <- Root barrel file re-exporting every slide / section
 │   │   ├── title_slide.dart
 │   │   └── intro/      <- (optional) Section grouping for larger talks
 │   │       ├── intro.dart  <- `const introSlides = [ IntroOneSlide(), IntroTwoSlide() ];`
 │   │       ├── intro_one_slide.dart
 │   │       └── intro_two_slide.dart
 │   ├── plugins/        <- (optional) Custom FlutterDeckPlugin implementations
 │   ├── shortcuts/      <- (optional) Custom FlutterDeckShortcut intents/actions
 │   ├── templates/      <- (optional) FlutterDeckTemplateOverrideConfiguration builders
 │   ├── l10n/           <- (optional) AppLocalizations + ARB files when localizing
 │   ├── theme.dart      <- (optional) Extracted PresentationTheme — see below
 │   └── widgets/        <- (optional) Reusable widgets shared across slides
 ├── packages/           <- (optional) Embedded local-workspace packages
 │   └── live_demo_app/  <- A standalone Flutter app imported into a slide
 └── pubspec.yaml
```

### Organizing Auxiliary Components

- **Slides (required)**: Each slide in its own file under `lib/slides/`, re-exported through the `slides.dart` barrel. For larger decks, group slides into sub-folders with their own section barrel that exposes a `const xxxSlides = [...]` array.
- **Plugins**: Custom `FlutterDeckPlugin` implementations go in `lib/plugins/`.
- **Shortcuts**: Custom `FlutterDeckShortcut` subclasses in `lib/shortcuts/`. Wire them up via `FlutterDeckShortcutsConfiguration(customShortcuts: [...])` in `main.dart`.
- **Template Overrides**: Custom builders for `FlutterDeckTemplateOverrideConfiguration` (`titleSlideBuilder`, `splitSlideBuilder`, etc.) in `lib/templates/`.
- **Localization**: When the deck supports multiple languages, put generated localization code in `lib/l10n/` and pass `AppLocalizations.localizationsDelegates` and `AppLocalizations.supportedLocales` to `FlutterDeckApp`.
- **Theme**: For small decks, define `lightTheme` / `darkTheme` inline in `main.dart` (see Step 1). Extract to `lib/theme.dart` once the theme grows beyond a few lines.
- **Embedded Live Demos**: When demonstrating a fully functional Flutter app inside a slide, isolate it as a local `packages/<app_name>` workspace package and import it as a path dependency in `pubspec.yaml`. Putting demo apps inside `lib/` pollutes the deck's analyzer and pub graph.

## Step 1: Defining the Theme

Build `lightTheme` and `darkTheme` with `FlutterDeckThemeData.fromTheme(ThemeData(...))`. The canonical example app (`packages/flutter_deck/example/lib/main.dart`) defines them **inline** — that's the simplest default:

```dart
FlutterDeckApp(
  lightTheme: FlutterDeckThemeData.fromTheme(
    ThemeData.from(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF3366)),
      useMaterial3: true,
    ),
  ),
  darkTheme: FlutterDeckThemeData.fromTheme(
    ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF00E5FF),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    ),
  ),
  // ...
)
```

Once the theme grows past ~10 lines (custom typography, multiple seed colors, brand-specific tweaks), extract it into `lib/theme.dart`:

```dart
class PresentationTheme {
  static const primaryColor = Color(0xFF00E5FF);

  static FlutterDeckThemeData get lightTheme => FlutterDeckThemeData.fromTheme(
        ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          useMaterial3: true,
        ),
      );

  static FlutterDeckThemeData get darkTheme => FlutterDeckThemeData.fromTheme(
        ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
      );
}
```

## Step 2: Creating and Grouping Slides

Inside the `lib/slides/` directory, create your slides. Each slide should be its own file and class, extending `FlutterDeckSlideWidget`.

`lib/slides/title_slide.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class TitleSlide extends FlutterDeckSlideWidget {
  const TitleSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/title',
            title: 'Welcome',
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.title(
      builder: (context) => const FlutterDeckTitleSlide(
        title: 'Building Amazing Slides',
        subtitle: 'With Flutter Deck',
      ),
    );
  }
}
```

For logical sections of your talk, place them in a folder and create a specific barrel defining an array.

`lib/slides/intro/intro.dart`:

```dart
import 'intro_one_slide.dart';
import 'intro_two_slide.dart';

const introSlides = [
  IntroOneSlide(),
  IntroTwoSlide(),
];
```

Finally, export everything in the root `lib/slides/slides.dart`.

`lib/slides/slides.dart`:

```dart
export 'title_slide.dart';
export 'intro/intro.dart';
```

## Step 3: Configuring the Deck (`main.dart`)

Configure `FlutterDeckApp` and pass the grouped arrays from `slides.dart` using the spread operator. `FlutterDeckApp.slides` is typed `List<Widget>` — you can mix `FlutterDeckSlideWidget` subclasses, `FlutterDeckSlide.<factory>(configuration: ...)` constructors used inline, and any widget tagged with `Widget.withSlideConfiguration(...)` in the same list.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

import 'slides/slides.dart';

void main() {
  runApp(const MyPresentation());
}

class MyPresentation extends StatelessWidget {
  const MyPresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterDeckApp(
      configuration: FlutterDeckConfiguration(
        transition: const FlutterDeckTransition.fade(),
        slideSize: FlutterDeckSlideSize.fromAspectRatio(
          aspectRatio: const FlutterDeckAspectRatio.ratio16x10(),
          resolution: const FlutterDeckResolution.fhd(),
        ),
        footer: const FlutterDeckFooterConfiguration(
          showSlideNumbers: true,
          showSocialHandle: true,
        ),
      ),
      lightTheme: FlutterDeckThemeData.fromTheme(
        ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF3366)),
          useMaterial3: true,
        ),
      ),
      darkTheme: FlutterDeckThemeData.fromTheme(
        ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF00E5FF),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
      ),
      speakerInfo: const FlutterDeckSpeakerInfo(
        name: 'Your Name',
        description: 'Your Title',
        socialHandle: '@yourhandle',
        imagePath: 'assets/me.png',
      ),
      slides: [
        const TitleSlide(),
        ...introSlides,
      ],
    );
  }
}
```

### Optional `FlutterDeckApp` Parameters

The full constructor exposes more knobs the example deck uses — none are required, but skip them and you may miss a feature you wanted:

| Parameter | Purpose |
|-----------|---------|
| `client` | The `FlutterDeckClient` for presenter view. Use `FlutterDeckWebClient()` from `package:flutter_deck_web_client` when targeting web. |
| `themeMode` | `ThemeMode.system` (default), `light`, or `dark`. Decides which of `lightTheme`/`darkTheme` is active. |
| `locale` / `localizationsDelegates` / `supportedLocales` | Forwarded to the underlying `MaterialApp`. Use when the deck supports multiple languages — pair with `AppLocalizations` generated under `lib/l10n/`. |
| `plugins` | `List<FlutterDeckPlugin>`. Drop in `FlutterDeckAutoplayPlugin()`, `FlutterDeckPdfExportPlugin()` (from `flutter_deck_pdf_export`), `FlutterDeckPptxExportPlugin()` (from `flutter_deck_pptx_export`), or your own. |
| `navigatorObservers` | Forwarded to the underlying router. Useful for analytics. |
| `isPresenterView` | On non-web platforms, force the app to launch as the presenter view instead of the audience view. Requires `client`. |

Inside `FlutterDeckConfiguration`, `templateOverrides: FlutterDeckTemplateOverrideConfiguration(...)` lets you replace built-in slide templates deck-wide (see the `flutter-deck-configuration` skill).

By following this architecture, you easily scale your presentation regardless of how many slides or custom widgets it contains!

## Gotchas

- Embedded live-demo Flutter apps go in `packages/<app_name>/` and are added as path dependencies in `pubspec.yaml`. Putting them inside `lib/` pollutes the deck's analyzer, test runner, and import graph.
- The order of slides in the final `FlutterDeckApp.slides` list **is** the presentation order. Adding a slide file but forgetting to export it from a barrel (or include it in the section array) leaves it dead.
- Group barrels (e.g. `intro/intro.dart`) export an `const introSlides = [...]` array. The root `slides.dart` re-exports those barrels (so consumers import a single file). Use the spread operator `...introSlides` when assembling the final slide list.
- Run `flutter pub add flutter_deck` rather than hand-editing `pubspec.yaml` so dependency resolution and lockfile updates stay consistent.
- `FlutterDeckApp.slides` is typed `List<Widget>`, **not** `List<FlutterDeckSlideWidget>`. The framework wraps non-slide widgets via `withSlideConfiguration` automatically. This is why you can drop `FlutterDeckSlide.title(configuration: ...)` constructors directly into the list without subclassing.
- Presenter view on web requires `FlutterDeckApp.client: FlutterDeckWebClient()` from `package:flutter_deck_web_client`. Without it, opening the presenter URL silently falls back to audience mode.
- The export plugins (`flutter_deck_pdf_export`, `flutter_deck_pptx_export`) are separate packages — `flutter pub add` them alongside `flutter_deck` if the deck needs export buttons.
