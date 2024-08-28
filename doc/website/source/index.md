---
title: Welcome to Flutter Deck
description: Flutter Deck is a slide show generator for Flutter developers.
layout: layouts/docs_page.jinja
contentRenderers:
  # Render Jinja first, so we can include "contributors" component.
  - jinja
  # Second, render Markdown to HTML.
  - markdown
---

Welcome to `flutter_deck`, a Flutter package to generate slideshows with Flutter widgets,
which run on all platforms.

Check out the [example](/demo) to see what you can build with `flutter_deck`.

## Features

- 💙 Slide deck is built as any other Flutter app.
- 🧭 Navigator 2.0 support - each slide is rendered as an individual page with a deep link to it.
- 🐾 Steps - each slide can have multiple steps that can be navigated through.
- 🎓 Presenter view - control your presentation from a separate screen or (even) device.
- ⚙️ Define a global configuration once and override it per slide if needed.
- 🚀 Predictable API to access the slide deck state and its methods from anywhere in the app.
- 📦 Out of the box slide templates, widgets, transitions and controls.
- 🎨 Custom theming and light/dark mode support.
- 🌍 Built-in localization support.

## Quickstart

Create a new Flutter project and add `flutter_deck` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  flutter_deck:
```

Dig into critical features with the [Get Started guide](/get-started).

{{ components.contributors() }}
