---
name: flutter-deck-slides
description: >
  Create slides in a flutter_deck presentation using the eight built-in
  factories — title, image, split, quote, bigFact, blank, template, and
  custom. Three patterns are idiomatic: subclass FlutterDeckSlideWidget, call
  a FlutterDeckSlide.<factory>(configuration: …) constructor inline inside
  FlutterDeckApp.slides, or wrap any existing widget with the
  Widget.withSlideConfiguration extension. Use this skill when adding a new
  slide, picking the right layout for a topic, refactoring raw widgets into
  slides, building sequential reveals with FlutterDeckSlideStepsBuilder or
  FlutterDeckSlideStepsListener, or wiring routes, preloadImages, speaker
  notes, and steps — even when the user only says "add a slide" or "show
  this widget as a slide".
compatibility: >
  Requires a Flutter project with the flutter_deck package added as a
  dependency.
---

# Creating Slides in Flutter Deck

## Overview

The `flutter_deck` framework provides several built-in `FlutterDeckSlide` factories — `title`, `image`, `split`, `quote`, `bigFact`, `blank`, `template`, `custom` — plus full support for hand-rolled slides. As an architectural best practice, **each slide should live in its own Dart file** so the deck scales as the presentation grows.

There are three idiomatic ways to define a slide. Pick the one that fits the slide's complexity:

1. **Subclass `FlutterDeckSlideWidget`** — the canonical pattern when a slide owns its own widget tree, configuration, and helpers. Most slides use this.
2. **Use a `FlutterDeckSlide.<factory>` constructor directly** with a `configuration:` argument — works inline inside `FlutterDeckApp.slides` for terminal slides like a thank-you screen, no class definition needed.
3. **Wrap any existing widget** with the `Widget.withSlideConfiguration(...)` extension — useful when an existing widget (a counter demo, a stateful widget tree) just needs slide chrome attached.

## When to Use This Skill

- When you are adding a new concept, topic, or section to a presentation and need a new slide.
- When you are refactoring raw Flutter widgets into structured presentation slides.
- When you need to choose the right layout (e.g., deciding between a `QuoteSlide`, an `ImageSlide`, or a `SplitSlide`).
- When a slide has multi-step animations or bullet points appearing sequentially (using the `steps` property).

## Implementation Checklist

- [ ] Determine the content focus of the slide (title, image, quote, etc.).
- [ ] Create a new, separate Dart file for the slide.
- [ ] Choose the appropriate `FlutterDeckSlide` factory constructor (e.g., `FlutterDeckSlide.title`, `FlutterDeckSlide.template`).
- [ ] Define the `FlutterDeckSlideConfiguration` for the slide, ensuring it has a unique `route`.
- [ ] Set `steps` in the configuration if you want the slide to require multiple clicks before moving to the next slide.
- [ ] Add any images used in the slide to `preloadImages` in the configuration for smoother transitions.
- [ ] Implement the UI utilizing the builder provided by the chosen template.
- [ ] Add the fully implemented slide to the `slides` list in `FlutterDeckApp`.

---

## Standard Slide Templates

You can create slides using the following factory constructors on `FlutterDeckSlide`:

1. **Template Slide**: The base custom layout allowing precise control over header, footer, background, and content placement.

   ```dart
   FlutterDeckSlide.template(
     backgroundBuilder: (context) => FlutterDeckBackground.solid(
       Theme.of(context).colorScheme.background,
     ),
     contentBuilder: (context) => const ColoredBox(
       color: Colors.red,
       child: Text('Content goes here...'),
     ),
     footerBuilder: (context) => ColoredBox(
       color: Theme.of(context).colorScheme.secondary,
       child: const Text('Footer goes here...'),
     ),
     headerBuilder: (context) => ColoredBox(
       color: Theme.of(context).colorScheme.primary,
       child: const Text('Header goes here...'),
     ),
   )
   ```

2. **Title Slide**: A slide with a title and an optional subtitle.

   ```dart
   FlutterDeckSlide.title(
     title: 'My Presentation',
     subtitle: 'By John Doe',
   )
   ```

3. **Image Slide**: A slide that displays an image.

   ```dart
   FlutterDeckSlide.image(
     imageBuilder: (context) => Image.asset('assets/my_image.png'),
     label: 'Architecture Diagram',
   )
   ```

4. **Split Slide**: A slide split into two columns (usually text on left, widget/image on right).

   ```dart
   FlutterDeckSlide.split(
     leftBuilder: (context) => const Text('Left Side'),
     rightBuilder: (context) => const Text('Right Side'),
   )
   ```

5. **Quote Slide**: A slide with a large quote and optional attribution.

   ```dart
   FlutterDeckSlide.quote(
     quote: '"Flutter is awesome"',
     attribution: '- Everyone',
   )
   ```

