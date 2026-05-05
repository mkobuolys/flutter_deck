---
name: flutter-deck-theming
description: >
  Style flutter_deck presentations using FlutterDeckThemeData with
  lightTheme/darkTheme/themeMode, FlutterDeckTextTheme typography slots
  (display, header, title, subtitle, bodyLarge/Medium/Small), per-slide theme
  overrides via the slide-level theme: parameter and copyWith on template
  slots (titleSlideTheme, splitSlideTheme, quoteSlideTheme, imageSlideTheme,
  bigFactSlideTheme, slideTheme), and component theming for headers, footers,
  bullet lists, code highlight, and speaker info. Use this skill when
  establishing brand identity, switching light/dark modes, restyling a single
  slide, overriding sub-component styles, choosing typography, or auditing
  4.5:1 contrast — even when the user only says "change the colors" or "make
  this slide pop".
compatibility: >
  Requires a Flutter project with the flutter_deck package added as a
  dependency.
---

# Styling and Theming Flutter Deck

## Overview

The `flutter_deck` framework takes visual presentation seriously by providing its own theming engine, separate from (yet composable with) Flutter's standard `ThemeData`.
`FlutterDeckThemeData` explicitly models the visual characteristics unique to presentations—like slide backgrounds, highly readable typography levels (`title`, `subtitle`, `body`), header/footer colors, and speaker notes styles.
The system natively supports light and dark modes, allowing the presentation's brightness to follow system settings or user preference seamlessly. Moreover, themes can be localized to a single slide, or even specific widgets like the slide header or footer.

## When to Use This Skill

- When establishing the company or brand's visual identity for the entire presentation.
- When you want to ensure the presentation seamlessly supports both light and dark display modes.
- When an individual slide requires a dramatic visual change (e.g., changing text and background color) using a localized `FlutterDeckTheme`.
- When trying to override the default styles of sub-components like the `FlutterDeckHeader`, `FlutterDeckFooter`, or `FlutterDeckCodeHighlight`.
- When using common Material widgets (like Buttons or Cards) inside slides to ensure they inherit aesthetic choices via `FlutterDeckThemeData.fromTheme`.

## Implementation Checklist

- [ ] Determine the primary color scheme and fonts needed for the design.
- [ ] Supply `FlutterDeckThemeData.fromTheme` to the `lightTheme` and `darkTheme` parameters in `FlutterDeckApp` configured using your `ThemeData`.
- [ ] To isolate the theme of a single slide, wrap that slide's highest-level widget tree in `FlutterDeckTheme` and provide the overridden `FlutterDeckTheme.of(context).copyWith(...)`.
- [ ] To customize built-in widget styles, wrap them in their respective theme widgets (e.g., `FlutterDeckHeaderTheme`).
- [ ] Verify that all text-to-background color pairings meet the **4.5:1 contrast ratio**.

## Accessibility Fundamentals

When designing presentation themes, you must adhere rigidly to Material accessibility standards so every viewer can read your slides comfortably, regardless of screen brightness or room lighting:

- **Contrast Ratios**: Every piece of text must maintain a minimum contrast ratio of **4.5:1** against its background color. Never place white text on very light backgrounds (like pastel cyan, yellow, or standard `Colors.green`).
- **Dynamic Text Scaling**: Ensure that when users (or the framework) scale up text sizes for visibility, your layouts adapt without overflowing or clipping.
- **Color Semantics**: Rely on `ThemeData.colorScheme`'s semantic colors (e.g., `onPrimary` for text placed on top of `primary` color) rather than hardcoding absolute colors. The Flutter framework automatically calculates accessible "on" colors for the baseline palettes.

---

## Global Deck Theme

You should customize the theme of your slide deck by providing a `FlutterDeckThemeData` to the `FlutterDeckApp` widget. The best practice is to extract your presentation aesthetics directly from a standard `ThemeData` block.

```dart
return FlutterDeckApp(
  // You can define light...
  lightTheme: FlutterDeckThemeData.fromTheme(
    ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF005C97), // Strong, accessible seed color
      ),
      useMaterial3: true,
    ),
  ),
  // ...and dark themes.
  darkTheme: FlutterDeckThemeData.fromTheme(
    ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF00E5FF),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    ),
  ),
  slides: const [...],
);
```

