---
title: Controls
navOrder: 1
---

By default, every slide deck comes with a presenter toolbar that can be used to control the slide deck. Also, some of the controls can be accessed by using keyboard shortcuts or touch gestures.

To disable all the controls (e.g. you use your own UI to control the slide deck), set the `controls` property for the slide deck configuration to `FlutterDeckControlsConfiguration.disabled()`:

```dart
FlutterDeckConfiguration(
  controls: FlutterDeckControlsConfiguration.disabled(),
  <...>
)
```

To disable the presenter toolbar, set the `presenterToolbarVisible` property to `false`:

```dart
FlutterDeckConfiguration(
  controls: const FlutterDeckControlsConfiguration(
    presenterToolbarVisible: false,
  ),
  <...>
)
```

To disable the keyboard shortcuts, set the `shortcuts` property to `FlutterDeckShortcutsConfiguration.disabled()`:

```dart
FlutterDeckConfiguration(
  controls: const FlutterDeckControlsConfiguration(
    shortcuts: FlutterDeckShortcutsConfiguration.disabled(),
  ),
  <...>
)
```

To disable the touch gestures, set the `gestures` property to `FlutterDeckGesturesConfiguration.disabled()`:

```dart
FlutterDeckConfiguration(
  controls: const FlutterDeckControlsConfiguration(
    gestures: FlutterDeckGesturesConfiguration.disabled(),
  ),
  <...>
)
```