6. **Big Fact Slide**: A slide featuring a large bold text fact and a subtitle.

   ```dart
   FlutterDeckSlide.bigFact(
     title: '100%',
     subtitle: 'Of developers love this framework',
   )
   ```

7. **Blank Slide**: A completely empty slide where you provide the full widget tree.

   ```dart
   FlutterDeckSlide.blank(
     builder: (context) => const Center(child: Text('Custom Content')),
   )
   ```

8. **Custom Slide**: For fully customized slides building on top of `FlutterDeckSlideBase` or returning your own `FlutterDeckSlide.custom`.
   ```dart
   FlutterDeckSlide.custom(
     builder: (context) => const CustomSlideWidget(),
   )
   ```

## Three Patterns for Defining a Slide

### Pattern 1: Subclass `FlutterDeckSlideWidget` (canonical)

```dart
class MySlide extends FlutterDeckSlideWidget {
  const MySlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(route: '/my'),
        );

  @override
  FlutterDeckSlide build(BuildContext context) =>
      FlutterDeckSlide.blank(builder: (_) => const Center(child: Text('Hi')));
}
```

### Pattern 2: Use a factory constructor directly

Every `FlutterDeckSlide.<factory>` accepts a `configuration:` argument, so a one-off slide can live inline in `FlutterDeckApp.slides`:

```dart
slides: [
  FlutterDeckSlide.title(
    configuration: const FlutterDeckSlideConfiguration(
      route: '/end',
      title: 'Thank you!',
      footer: FlutterDeckFooterConfiguration(showFooter: false),
    ),
    title: 'Thank you! 👋',
    subtitle: 'Questions?',
  ),
],
```

### Pattern 3: `withSlideConfiguration` extension on any `Widget`

An existing widget (e.g. a stateful demo) can become a slide without subclassing — call `.withSlideConfiguration(...)` on it. The extension wraps it via `FlutterDeckSlide.custom`.

```dart
slides: [
  const CounterDemo().withSlideConfiguration(
    const FlutterDeckSlideConfiguration(
      route: '/counter',
      title: 'Live counter demo',
    ),
  ),
],
```

`FlutterDeckApp.slides` is typed `List<Widget>`, so all three patterns can be mixed in the same list.

## Sequential Reveals: `steps`

When a slide should consume multiple "next" presses before advancing — bullets appearing one at a time, an animated diagram building up — set `steps: N` on the configuration and read the current step at build time.

The framework provides two helper widgets:

- `FlutterDeckSlideStepsBuilder({required builder})` — rebuilds whenever the step changes. The builder receives `(BuildContext context, int stepNumber)`.
- `FlutterDeckSlideStepsListener({required listener, required child})` — fire-and-forget callback when the step changes (for animations, side effects); does not rebuild its child.

```dart
@override
FlutterDeckSlide build(BuildContext context) {
  return FlutterDeckSlide.blank(
    builder: (context) => FlutterDeckSlideStepsBuilder(
      builder: (context, step) => Column(
        children: [
          const Text('Point one'),
          if (step >= 2) const Text('Point two'),
          if (step >= 3) const Text('Point three'),
        ],
      ),
    ),
  );
}
```

`stepNumber` starts at `1`. Combine with `steps: 3` in the configuration so the slide consumes all three taps before advancing.

## Configuring a Slide

Each slide must have a `configuration`.

```dart
const _speakerNotes = '''
Don't forget to talk about this slide.
Keep multiple points organized here for the presenter view.
''';

class MySlide extends FlutterDeckSlideWidget {
  const MySlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/my-slide',
            title: 'My Slide Title',
            speakerNotes: _speakerNotes,
            hidden: false,
            initial: false,
            steps: 2,
            preloadImages: {'assets/my-image.png'}
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.image(
      imageBuilder: (context) => Image.asset('assets/my-image.png')
    );
  }
}
```

## Gotchas

- A slide is only rendered if it's added to `FlutterDeckApp.slides`. Defining a `FlutterDeckSlideWidget` subclass alone does nothing.
- Every slide must have a unique `route` starting with `/`. Duplicate routes cause a startup failure.
- `steps` defaults to `1` (one tap advances). Set `steps: N` for sequential reveals; the slide consumes `N` next-key presses before moving on.
- `preloadImages` accepts both asset paths and remote URLs. Use it for every image that would otherwise visibly pop in mid-presentation.
- `FlutterDeckSlide.split` has its own theme channel (`FlutterDeckSplitSlideThemeData`) — color it via the slide's `theme:` parameter, not the global theme, when only that slide needs different split colors.
- The "one slide per file" rule is a project convention enforced by maintainability, not the framework. Skipping it works mechanically but breaks barrel imports and code review fast.
- `FlutterDeckSlide.template` is the right escape hatch when the built-in factories don't fit — it lets you supply `headerBuilder`, `footerBuilder`, `backgroundBuilder`, and `contentBuilder` independently. Reach for `.blank` only when you also want to skip the standard chrome.
