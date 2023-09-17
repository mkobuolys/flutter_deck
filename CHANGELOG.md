# 0.4.1

fix: override text colors for Material text styles

# 0.4.0

- **BREAKING**: refactor: rework the way how a new slide is created

  - **Migration**: every slide must extend the `FlutterDeckSlideWidget` and override the `build` method:

    ```
    class ExampleSlide extends FlutterDeckSlideWidget {
      const ExampleSlide()
          : super(
              configuration: const FlutterDeckSlideConfiguration(
                route: '/example',
              ),
            );

      @override
      FlutterDeckSlide build(BuildContext context) {
        <...>
      }
    }
    ```

  - Instead of extending `FlutterDeckTitleSlide`:

    ```
    class TitleSlide extends FlutterDeckTitleSlide {
      const TitleSlide({super.key})
          : super(
              configuration: const FlutterDeckSlideConfiguration(
                route: '/title-slide',
                footer: FlutterDeckFooterConfiguration(showFooter: false),
              ),
            );

      @override
      String get title => 'Here goes the title of the slide';

      @override
      String? get subtitle => 'Here goes the subtitle of the slide (optional)';
    }
    ```

    use `FlutterDeckSlide.title`:

    ```
    class TitleSlide extends FlutterDeckSlideWidget {
      const TitleSlide()
          : super(
              configuration: const FlutterDeckSlideConfiguration(
                route: '/title-slide',
                footer: FlutterDeckFooterConfiguration(showFooter: false),
              ),
            );

      @override
      FlutterDeckSlide build(BuildContext context) {
        return FlutterDeckSlide.title(
          title: 'Here goes the title of the slide',
          subtitle: 'Here goes the subtitle of the slide (optional)',
        );
      }
    }
    ```

  - Instead of extending `FlutterDeckBlankSlide`:

    ```
    class BlankSlide extends FlutterDeckBlankSlide {
      const BlankSlide({super.key})
          : super(
              configuration: const FlutterDeckSlideConfiguration(
                route: '/blank-slide',
                header: FlutterDeckHeaderConfiguration(
                  title: 'Blank slide template',
                ),
              ),
            );

      @override
      Widget body(BuildContext context) {
        return Text('Here goes the content of the slide');
      }
    }
    ```

    use `FlutterDeckSlide.blank`:

    ```
    class BlankSlide extends FlutterDeckSlideWidget {
      const BlankSlide()
          : super(
              configuration: const FlutterDeckSlideConfiguration(
                route: '/blank-slide',
                header: FlutterDeckHeaderConfiguration(
                  title: 'Blank slide template',
                ),
              ),
            );

      @override
      FlutterDeckSlide build(BuildContext context) {
        return FlutterDeckSlide.blank(
          builder: (context) => const Text('Here goes the content of the slide'),
        );
      }
    }
    ```

  - Instead of extending `FlutterDeckImageSlide`:

    ```
    class ImageSlide extends FlutterDeckImageSlide {
      const ImageSlide({super.key})
          : super(
              configuration: const FlutterDeckSlideConfiguration(
                route: '/image-slide',
                header: FlutterDeckHeaderConfiguration(
                  title: 'Image slide template',
                ),
              ),
            );

      @override
      Image get image => Image.asset('assets/image.png');

      @override
      String? get label => 'Here goes the label of the image (optional)';
    }
    ```

    use `FlutterDeckSlide.image`:

    ```
    class ImageSlide extends FlutterDeckSlideWidget {
      const ImageSlide()
          : super(
              configuration: const FlutterDeckSlideConfiguration(
                route: '/image-slide',
                header: FlutterDeckHeaderConfiguration(
                  title: 'Image slide template',
                ),
              ),
            );

      @override
      FlutterDeckSlide build(BuildContext context) {
        return FlutterDeckSlide.image(
          imageBuilder: (context) => Image.asset('assets/image.png'),
          label: 'Here goes the label of the image (optional)',
        );
      }
    }
    ```

  - Instead of extending `FlutterDeckSplitSlide`:

    ```
    class SplitSlide extends FlutterDeckSplitSlide {
      const SplitSlide({super.key})
          : super(
              configuration: const FlutterDeckSlideConfiguration(
                route: '/split-slide',
                header: FlutterDeckHeaderConfiguration(
                  title: 'Split slide template',
                ),
              ),
            );

      @override
      Widget left(BuildContext context) {
        return Text('Here goes the LEFT section content of the slide');
      }

      @override
      Widget right(BuildContext context) {
        return Text('Here goes the RIGHT section content of the slide');
      }
    }
    ```

    use `FlutterDeckSlide.split`:

    ```
    class SplitSlide extends FlutterDeckSlideWidget {
      const SplitSlide()
          : super(
              configuration: const FlutterDeckSlideConfiguration(
                route: '/split-slide',
                header: FlutterDeckHeaderConfiguration(
                  title: 'Split slide template',
                ),
              ),
            );

      @override
      FlutterDeckSlide build(BuildContext context) {
        return FlutterDeckSlide.split(
          leftBuilder: (context) {
            return const Text('Here goes the LEFT section content of the slide');
          },
          rightBuilder: (context) {
            return const Text('Here goes the RIGHT section content of the slide');
          },
        );
      }
    }
    ```

  - Instead of extending `FlutterDeckSlideBase`:

    ```
    class TemplateSlide extends FlutterDeckSlideBase {
      const TemplateSlide({super.key})
          : super(
              configuration: const FlutterDeckSlideConfiguration(
                route: '/template-slide',
              ),
            );

      @override
      FlutterDeckBackground background(BuildContext context) {
        return FlutterDeckBackground.solid(
          Theme.of(context).colorScheme.background,
        );
      }

      @override
      Widget? content(BuildContext context) {
        return const ColoredBox(
          color: Colors.red,
          child: Text('Content goes here...'),
        );
      }

      @override
      Widget? footer(BuildContext context) {
        return ColoredBox(
          color: Theme.of(context).colorScheme.secondary,
          child: const Text('Footer goes here...'),
        );
      }

      @override
      Widget? header(BuildContext context) {
        return ColoredBox(
          color: Theme.of(context).colorScheme.primary,
          child: const Text('Header goes here...'),
        );
      }
    }
    ```

    use `FlutterDeckSlide.template`:

    ```
    class TemplateSlide extends FlutterDeckSlideWidget {
      const TemplateSlide()
          : super(
              configuration: const FlutterDeckSlideConfiguration(
                route: '/template-slide',
              ),
            );

      @override
      FlutterDeckSlide build(BuildContext context) {
        return FlutterDeckSlide.template(
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
        );
      }
    }
    ```

  - Instead of extending `FlutterDeckSlide`:

    ```
    class CustomSlide extends FlutterDeckSlide {
      const CustomSlide({super.key})
          : super(
              configuration: const FlutterDeckSlideConfiguration(
                route: '/custom-slide',
              ),
            );

      @override
      Widget slide(BuildContext context) {
        return const Text('Here goes your custom slide content...');
      }
    }
    ```

    use `FlutterDeckSlide.custom`:

    ```
    class CustomSlide extends FlutterDeckSlideWidget {
      const CustomSlide()
          : super(
              configuration: const FlutterDeckSlideConfiguration(
                route: '/custom-slide',
              ),
            );

      @override
      FlutterDeckSlide build(BuildContext context) {
        return FlutterDeckSlide.custom(
          builder: (context) {
            return const Text('Here goes your custom slide content...');
          },
        );
      }
    }
    ```