## Overriding Theme per Slide

It's possible to override the theme for a specific slide. The provided theme data will be merged with the global theme.

```dart
class ThemingSlide extends FlutterDeckSlideWidget {
  const ThemingSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/theming-slide',
            header: FlutterDeckHeaderConfiguration(title: 'Theming'),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.split(
      theme: FlutterDeckTheme.of(context).copyWith(
        splitSlideTheme: const FlutterDeckSplitSlideThemeData(
          // Ensure high contrast: White text on deep blue (> 4.5:1)
          leftBackgroundColor: Color(0xFF0D47A1), // Colors.blue.shade900
          leftColor: Colors.white,
          // Ensure high contrast: Very dark grey text on soft amber (> 4.5:1)
          rightBackgroundColor: Color(0xFFFFECB3), // Colors.amber.shade100
          rightColor: Color(0xFF212121), // Colors.grey.shade900
        ),
      ),
      leftBuilder: (context) => const Text('Left'),
      rightBuilder: (context) => const Text('Right'),
    );
  }
}
```

## Theme Surface

flutter_deck has two layers of theme widgets:

**Widget-level themes** — style a single reusable component:

- `FlutterDeckBulletListTheme` / `FlutterDeckBulletListThemeData`
- `FlutterDeckCodeHighlightTheme` / `FlutterDeckCodeHighlightThemeData`
- `FlutterDeckFooterTheme` / `FlutterDeckFooterThemeData`
- `FlutterDeckHeaderTheme` / `FlutterDeckHeaderThemeData`
- `FlutterDeckSpeakerInfoWidgetTheme` / `FlutterDeckSpeakerInfoWidgetThemeData`

**Template-level themes** — style the layout of a `FlutterDeckSlide.<factory>`:

- `FlutterDeckBigFactSlideTheme` / `FlutterDeckBigFactSlideThemeData` — `bigFactSlideTheme`
- `FlutterDeckImageSlideTheme` / `FlutterDeckImageSlideThemeData` — `imageSlideTheme`
- `FlutterDeckQuoteSlideTheme` / `FlutterDeckQuoteSlideThemeData` — `quoteSlideTheme`
- `FlutterDeckSlideTheme` / `FlutterDeckSlideThemeData` — `slideTheme` (used by `blank`, `template`, `custom`)
- `FlutterDeckSplitSlideTheme` / `FlutterDeckSplitSlideThemeData` — `splitSlideTheme`
- `FlutterDeckTitleSlideTheme` / `FlutterDeckTitleSlideThemeData` — `titleSlideTheme`

Each `*ThemeData` field is also reachable on `FlutterDeckThemeData` via the slot name shown above (e.g. `FlutterDeckTheme.of(context).copyWith(splitSlideTheme: ...)`), which is the per-slide override path used in the example below.

### Per-template per-slide override

The slide-level `theme:` parameter (available on every `FlutterDeckSlide.<factory>`) plus `copyWith` is the most common way to restyle a single slide:

```dart
FlutterDeckSlide.split(
  theme: FlutterDeckTheme.of(context).copyWith(
    splitSlideTheme: const FlutterDeckSplitSlideThemeData(
      leftBackgroundColor: Color(0xFF0D47A1),
      leftColor: Colors.white,
      rightBackgroundColor: Color(0xFFFFECB3),
      rightColor: Color(0xFF212121),
    ),
  ),
  leftBuilder: (context) => const Text('Left'),
  rightBuilder: (context) => const Text('Right'),
);
```

Any of the eight template slots (`bigFactSlideTheme`, `imageSlideTheme`, `quoteSlideTheme`, `slideTheme`, `splitSlideTheme`, `titleSlideTheme`, plus the widget-level slots like `headerTheme`, `footerTheme`, `codeHighlightTheme`, `bulletListTheme`, `speakerInfoWidgetTheme`) can be passed to `copyWith`.

### Wrapping individual built-in widgets

Alternatively, scope a theme to a single component subtree by wrapping it with the matching `*Theme` widget:

