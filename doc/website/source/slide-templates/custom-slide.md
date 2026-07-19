---
title: Custom slide
navOrder: 8
---

When none of the built-in slide templates fit your needs, you can build your own. This guide starts from a completely blank slide and then shows how to re-add each standard piece (background, header, footer, layout and theme) so that your custom slide stays consistent with the rest of the deck.

## A blank canvas

To create a custom slide without any predefined template, use the `FlutterDeckSlide.custom` constructor and pass a `builder` to it. The `builder` gives you full control over the slide - nothing is rendered for you.

```dart
class CustomSlide extends FlutterDeckSlideWidget {
  const CustomSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/custom-slide',
            title: 'Custom slide',
          ),
        );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.custom(
      builder: (context) {
        return const Text('Here goes your custom slide content...');
      },
    );
  }
}
```

This is the right choice when you want something truly bespoke. However, most of the time you want a slide that is *mostly* like a built-in template but different in one or two ways - while still keeping the same header, footer, background and theming. The rest of this guide shows how to reconstitute those pieces.

## Reusing the standard layout

Every built-in template is built on top of the `FlutterDeckSlideBase` widget. It takes care of placing the background, header, content and footer in the correct positions. Instead of laying everything out yourself, build on top of it:

```dart
@override
Widget build(BuildContext context) {
  return FlutterDeckSlide.custom(
    builder: (context) {
      return FlutterDeckSlideBase(
        contentBuilder: (context) => const Center(
          child: Text('Your custom content'),
        ),
      );
    },
  );
}
```

`FlutterDeckSlideBase` accepts four optional builders:

- `backgroundBuilder` - the background of the slide.
- `contentBuilder` - the content placed between the header and footer.
- `headerBuilder` - the header at the top of the slide.
- `footerBuilder` - the footer at the bottom of the slide.

If you omit `backgroundBuilder`, `FlutterDeckSlideBase` automatically renders the background from the global configuration based on the current theme, so you get the same background as every other slide for free.

## Re-adding the header and footer

Header and footer are *not* rendered unless you pass the corresponding builders. To reuse the default header and footer (the ones configured globally or per-slide), build them from the current slide configuration:

```dart
@override
Widget build(BuildContext context) {
  return FlutterDeckSlide.custom(
    builder: (context) {
      final FlutterDeckSlideConfiguration(
        :footer,
        :header,
      ) = context.flutterDeck.configuration;

      return FlutterDeckSlideBase(
        contentBuilder: (context) => const Center(
          child: Text('Your custom content'),
        ),
        headerBuilder: header.showHeader
            ? (context) => FlutterDeckHeader.fromConfiguration(
                  configuration: header,
                )
            : null,
        footerBuilder: footer.showFooter
            ? (context) => FlutterDeckFooter.fromConfiguration(
                  configuration: footer,
                )
            : null,
      );
    },
  );
}
```

This mirrors exactly what the built-in templates do: they only render the header/footer when `showHeader`/`showFooter` is enabled in the configuration.

## Applying the layout and theme

The built-in templates use a consistent slide padding and pull their text styles from the theme. You can reuse both:

- `FlutterDeckLayout.slidePadding` - the standard padding applied to slide content.
- `FlutterDeckTheme.of(context)` - the global theme data. Slide-specific themes (for example `FlutterDeckBigFactSlideTheme.of(context)`) are also available if you want to match a particular template.

```dart
contentBuilder: (context) {
  final theme = FlutterDeckTheme.of(context);

  return Padding(
    padding: FlutterDeckLayout.slidePadding,
    child: Center(
      child: Text(
        'Your custom content',
        style: theme.textTheme.title,
      ),
    ),
  );
},
```

## Starting from an existing template

Because the template widgets and their building blocks are exported from the `flutter_deck` package, the easiest way to build a custom slide is often to copy the `build` method of the template that is closest to what you want (for example `FlutterDeckBigFactSlide`) and tweak it. Everything referenced in those templates - `FlutterDeckSlideBase`, `FlutterDeckLayout`, `FlutterDeckHeader`, `FlutterDeckFooter`, the slide themes and `AutoSizeText` - is available from a single import:

```dart
import 'package:flutter_deck/flutter_deck.dart';
```

**Tip:** If you want to reuse the *same* custom layout across many slides, extract it into a reusable widget (like `FlutterDeckSlideBase` itself) instead of duplicating the `builder` on every slide. To override a built-in template globally, see [Template Overrides](/guides/template-overrides).
