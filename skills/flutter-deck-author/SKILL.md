---
name: flutter-deck-author
description: >
  Generate a flutter_deck presentation from a Markdown outline — turn talk
  notes, an outline, or a topic into idiomatic slide files. Segments Markdown
  into slides, maps each block to the right built-in factory (title, quote,
  bigFact, image, split, code, bulleted content) by content shape, honors
  per-slide override directives (`<!-- slide: -->`, `<!-- steps: reveal -->`,
  `<!-- notes: -->`, `<!-- route: -->`), derives routes and class names, and
  wires the `lib/slides/` barrel. Use when authoring or drafting a deck from
  Markdown, bulk-creating slides from an outline, or converting notes into a
  flutter_deck presentation — even when the user only says "make a deck about
  X" or "turn this outline into slides". Composes with
  flutter-deck-presentation-setup (app wiring) and flutter-deck-slides /
  flutter-deck-theming (factory and styling details).
compatibility: >
  Requires a Flutter project with the flutter_deck package added as a
  dependency.
---

# Authoring a Flutter Deck from Markdown

## Overview

This skill turns a Markdown outline into idiomatic `flutter_deck` slide files.
The author writes content in Markdown; the agent emits one Dart file per slide
under `lib/slides/`, choosing the right `FlutterDeckSlide` factory for each
block and wiring the barrel. It is **content-only**:

- It does **not** scaffold `FlutterDeckApp`, add the dependency, or define
  themes. If the project has no deck yet, use **flutter-deck-presentation-setup**
  first, then return here.
- For the details of each factory or for styling, defer to
  **flutter-deck-slides** and **flutter-deck-theming**.

## When to Use This Skill

- The user provides a Markdown outline / notes and wants slides.
- The user asks to "make a deck about X" or "draft a talk on Y" — draft an
  `outline.md` first (see Step 1), get approval, then generate from it.
- The user wants to bulk-create many slides at once rather than one at a time.

## Pipeline Checklist

- [ ] Obtain the Markdown source (a file, pasted text, or a drafted `outline.md`
      the user approved).
- [ ] Confirm a `FlutterDeckApp` exists. If not, hand off to
      **flutter-deck-presentation-setup**, then resume.
- [ ] Detect the target layout: flat `lib/slides/` vs. grouped section barrels.
      Match whatever the deck already uses; default to flat `lib/slides/`.
- [ ] Segment the Markdown into slides (rules below).
- [ ] Classify each segment into a factory (heuristics + directives below).
- [ ] Emit one Dart file per slide; derive the route and class name.
- [ ] Update `lib/slides/slides.dart` (and section arrays if grouped).
- [ ] Add the slides to `FlutterDeckApp.slides` if that list is discoverable;
      otherwise print the exact lines to paste.
- [ ] Post-checks: unique routes; `preloadImages` set for every image; remind
      the user to check contrast/overflow (see flutter-deck-theming).

## Segmenting Markdown into Slides

- A top-level `#` (H1) at the start becomes the deck's opening **title** slide.
- A `---` horizontal rule is a hard slide break.
- Otherwise each `##` (H2) starts a new slide; the H2 text is that slide's
  title and the source of its route/class name.
- Optional YAML frontmatter at the top carries deck-level metadata (e.g.
  `title:`); it does not itself produce a slide.

## Mapping Content to Factories (heuristics)

Pick the factory from the **shape** of the segment's content:

| Segment shape                                   | Factory                                                          |
| ----------------------------------------------- | ---------------------------------------------------------------- |
| First slide / a lone H1                         | `FlutterDeckSlide.title` (subtitle from the next line or an H2)  |
| A dominant blockquote (`>`)                     | `FlutterDeckSlide.quote` (attribution from a `— name` line)      |
| A short stat heading (e.g. `## 100%`)           | `FlutterDeckSlide.bigFact` (subtitle = the following line)       |
| A dominant fenced code block                    | `FlutterDeckSlide.blank` + `FlutterDeckCodeHighlight`            |
| A lone image `![alt](path)`                     | `FlutterDeckSlide.image` (label = alt); add path to `preloadImages` |
| Text **and** an image/code block together       | `FlutterDeckSlide.split` (text left, media right)                |
| Heading + bullet list (**default**)             | `FlutterDeckSlide.blank` + `FlutterDeckBulletList`               |
| Empty / unrecognized                            | `FlutterDeckSlide.blank`                                          |

Notes:
- **Precedence:** evaluate the rows top-to-bottom and use the first that
  matches; the bottom two rows are fallbacks. A `<!-- slide: -->` directive
  always overrides the heuristic. If a segment genuinely matches two specific
  rows (e.g. text with both an image and a fenced code block), prefer `split`
  or add an explicit `<!-- slide: -->`.
- A bulleted content slide sets `header: FlutterDeckHeaderConfiguration(title:
  <heading>)` so the section title shows above the bullets.
