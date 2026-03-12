---
title: Global configuration
navOrder: 2
---

# Global configuration

The global configuration for the slide deck allows you to define the default settings for all slides in your presentation. You can configure the background, controls, footer, header, progress indicator, and more.

Some of these configurations can be overridden on a per-slide basis. For more information, see the [Slide configuration](slide-configuration.md) guide.

## Defining the global configuration

You can define the global configuration by passing a `FlutterDeckConfiguration` object to the `FlutterDeckApp` widget.

```dart
FlutterDeckApp(
  configuration: const FlutterDeckConfiguration(
    background: FlutterDeckBackgroundConfiguration(
      light: FlutterDeckBackground.solid(Color(0xFFB5FFFC)),
      dark: FlutterDeckBackground.solid(Color(0xFF16222A)),
    ),
    controls: FlutterDeckControlsConfiguration(
      presenterToolbarVisible: true,
      gestures: FlutterDeckGesturesConfiguration.mobileOnly(),
      shortcuts: FlutterDeckShortcutsConfiguration(
        enabled: true,
      ),
    ),
    footer: FlutterDeckFooterConfiguration(
      showFooter: true,
      showSlideNumbers: true,
      showSocialHandle: true,
    ),
    header: FlutterDeckHeaderConfiguration(
      showHeader: false,
    ),
    marker: FlutterDeckMarkerConfiguration(
      color: Colors.cyan,
      strokeWidth: 8.0,
    ),
    progressIndicator: FlutterDeckProgressIndicator.solid(),
    showProgress: true,
    slideSize: FlutterDeckSlideSize.responsive(),
    transition: FlutterDeckTransition.fade(),
  ),
  slides: const [
    // ...
  ],
);
```

## Configuration properties

### Background

The `background` property configures the default background for the slide deck using `FlutterDeckBackgroundConfiguration`. By default, the background is transparent and the `FlutterDeckSlideThemeData.backgroundColor` is used.

You can specify different backgrounds for light and dark themes:

```dart
const FlutterDeckConfiguration(
  background: FlutterDeckBackgroundConfiguration(
    light: FlutterDeckBackground.solid(Colors.white),
    dark: FlutterDeckBackground.solid(Colors.black),
  ),
)
```

_Note: This configuration cannot be overridden by the slide configuration, but rather by passing a background builder to the specific slide._

### Controls

The `controls` property configures the controls for the slide deck using `FlutterDeckControlsConfiguration`. By default, the presenter toolbar is visible, the default keyboard controls are enabled, and gestures are enabled on mobile platforms only.

```dart
const FlutterDeckConfiguration(
  controls: FlutterDeckControlsConfiguration(
    presenterToolbarVisible: true,
  ),
)
```

_Note: This configuration cannot be overridden by the slide configuration._

### Footer

The `footer` property configures the footer component for the slide deck using `FlutterDeckFooterConfiguration`. By default, the footer is not shown.

```dart
const FlutterDeckConfiguration(
  footer: FlutterDeckFooterConfiguration(
    showFooter: true,
    showSlideNumbers: true,
    showSocialHandle: true,
  ),
)
```

### Header

The `header` property configures the header component for the slide deck using `FlutterDeckHeaderConfiguration`. By default, the header is not shown.

```dart
const FlutterDeckConfiguration(
  header: FlutterDeckHeaderConfiguration(
    showHeader: true,
    title: 'Presentation Title',
  ),
)
```

### Marker

The `marker` property configures the drawing marker tool using `FlutterDeckMarkerConfiguration`. By default, the marker is red with a stroke width of 5px.

```dart
const FlutterDeckConfiguration(
  marker: FlutterDeckMarkerConfiguration(
    color: Colors.red,
    strokeWidth: 5.0,
  ),
)
```

_Note: This configuration cannot be overridden by the slide configuration._

### Progress indicator

The `progressIndicator` property configures the progress indicator to show in the slide deck using `FlutterDeckProgressIndicator`. By default, a solid progress indicator with a primary color from the theme is used.

```dart
const FlutterDeckConfiguration(
  progressIndicator: FlutterDeckProgressIndicator.gradient(
    gradient: LinearGradient(
      colors: [Colors.blue, Colors.purple],
    ),
  ),
)
```

### Show progress

The `showProgress` property determines whether to show the presentation progress or not. The default is `true`.

```dart
const FlutterDeckConfiguration(
  showProgress: false,
)
```

### Slide size

The `slideSize` property configures the size of the slides in the slide deck using `FlutterDeckSlideSize`. By default, the size is responsive, which means it is not constrained and will adapt to the screen size.

```dart
const FlutterDeckConfiguration(
  slideSize: FlutterDeckSlideSize.fromAspectRatio(
    aspectRatio: FlutterDeckAspectRatio.ratio16x9(),
    resolution: FlutterDeckResolution.fhd(),
  ),
)
```

_Note: This configuration cannot be overridden by the slide configuration._

### Template overrides

The `templateOverrides` property allows you to override default slide template configurations using `FlutterDeckTemplateOverrideConfiguration`.

_Note: This configuration cannot be overridden by the slide configuration._

### Transition

The `transition` property configures the transition to use when navigating between slides. The default transition is `FlutterDeckTransition.none()`.

```dart
const FlutterDeckConfiguration(
  transition: FlutterDeckTransition.fade(),
)
```
