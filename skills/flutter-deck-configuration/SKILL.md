---
name: flutter-deck-configuration
description: >
  Configure a flutter_deck presentation globally or per-slide — slide size and
  aspect ratio, transitions, backgrounds (solid/gradient/image/custom),
  headers, footers, progress indicators (solid or gradient), keyboard controls
  and custom shortcuts, the marker tool, speaker notes, image preloading,
  template overrides, and per-slide overrides. Use this skill when defining
  FlutterDeckApp's configuration, FlutterDeckConfiguration, or
  FlutterDeckSlideConfiguration — when adding routes, titles, speaker notes,
  or steps; choosing a transition; hiding the footer or header on a specific
  slide; customising the marker, progress indicator, or keyboard shortcuts;
  or replacing a built-in template — even when the user only says "configure
  my deck", "change the slide layout", or "make the title slide different".
compatibility: >
  Requires a Flutter project with the flutter_deck package added as a
  dependency.
---

# Configuring Flutter Deck

## Overview

`flutter_deck` provides a highly flexible configuration system structured at two levels: global configuration and slide-level configuration overrides.

- **Global Configuration** (`FlutterDeckConfiguration`): Defines the baseline rules for the entire presentation, such as the default background, transition animations, control settings (e.g., keyboard shortcuts), and whether universal headers, footers, or progress indicators are visible.
- **Slide-Level Configuration** (`FlutterDeckSlideConfiguration`): Defines requirements specific to a single slide. Every slide must specify a unique routing path (`route`) and can optionally override parts of the global configuration (like hiding the footer for a specific slide or adding a custom title).

## When to Use This Skill

- When initializing the presentation in `main.dart` and setting the default look, feel, and navigation behaviors.
- When turning on/off presenter toolbars, marker tools, and default keyboard shortcuts.
- When setting specific metadata for a slide, such as `speakerNotes` or `preloadImages`.
- When a specific slide needs to break global layout rules (e.g., hiding the global header just for the title slide).

## Implementation Checklist

- [ ] Define the global `FlutterDeckConfiguration` when instantiating `FlutterDeckApp`.
- [ ] Choose the global `slideSize` constraint (e.g., responsive versus a fixed 16:9 ratio).
- [ ] Setup the global `controls`, `footer`, `header`, `progressIndicator`, `transition`, and `background`.
- [ ] For every new slide, instantiate a `FlutterDeckSlideConfiguration` with a unique `route`.
- [ ] If a slide needs to hide universal elements (like the footer or progress bar), pass the appropriate override configurations (e.g., `footer: FlutterDeckFooterConfiguration(showFooter: false)`).
- [ ] (Optional) Provide `preloadImages` for slides with heavy assets to prevent loading pop-in.

---

## Global Configuration Example

