---
name: flutter-deck-plugins
description: >
  Create, register, or extend flutter_deck plugins by subclassing
  FlutterDeckPlugin to add presenter-menu controls, share state across slides,
  hook into presentation lifecycle events, or subscribe to the FlutterDeck
  instance's controls/drawer/marker/theme/localization notifiers. Use this
  skill when building autoplay toggles, custom laser pointers, clear-screen
  tools, PDF/PPTX exporters, global InheritedWidget/Provider wrappers, looking
  up another plugin via maybeGetPlugin, or wiring built-in plugins like
  FlutterDeckAutoplayPlugin, FlutterDeckPdfExportPlugin,
  FlutterDeckPptxExportPlugin, or FlutterDeckWebClient — even when the user
  only says "add a custom toolbar button" or "share state between slides"
  without mentioning the word "plugin".
compatibility: >
  Requires a Flutter project with the flutter_deck package added as a
  dependency.
---

# Creating and Using Plugins in Flutter Deck

## Overview

Plugins in `flutter_deck` provide an elegant way to globally inject side-effects, state management, or custom overlay UI components into a presentation. By extending `FlutterDeckPlugin`, you can hook into the presentation lifecycle. Plugins typically perform operations such as wrapping the entire slide deck inside an `InheritedWidget` / `Provider` so that all slides can access the state, handling setup and teardown logic, or extending the presenter's control menu with custom interactive buttons.

Plugins are designed to be reusable components that can be shared across multiple slide decks (e.g., by publishing to [pub.dev](https://pub.dev/)).

## When to Use This Skill

- When you want to add custom control actions or tools available in the presenter's menu (e.g., an Autoplay toggle, a custom laser pointer, a "Clear Screen" tool).
- When you need to listen to global presentation lifecycle events or initialize services distinct to the `flutter_deck` runtime.
- When you need to share complex state (e.g., fetching network data, websockets, dynamic theme logic) across multiple slides.

## Implementation Checklist

- [ ] Create a new class extending `FlutterDeckPlugin`.
- [ ] Determine if initialization or cleanup is needed. If so, override `init()` and `dispose()`.
- [ ] If you want the plugin to be controllable by the presenter, override `buildControls()` using `FlutterDeckPluginMenuItemBuilder`.
- [ ] If the plugin provides data or state to the slides, override `wrap()` to wrap the `child` in an `InheritedWidget` or specialized `Provider`.
- [ ] Instantiate and add the new plugin to the `plugins` list array in `FlutterDeckApp`.

---

## Registering Plugins

Plugins are passed as a list to the `FlutterDeckApp`.

```dart
class MyDeck extends StatelessWidget {
  const MyDeck({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterDeckApp(
      configuration: const FlutterDeckConfiguration(
        // ...
      ),
      plugins: [
        MyPlugin(),
      ],
      slides: [
        // ...
      ],
    );
  }
}
```

## Creating a Custom Plugin

To create a plugin, extend the `FlutterDeckPlugin` class. This class has four methods: `init`, `dispose`, `buildControls`, and `wrap`.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class MyPlugin extends FlutterDeckPlugin {
  const MyPlugin();

  @override
  void init(FlutterDeck flutterDeck) {
    print('MyPlugin initialized');
  }

  @override
  void dispose() {
    print('MyPlugin disposed');
  }

  @override
  List<Widget> buildControls(BuildContext context, FlutterDeckPluginMenuItemBuilder menuItemBuilder) {
    return [
      menuItemBuilder(
        context,
        label: 'Show message',
        icon: const Icon(Icons.message),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Hello from MyPlugin!'),
            ),
          );
        },
      ),
    ];
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return SomeProvider(
      child: child,
    );
  }
}
```

## Accessing Plugins and Deck State

You can access the global `FlutterDeck` instance through the `init` parameter, or anywhere in the widget tree via `context.flutterDeck`. The instance exposes a stable read/listen API:

**Navigation & current state**
- `goToSlide(int slideNumber)` / `goToStep(int stepNumber)` — programmatic navigation.
- `slideNumber` / `stepNumber` — getters for the current position.
- `configuration` — the current slide's `FlutterDeckSlideConfiguration` (already merged with global).
- `globalConfiguration` — the original `FlutterDeckConfiguration` from `FlutterDeckApp`.
- `speakerInfo` — the optional `FlutterDeckSpeakerInfo`.

**Reactive notifiers** (subscribe with `addListener`, read `.value`)
- `controlsNotifier` — toolbar / shortcut state.
- `drawerNotifier` — navigation drawer open/closed.
- `localizationNotifier` — current locale.
- `markerNotifier` — marker tool active state and strokes.
- `themeNotifier` — current `ThemeMode` and `FlutterDeckThemeData`.
- `presenterController` — presenter view connection state.

**Plugin discovery**
- `maybeGetPlugin<T extends FlutterDeckPlugin>()` — find another registered plugin by type, e.g. `flutterDeck.maybeGetPlugin<FlutterDeckAutoplayPlugin>()`. Returns `null` if absent.

If your plugin provides state via the `wrap` method using an InheritedWidget, slides can use standard Flutter conventions (e.g., `SomeProvider.of(context)`) to access their data.

## Built-in and First-party Plugins

flutter_deck ships one built-in plugin and several first-party packages in this monorepo. Reach for these before writing your own:

- **`FlutterDeckAutoplayPlugin`** (in core) — adds an autoplay submenu to the presenter controls. Canonical reference for a real plugin: shows lifecycle, nested submenu via `menuItemBuilder`, and notifier subscription.
- **`flutter_deck_web_client`** — `FlutterDeckWebClient()`, required for the presenter view on web. Pass it to `FlutterDeckApp.client`.
- **`flutter_deck_pdf_export`** — `FlutterDeckPdfExportPlugin()`, exports the deck to PDF.
- **`flutter_deck_pptx_export`** — `FlutterDeckPptxExportPlugin()`, exports the deck to PPTX.

Register them on `FlutterDeckApp.plugins` in the order you want their `wrap()` calls to compose (earlier plugins end up outermost):

```dart
FlutterDeckApp(
  plugins: [
    FlutterDeckAutoplayPlugin(),
    FlutterDeckPdfExportPlugin(),
    FlutterDeckPptxExportPlugin(),
  ],
  // ...
);
```

## Gotchas

- `FlutterDeckPlugin` is `abstract`. You must extend it — `FlutterDeckPlugin()` cannot be instantiated directly.
- All four hooks (`init`, `dispose`, `buildControls`, `wrap`) have safe no-op defaults. Override only what your plugin actually needs.
- `init(FlutterDeck flutterDeck)` runs **once** when the deck is created and `dispose()` runs **once** when it's torn down. Do not place per-slide logic in either — react to slide changes via `flutterDeck` listeners instead.
- When multiple plugins each override `wrap()`, they compose in `FlutterDeckApp.plugins` list order. The first plugin in the list ends up **outermost** in the widget tree — order matters when wrappers depend on each other.
- Inside slides, prefer `context.flutterDeck` over capturing the `FlutterDeck` reference from `init` — it's the canonical way and survives hot reload.
- `buildControls` items are added to the existing presenter menu — return menu items via `menuItemBuilder` to match the built-in look. Returning raw widgets bypasses styling.
