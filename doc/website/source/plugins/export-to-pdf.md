---
title: Export to PDF
navOrder: 5
---

The export to PDF feature allows you to export your slide deck to a PDF presentation. The export feature is available in the presenter toolbar.

## Usage

To use the export to PDF feature, you need to add the [flutter_deck_pdf_export](https://pub.dev/packages/flutter_deck_pdf_export) dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_deck_pdf_export:
```

Then, add the `FlutterDeckPdfExportPlugin` to your `FlutterDeckApp`:

```dart
FlutterDeckApp(
  // ...
  plugins: [
    FlutterDeckPdfExportPlugin(),
  ],
);
```
