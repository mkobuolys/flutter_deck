---
title: Code Generation
navOrder: 2
---
This package comes with a [mason][https://pub.dev/packages/mason] template that can be used to generate a new slide for the slide deck.

Ensure you have the [mason_cli][https://pub.dev/packages/mason_cli] installed:

```sh
dart pub global activate mason_cli
```

Install the [flutter_deck_slide][https://brickhub.dev/bricks/flutter_deck_slide] template:

```sh
# Install locally
mason add flutter_deck_slide

# Install globally
mason add -g flutter_deck_slide
```

Generate a new slide:

```sh
mason make flutter_deck_slide
```
