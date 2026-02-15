A PPTX export plugin for the [flutter_deck](https://pub.dev/packages/flutter_deck) package.

## About

This package implements the `FlutterDeckPptxExportPlugin`, which allows you to export your `flutter_deck` presentation as a PPTX file.

It works by taking a screenshot of each slide and step and saving them as images in the PPTX file. Note that the exported PPTX file will not contain any interactive elements or animations.

## Setup

This package uses the [file_saver](https://pub.dev/packages/file_saver) package to save the exported PPTX file. Depending on the platform you are targeting, you may need to perform some additional setup.

### macOS

Add the following entitlement to your `macos/Runner/DebugProfile.entitlements` and `macos/Runner/Release.entitlements` files:

```xml
<key>com.apple.security.files.user-selected.read-write</key>
<true/>
```

### iOS

Add the following keys to `ios/Runner/info.plist`:

```xml
<key>LSSupportsOpeningDocumentsInPlace</key>
<true/>
<key>UIFileSharingEnabled</key>
<true/>
```

### Other platforms

Usually, no additional setup is required for basic usage. However, if you encounter any issues, please refer to the [file_saver](https://pub.dev/packages/file_saver) documentation for up-to-date setup instructions.

## Usage

To use this package, add `flutter_deck_pptx_export` as a dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  flutter_deck_pptx_export: any
```

Then, use the `FlutterDeckPptxExportPlugin` class when creating your `FlutterDeckApp` presentation.

```dart
FlutterDeckApp(
  configuration: const FlutterDeckConfiguration(...),
  plugins: [
    FlutterDeckPptxExportPlugin(), // Use the PPTX export plugin
  ],
  slides: [
    <...>
  ],
);
```

The plugin will add a new menu item to the controls menu that allows you to export the presentation.

> **Note:** The plugin uses `localizationsDelegates` and `supportedLocales` from the `FlutterDeckApp` to render the slides correctly during the export process. Ensure these are configured in your `FlutterDeckApp` if your slides use localization.

## Credits

Thanks to [Rody Davis](https://github.com/rodydavis) for the initial code. His package [open_xml](https://pub.dev/packages/open_xml) laid the foundation for the implementation of the PPTX export functionality.
