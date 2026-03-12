---
title: Slide configuration
navOrder: 3
---

# Slide configuration

You can configure each slide individually using `FlutterDeckSlideConfiguration`. This configuration overrides the global presentation configuration for the specific slide. It also includes slide-specific configurations like route, title, steps, speaker notes, and whether the slide is hidden or initial.

## Defining slide configuration

There are multiple ways to configure a slide, depending on how you create it.

### Using `withSlideConfiguration`

If you are using a standard Flutter widget as a slide, you can use the `.withSlideConfiguration()` extension to provide the configuration:

```dart
Scaffold(
  body: Center(child: Text('Slide content')),
).withSlideConfiguration(
  const FlutterDeckSlideConfiguration(
    route: '/custom-route',
    title: 'Custom Slide',
    speakerNotes: 'Do not forget to talk about this slide.',
    hidden: false,
    initial: false,
    steps: 2,
  ),
)
```

### Using `FlutterDeckSlide` templates

When using standard flutter_deck slide templates, pass the configuration in the template's constructor:

```dart
FlutterDeckSlide.custom(
  configuration: const FlutterDeckSlideConfiguration(
    route: '/custom-slide',
    title: 'Custom Slide Template',
    footer: FlutterDeckFooterConfiguration(showFooter: false),
  ),
  builder: (context) => const Center(
    child: Text('Custom slide template content'),
  ),
)
```

### Subclassing `FlutterDeckSlideWidget`

If you subclass `FlutterDeckSlideWidget`, you provide the configuration via the `super` constructor:

```dart
class MySlide extends FlutterDeckSlideWidget {
  const MySlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/my-slide',
            title: 'My Slide',
            steps: 3,
            transition: FlutterDeckTransition.fade(),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('My custom slide')),
    );
  }
}
```

## Configuration properties

### Route

The `route` property (required) is the URL path segment used to navigate to this slide. Each route must be unique.

### Title

The `title` property sets the title of the slide. If set, it will be used in the navigation drawer instead of the header title (or route as a fallback).

### Speaker Notes

The `speakerNotes` property sets the speaker notes for the slide. These notes are visible in the presenter view and are not shown to the audience. The default is an empty string.

### Hidden

The `hidden` property determines whether the slide should be hidden from the presentation. Hidden slides cannot be navigated to using standard controls and do not appear in the slide deck overview. The default is `false`.

### Initial

The `initial` property sets the slide as the initial slide of the presentation. On Web, this is only used if the URL path is not set; otherwise, the URL path determines the initial slide. The default is `false`.

### Steps

The `steps` property defines the number of internal steps the slide has. It is useful for building animations or revealing content sequentially on a single slide. The default is `1`.

### Preload Images

The `preloadImages` property allows you to define a set of image URLs or asset paths to preload for the slide. The images will be preloaded before the slide is shown.

```dart
const FlutterDeckSlideConfiguration(
  route: '/image-slide',
  preloadImages: {
    'assets/images/my_image.png',
    'https://example.com/my_image.png',
  },
)
```

## Overriding global configuration

A slide configuration can override several global configuration properties on a per-slide basis:

*   **`footer`**: Overrides the `FlutterDeckFooterConfiguration`.
*   **`header`**: Overrides the `FlutterDeckHeaderConfiguration`.
*   **`progressIndicator`**: Overrides the `FlutterDeckProgressIndicator`.
*   **`showProgress`**: Overrides whether to show the progress indicator on this slide.
*   **`transition`**: Overrides the transition effect when navigating to this slide (`FlutterDeckTransition`).

```dart
const FlutterDeckSlideConfiguration(
  route: '/no-footer',
  footer: FlutterDeckFooterConfiguration(showFooter: false),
  transition: FlutterDeckTransition.slide(),
)
```

Properties like `background`, `controls`, `marker`, `slideSize`, and `templateOverrides` cannot be overridden via slide configuration. `background` is configured per template, while the others apply to the entire deck.
