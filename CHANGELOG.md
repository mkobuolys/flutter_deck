# NEXT

- feat: handle cursor visibility
- refactor: create `FlutterDeckControls` and `FlutterDeckControlsNotifier` to centralize the flutter deck control logic

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