```dart
FlutterDeckSlide.template(
  // Wrap header with a theme widget to override the theme.
  headerBuilder: (context) => FlutterDeckHeaderTheme(
    data: FlutterDeckHeaderThemeData(
      color: const Color(0xFFB71C1C), // Deep red for adequate contrast
      textStyle: FlutterDeckTheme.of(context).textTheme.header.copyWith(
        color: Colors.white, // Explicitly safe white text
      ),
    ),
    child: const FlutterDeckHeader(title: 'Header'),
  ),
  // Wrap footer with a theme widget to override the theme.
  footerBuilder: (context) => FlutterDeckFooterTheme(
    data: FlutterDeckFooterThemeData(
      socialHandleColor: Colors.blue,
      socialHandleTextStyle:
          FlutterDeckTheme.of(context).textTheme.bodyMedium,
    ),
    child: const FlutterDeckFooter(showSlideNumber: false),
  ),
  contentBuilder: (context) => Center(
    // Wrap code highlight with a theme widget to override the theme.
    child: FlutterDeckCodeHighlightTheme(
      data: FlutterDeckCodeHighlightThemeData(
        backgroundColor: const Color(0xFF1B5E20), // Dark green background
        textStyle: FlutterDeckTheme.of(context).textTheme.bodyLarge.copyWith(
          color: Colors.white, // High contrast white text
        ),
      ),
      child: const FlutterDeckCodeHighlight(code: '<...>'),
    ),
  ),
);
```

## Light / Dark Mode

`FlutterDeckApp` exposes three theme parameters:

- `lightTheme` — used in light mode.
- `darkTheme` — used in dark mode.
- `themeMode` — defaults to `ThemeMode.system` (follows the OS). Set to `ThemeMode.light` or `ThemeMode.dark` to lock.

Both themes are independent — flutter_deck does not derive one from the other. Provide both, or accept that the unset side falls back to its framework default (`FlutterDeckThemeData.light` / `.dark`).

## Typography Slots (`FlutterDeckTextTheme`)

`FlutterDeckThemeData.textTheme` exposes seven typography slots, all `TextStyle`:

| Slot | Default size | Used by |
|------|--------------|---------|
| `display` | 103 / bold | Big fact slide title |
| `header` | 57 | `FlutterDeckHeader`, slide headers |
| `title` | 54 | Title slide title |
| `subtitle` | 42 | Title slide subtitle |
| `bodyLarge` | 28 | Quote, default body |
| `bodyMedium` | 22 | Footer, secondary body |
| `bodySmall` | 16 | Footnotes, captions |

Override individual slots with `copyWith`, or apply a font family deck-wide with `FlutterDeckTextTheme.apply(fontFamily: ..., color: ...)`.

```dart
lightTheme: FlutterDeckThemeData.fromTheme(
  ThemeData.from(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF3366)),
    useMaterial3: true,
  ).copyWith(textTheme: GoogleFonts.outfitTextTheme()),
),
```

## Gotchas

- `FlutterDeckThemeData` is **not** a drop-in for Flutter's `ThemeData`. Bridge them with `FlutterDeckThemeData.fromTheme(ThemeData(...))` so Material widgets used inside slides inherit the deck palette.
- Per-slide overrides are **merged** with the global theme via `FlutterDeckTheme.of(context).copyWith(...)`, not a full replacement. Only the fields you pass to `copyWith` change; everything else still comes from the global theme.
- Component theme widgets only affect **their own** widget. Wrapping the wrong subtree is silent — the override just doesn't apply. The full set is enumerated in the "Theme Surface" section above (5 widget-level + 6 template-level themes).
- For a single-slide restyle, prefer the slide-level `theme:` parameter + `copyWith` on a template slot (`splitSlideTheme`, `titleSlideTheme`, etc.) over wrapping individual builders. It's terser and applies to the whole slide.
- `lightTheme` and `darkTheme` are independent. flutter_deck does not derive one from the other — provide both, or accept that the unset side falls back to defaults. `themeMode` defaults to `ThemeMode.system`.
- Prefer semantic colors (`colorScheme.onPrimary`, `onSurface`, …) over hardcoded hex. The seed-based palette guarantees 4.5:1 contrast for `on*` pairings; hex values are easy to break when the seed color changes.