- Code slides: language comes from the fence info string (```` ```dart ````);
  `FlutterDeckCodeHighlight` defaults to `language: 'dart'`.

## Override Directives

HTML comments are invisible in rendered Markdown, so the source stays a normal
document. Place a directive inside the slide's segment.

| Directive                     | Effect                                                                 |
| ----------------------------- | ---------------------------------------------------------------------- |
| `<!-- slide: <factory> -->`   | Force the factory (e.g. `split`, `bigFact`, `quote`, `title`).         |
| `<!-- steps: reveal -->`      | Reveal bullets one-by-one: `FlutterDeckBulletList(useSteps: true)` and set `steps:` to the bullet count. |
| `<!-- notes: … -->`           | Becomes the slide's `speakerNotes`.                                     |
| `<!-- route: /custom -->`     | Override the derived route.                                             |

## Deriving Routes and Class Names

- **Route:** `/` + a slug of the heading (lowercase; each run of non-alphanumeric
  characters becomes a single `-`; trim leading/trailing `-`). Empty slug →
  `/slide-<index>`. A `<!-- route: -->` directive always wins. On collision,
  append `-<index>`.
- **Class:** PascalCase of the heading's alphanumeric words + `Slide`
  (`Why slides as code?` → `WhySlidesAsCodeSlide`). If that would start with a
  digit (a stat heading like `100%`), use `Slide` + the digits instead
  (`Slide100`). Empty → `Slide<index>`.
- **File name:** snake_case of the class name (`WhySlidesAsCodeSlide` →
  `why_slides_as_code_slide.dart`; `Slide100` → `slide100.dart`).
- **Barrel order:** order the `export` statements alphabetically (Dart's
  `directives_ordering` lint expects this); the `FlutterDeckApp.slides` list,
  by contrast, follows outline order.

## Worked Example

Input `outline.md`:

````markdown
---
title: Building Better Decks
---

# Building Better Decks
Slides as code, with flutter_deck

## Why slides as code?
<!-- steps: reveal -->
- Version control your entire talk
- Reuse widgets and live demos
- One framework, every platform

## 100%
Flutter, all the way down

## In their words
> The best presentation tool is the one you never fight.
— A tired conference speaker

## Show me the code
```dart
FlutterDeckApp(
  slides: [const TitleSlide()],
);
```

## Thanks!
<!-- slide: title -->
Questions?
````

This produces six files under `lib/slides/` (title, stepped bullet list,
bigFact, quote, code, forced-title), each subclassing `FlutterDeckSlideWidget`.
Two representative outputs:

`lib/slides/why_slides_as_code_slide.dart` (heading + bullets + `steps: reveal`):

```dart
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class WhySlidesAsCodeSlide extends FlutterDeckSlideWidget {
  const WhySlidesAsCodeSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/why-slides-as-code',
          title: 'Why slides as code?',
          header: FlutterDeckHeaderConfiguration(title: 'Why slides as code?'),
          steps: 3,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => FlutterDeckBulletList(
        useSteps: true,
        items: const [
          'Version control your entire talk',
          'Reuse widgets and live demos',
          'One framework, every platform',
        ],
      ),
    );
  }
}
```

`lib/slides/slide100.dart` (short stat heading → bigFact; digit-leading class →
`Slide` prefix):

```dart
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class Slide100 extends FlutterDeckSlideWidget {
  const Slide100()
    : super(
        configuration: const FlutterDeckSlideConfiguration(route: '/100'),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.bigFact(
      title: '100%',
      subtitle: 'Flutter, all the way down',
    );
  }
}
```

Barrel `lib/slides/slides.dart`:

```dart
export 'building_better_decks_slide.dart';
export 'in_their_words_slide.dart';
export 'show_me_the_code_slide.dart';
export 'slide100.dart';
export 'thanks_slide.dart';
export 'why_slides_as_code_slide.dart';
```

Then add the slides (in outline order) to `FlutterDeckApp.slides`:

```dart
slides: const [
  BuildingBetterDecksSlide(),
  WhySlidesAsCodeSlide(),
  Slide100(),
  InTheirWordsSlide(),
  ShowMeTheCodeSlide(),
  ThanksSlide(),
],
```

## Gotchas

- Order in `FlutterDeckApp.slides` **is** the presentation order — add slides in
  outline order.
- A slide only renders if it is in `FlutterDeckApp.slides`. Creating the file
  and exporting it from the barrel is not enough.
- Routes must be unique and start with `/`; duplicates fail at startup. The
  collision rule (append `-<index>`) exists to prevent this.
- `FlutterDeckCodeHighlight.highlightedLines` are **0-indexed**.
- Set `preloadImages` on every image slide so images don't pop in mid-talk.
- Generated slides omit an explicit `Key` (matching flutter_deck's Mason brick
  and example). A freshly `flutter create`d project's default lints flag this
  via `use_key_in_widget_constructors`; flutter_deck's own example disables
  that rule in `analysis_options.yaml`. If the target project has it enabled,
  either disable the rule or add `Key? key` params.
- This skill does not set up the app or themes — use
  flutter-deck-presentation-setup and flutter-deck-theming for those.
