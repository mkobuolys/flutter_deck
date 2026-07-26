---
title: Authoring from Markdown
navOrder: 2
---

# Generating a deck from a Markdown outline

Writing every slide by hand is the slow part of building a presentation. With the
[`flutter-deck-author`](/ai/agent-skills/) skill installed, you can write your talk as a plain
Markdown outline and let an AI agent turn it into idiomatic `flutter_deck` slides — one Dart file
per slide, wired into your deck.

The skill is **content-only**: it generates slides, but it does not scaffold the app or define
themes. If you don't have a deck yet, the agent will set one up first (via the
`flutter-deck-presentation-setup` skill), then generate your slides into it.

## 1. Install the skill

The authoring skill ships with `flutter_deck`. Install it into your project like any other skill
(see [Agent Skills](/ai/agent-skills/) for details):

```sh
npx skills add mkobuolys/flutter_deck --skill flutter-deck-author
```

## 2. Write an outline

Create a Markdown file — say `outline.md` — that describes your talk. You write normal Markdown;
the skill maps its **shape** to the right slide template:

- The top `#` heading becomes the opening **title** slide.
- Each `##` heading starts a new slide.
- A blockquote (`>`) becomes a **quote** slide.
- A short stat heading (like `## 100%`) becomes a **big fact** slide.
- A fenced code block becomes a **code** slide with syntax highlighting.
- An image becomes an **image** slide; text next to an image or code becomes a **split** slide.
- A heading with a bullet list becomes a **content** slide.

You can also drop in HTML-comment directives to override the defaults — they're invisible when the
Markdown is rendered anywhere else:

- `<!-- slide: title -->` — force a specific template for this slide.
- `<!-- steps: reveal -->` — reveal bullet points one at a time.
- `<!-- notes: ... -->` — attach speaker notes.
- `<!-- route: /custom -->` — set an explicit route.

Here's a complete example outline:

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

## 3. Ask your agent to generate the deck

In your AI coding agent (Claude Code, Cursor, Codex, and other
[compatible clients](https://agentskills.io/clients)), point it at the outline:

> Using the flutter-deck-author skill, generate slides from `outline.md` and wire them into my deck.

## 4. What you get

The agent creates one file per slide under `lib/slides/`, picking a template for each segment and
deriving a route and class name from each heading:

| Outline segment            | Slide template | Route                    | Class                     |
| -------------------------- | -------------- | ------------------------ | ------------------------- |
| `# Building Better Decks`  | title          | `/building-better-decks` | `BuildingBetterDecksSlide` |
| `## Why slides as code?`   | content (bullets, revealed step by step) | `/why-slides-as-code` | `WhySlidesAsCodeSlide` |
| `## 100%`                  | big fact       | `/100`                   | `Slide100`                |
| `## In their words`        | quote          | `/in-their-words`        | `InTheirWordsSlide`       |
| `## Show me the code`      | code           | `/show-me-the-code`      | `ShowMeTheCodeSlide`      |
| `## Thanks!`               | title (forced) | `/thanks`                | `ThanksSlide`             |

For example, the `## Why slides as code?` segment — with its `<!-- steps: reveal -->` directive —
becomes a slide whose bullet points appear one at a time:

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

The agent also updates the `lib/slides/slides.dart` barrel and adds the slides — in outline order —
to your `FlutterDeckApp`:

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

Run the app and you have a working deck — ready to refine slide by slide.

## Tips

- **Iterate on the outline, not the Dart.** Re-running the skill on an updated outline is the
  fastest way to reshape a talk. Drop to hand-written slides only when a slide needs custom widgets.
- **Reach for directives sparingly.** The heuristics cover most slides; use `<!-- slide: ... -->`
  only when you want a template the content shape wouldn't pick on its own.
- **Style comes later.** The generated slides inherit your deck's theme. See
  [Theming](/guides/theming/) to brand them, and pair the authoring skill with the
  `flutter-deck-theming` skill.

For the full mapping rules, directive reference, and naming conventions, see the skill itself under
[`skills/flutter-deck-author/`](https://github.com/mkobuolys/flutter_deck/tree/main/skills/flutter-deck-author)
or the [Agent Skills](/ai/agent-skills/) overview.
