<p align="center">
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-purple.svg" alt="License: MIT"></a>
<a href="https://github.com/felangel/mason"><img src="https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge" alt="Powered by Mason"></a>
</p>

Generate a new slide for the slide deck. Built for the [flutter_deck package][1].

## Usage 🚀

```sh
mason make flutter_deck_slide --name new --template blank
```

## Variables ✨

| Variable   | Description                 | Default                                                                 | Type     |
| ---------- | --------------------------- | ----------------------------------------------------------------------- | -------- |
| `name`     | The name of the slide class | `new`                                                                   | `string` |
| `template` | The template of the slide   | `blank (big-fact, blank, custom, image, quote, split, template, title)` | `enum`   |

## Output 📦

### Generated files

```sh
└── new_slide.dart
```

### Generated code

```dart
class NewSlide extends FlutterDeckSlideWidget {
  const NewSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/new',
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => const Placeholder(),
    );
  }
}
```

[1]: https://github.com/mkobuolys/flutter_deck