The global configuration is provided when initializing `FlutterDeckApp`.

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
      shortcuts: FlutterDeckShortcutsConfiguration(enabled: true),
    ),
    footer: const FlutterDeckFooterConfiguration(showFooter: true, showSlideNumbers: true, showSocialHandle: true),
    header: const FlutterDeckHeaderConfiguration(showHeader: false),
    marker: const FlutterDeckMarkerConfiguration(color: Colors.cyan, strokeWidth: 8.0),
    progressIndicator: const FlutterDeckProgressIndicator.solid(),
    showProgress: true,
    slideSize: FlutterDeckSlideSize.fromAspectRatio(
      aspectRatio: const FlutterDeckAspectRatio.ratio16x9(),
      resolution: const FlutterDeckResolution.fhd(),
    ),
    transition: const FlutterDeckTransition.fade(),
  ),
  slides: const [
    // Your slides here
  ],
)
```

## Slide-level Configuration Overrides

You can override most global configurations for a specific slide via `FlutterDeckSlideConfiguration`. The fields that **can** be overridden per slide are `footer`, `header`, `progressIndicator`, `showProgress`, and `transition`. The fields that are **globally locked** (the global value always wins, even if you pass one to the slide constructor) are `background`, `controls`, `marker`, `slideSize`, and `templateOverrides`.

```dart
class MySpecialSlide extends FlutterDeckSlideWidget {
  const MySpecialSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/special',
            title: 'Special Slide',
            // Overrides global settings:
            header: FlutterDeckHeaderConfiguration(showHeader: false),
            footer: FlutterDeckFooterConfiguration(showFooter: false),
            showProgress: false,
            transition: FlutterDeckTransition.rotation(),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const Center(child: Text('Look Ma, no header!')),
    );
  }
}
```

## Available Transitions

- `FlutterDeckTransition.none()` (default)
- `FlutterDeckTransition.fade()`
- `FlutterDeckTransition.scale()`
- `FlutterDeckTransition.slide()`
- `FlutterDeckTransition.rotation()`
- `FlutterDeckTransition.custom(transitionBuilder: ...)`

## Backgrounds

`FlutterDeckBackgroundConfiguration` accepts a separate `light:` and `dark:` background. Each is built with one of these factories:

- `FlutterDeckBackground.solid(Color)` — a flat color.
- `FlutterDeckBackground.gradient(Gradient)` — any `LinearGradient` / `RadialGradient` / `SweepGradient`.
- `FlutterDeckBackground.image(Image)` — an `Image` widget covering the slide.
- `FlutterDeckBackground.custom(child: Widget)` — any widget tree.
- `FlutterDeckBackground.transparent()` — falls back to `FlutterDeckSlideThemeData.backgroundColor`.

```dart
background: const FlutterDeckBackgroundConfiguration(
  light: FlutterDeckBackground.gradient(
    LinearGradient(colors: [Color(0xFFFEE140), Color(0xFFFA709A)]),
  ),
  dark: FlutterDeckBackground.gradient(
    LinearGradient(colors: [Color(0xFF000428), Color(0xFF004E92)]),
  ),
),
```

## Progress Indicator

Two factories on `FlutterDeckProgressIndicator`:

- `FlutterDeckProgressIndicator.solid({Color? color, Color? backgroundColor})` — a flat bar.
- `FlutterDeckProgressIndicator.gradient({required Gradient gradient, Color? backgroundColor})` — a gradient bar.

```dart
progressIndicator: const FlutterDeckProgressIndicator.gradient(
  gradient: LinearGradient(colors: [Color(0xFF00E5FF), Color(0xFFFA709A)]),
  backgroundColor: Colors.black,
),
```

## Custom Keyboard Shortcuts

Pass a list of `FlutterDeckShortcut` subclasses to `FlutterDeckShortcutsConfiguration.customShortcuts`. Each shortcut binds keyboard activators to an `Intent` + `Action`.

```dart
controls: const FlutterDeckControlsConfiguration(
  shortcuts: FlutterDeckShortcutsConfiguration(
    customShortcuts: [SkipSlideShortcut()],
  ),
),
```

To disable all shortcuts globally, use `FlutterDeckShortcutsConfiguration.disabled()`.

## Replacing Built-in Slide Templates

`FlutterDeckTemplateOverrideConfiguration` lets you swap the rendering of *all* built-in slide factories deck-wide. Provide a builder for any of: `bigFactSlideBuilder`, `blankSlideBuilder`, `imageSlideBuilder`, `quoteSlideBuilder`, `splitSlideBuilder`, `templateSlideBuilder`, `titleSlideBuilder`. Any unset builder keeps the framework default.

```dart
templateOverrides: FlutterDeckTemplateOverrideConfiguration(
  titleSlideBuilder: (_, title, subtitle, _, _, _, _) =>
      MyTitleSlideTemplate(title: title, subtitle: subtitle),
),
```

Use this when every slide of a given factory needs identical custom chrome — it's faster than wrapping each slide individually and applies even when slides are constructed via `FlutterDeckSlide.title(...)` directly.

## Useful Properties

- `route`: The unique path for the slide. (Required)
- `title`: The title shown in the navigation drawer.
- `speakerNotes`: Notes visible only in the presenter view.
- `hidden`: If `true`, the slide is removed from navigation flow.
- `initial`: If `true`, the presentation starts here (useful for web routing without a path).
- `preloadImages`: A `Set<String>` of asset paths/URLs to load before the slide displays.
- `steps`: The number of internal steps the slide has. It is useful for building animations or revealing content sequentially on a single slide. By default `1`.

## Gotchas

- `background`, `controls`, `marker`, `slideSize`, and `templateOverrides` are **globally locked**. Passing them to a slide's `FlutterDeckSlideConfiguration` is silently ignored — `mergeWithGlobal` always copies the global value. Configure these only on `FlutterDeckApp.configuration`.
- Per-slide overrides that actually take effect: `footer`, `header`, `progressIndicator`, `showProgress`, `transition`.
- Routes must be unique across the deck and start with `/`. Duplicate routes fail at startup.
- `steps` defaults to `1` (one tap advances to the next slide). For sequential reveals on a single slide, set `steps: N` so the slide consumes `N` next-key presses before advancing.
- Set `initial: true` on exactly one slide to define the entry point when the deck is opened without a path in the URL — useful for web hosting.
- `preloadImages` accepts both asset paths and remote URLs. Use it on every slide whose image would otherwise visibly pop in.
