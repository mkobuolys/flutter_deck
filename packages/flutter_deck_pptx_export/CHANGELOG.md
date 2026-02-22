# 0.4.0

- chore: update the dependency on `flutter_deck` to `^0.28.0`

# 0.3.1

- fix: use `archive: 4.0.7` to avoid `archive: ^4.0.0` issues

# 0.3.0

- chore: update the dependency on `flutter_deck` to `^0.25.0`

# 0.2.0

- refactor: remove the `FlutterSlideImageRenderer` class
  - **BREAKING**: the `FlutterSlideImageRenderer` was moved to the `flutter_deck` package and renamed to `FlutterDeckSlideImageRenderer`. Thus, importing it from this package will no longer work.
    - **Migration**: import `FlutterDeckSlideImageRenderer` from `package:flutter_deck/flutter_deck.dart` instead.

# 0.1.0+1

- docs: reference Rody in the README.md

# 0.1.0

- feat: add flutter_deck_pptx_export
