---
title: Auto-Play
navOrder: 2
---

The auto-play feature allows you to automatically navigate through the slide deck. It can be used to create a presentation that runs on its own. The auto-play feature is available in the presenter toolbar.

![Auto-play demo](https://github.com/mkobuolys/flutter_deck/blob/main/images/autoplay.gif?raw=true)

## Usage

To use the auto-play feature, you need to add the `FlutterDeckAutoplayPlugin` to your `FlutterDeckApp`:

```dart
FlutterDeckApp(
  // ...
  plugins: [
    FlutterDeckAutoplayPlugin(),
  ],
);
```