- **BREAKING**: `lightTheme` and `darkTheme` are now of type `FlutterDeckThemeData` instead of `ThemeData`

  - **Migration**: if you have used custom `lightTheme` or `darkTheme`, wrap them with `FlutterDeckThemeData.fromTheme` constructor:

    ```
    return FlutterDeckApp(
      <...>
      lightTheme: FlutterDeckThemeData.fromTheme(
        ThemeData(<...>),
      ),
      darkTheme: FlutterDeckThemeData.fromTheme(
        ThemeData(<...>),
      ),
    );
    ```

- **BREAKING**: removed `leftBackgroundColor` and `rightBackgroundColor` properties from the `FlutterDeckSplitSlide` template. Use `FlutterDeckSplitSlideTheme` instead
- **BREAKING**: removed `color` property from the `FlutterDeckHeader` component. Use `FlutterDeckHeaderTheme` instead
- **BREAKING**: removed `slideNumberColor` and `socialHandleColor` properties from the `FlutterDeckFooter` component. Use `FlutterDeckFooterTheme` instead
- **BREAKING**: removed `textStyle` property from the `FlutterDeckCodeHighlight` component. Use `FlutterDeckCodeHighlightTheme` instead
- feat: implement global slide deck theming
- feat: add `FlutterDeckSpeakerInfoWidget` component to display speaker information
- refactor: remove the redundant `InheritedFlutterDeck` widget
- docs: update README.md and widgets' documentation

# 0.3.0

- feat: handle cursor visibility
- refactor: create `FlutterDeckControls` and `FlutterDeckControlsNotifier` to centralize the flutter deck control logic
- docs: update README.md

# 0.2.0

- **BREAKING**: feat: updated `background` method signature for the `FlutterDeckSlideBase`

  - **Migration**: update the `background` method signature in your code from:

    ```
    Widget? background(BuildContext context)
    ```

    to:

    ```
    FlutterDeckBackground background(BuildContext context)
    ```

  - Instead of:

    ```
    Widget? background(BuildContext context) {
      return null;
    }
    ```

    do:

    ```
    FlutterDeckBackground background(BuildContext context) {
      return FlutterDeckBackground.transparent();
    }
    ```

  - Instead of:

    ```
    Widget? background(BuildContext context) {
      return YourCustomBackgroundWidget();
    }
    ```

    do:

    ```
    FlutterDeckBackground background(BuildContext context) {
      return FlutterDeckBackground.custom(
        child: YourCustomBackgroundWidget(),
      );
    }
    ```

- feat: add FlutterDeckCodeHighlight widget
- feat: make the background configurable for the whole slide deck
- feat: allow to hide slides in the slide deck
- feat: add presentation progress indicator
- fix: drawer toggle
- docs: update the example app and README.md

# 0.1.0+3

- docs: extend README.md with more information, code snippets and presentation examples

# 0.1.0+2

- docs: minor README.md update

# 0.1.0+1

- feat: initial commit 🎉
