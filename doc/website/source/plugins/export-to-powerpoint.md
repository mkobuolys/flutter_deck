---
title: Export to PowerPoint
navOrder: 4
---

The export to PPTX feature allows you to export your slide deck to a PowerPoint presentation. The export feature is available in the presenter toolbar.

## Usage

To use the export to PPTX feature, you need to add the [flutter_deck_pptx_export](https://pub.dev/packages/flutter_deck_pptx_export) dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_deck_pptx_export:
```

Then, add the `FlutterDeckPptxExportPlugin` to your `FlutterDeckApp`:

```dart
FlutterDeckApp(
  // ...
  plugins: [
    FlutterDeckPptxExportPlugin(),
  ],
);
```
