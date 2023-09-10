import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck_slide.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

/// Defines the base visual properties of [FlutterDeckSlide].
///
/// Used by [FlutterDeckSlideTheme] to control the base visual properties of
/// slides in a deck.
///
/// To obtain the current [FlutterDeckSlideThemeData], use
/// [FlutterDeckSlideTheme.of] to access the closest ancestor
/// [FlutterDeckSlideTheme] of the current [BuildContext].
///
/// See also:
///
/// * [FlutterDeckSlideTheme], an [InheritedWidget] that propagates the theme
///  down its subtree.
/// * [FlutterDeckTheme], which describes the overall theme information for the
///  slide deck.
class FlutterDeckSlideThemeData {
  /// Creates a base theme to style [FlutterDeckSlide].
  const FlutterDeckSlideThemeData({
    this.backgroundColor,
    this.color,
  });

  /// Background color of the slide.
  ///
  /// This color is used only if background properties are not specified in the
  /// slide configuration.
  final Color? backgroundColor;

  /// The default text color in the slide.
  final Color? color;

  /// Creates a copy of this object with the given fields replaced with the new
  /// values.
  FlutterDeckSlideThemeData copyWith({
    Color? backgroundColor,
    Color? color,
  }) {
    return FlutterDeckSlideThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      color: color ?? this.color,
    );
  }

  /// Merge the given [FlutterDeckSlideThemeData] with this one.
  FlutterDeckSlideThemeData merge(FlutterDeckSlideThemeData? other) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor,
      color: other.color,
    );
  }
}

/// An inherited widget that defines the base visual properties of
/// [FlutterDeckSlide].
///
/// Used by [FlutterDeckSlide] to control the base visual properties of slides
/// in the slide deck.
class FlutterDeckSlideTheme extends InheritedTheme {
  /// Creates a base theme to style [FlutterDeckSlide].
  ///
  /// The [data] argument must not be null.
  const FlutterDeckSlideTheme({
    required this.data,
    required super.child,
    super.key,
  });

  /// The base visual properties of [FlutterDeckSlide].
  final FlutterDeckSlideThemeData data;

  /// Returns the [data] from the closest [FlutterDeckSlideTheme] ancestor. If
  /// there is no ancestor, it returns [FlutterDeckThemeData.slideTheme].
  ///
  /// The returned theme data will never be null.
  static FlutterDeckSlideThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<FlutterDeckSlideTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).slideTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckSlideTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      FlutterDeckSlideTheme(data: data, child: child);
}
