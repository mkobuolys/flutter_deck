import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/templates/split_slide.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

/// Defines the visual properties of [FlutterDeckSplitSlide].
///
/// Used by [FlutterDeckSplitSlideTheme] to control the visual properties of
/// slides in a deck.
///
/// To obtain the current [FlutterDeckSplitSlideThemeData], use
/// [FlutterDeckSplitSlideTheme.of] to access the closest ancestor
/// [FlutterDeckSplitSlideTheme] of the current [BuildContext].
///
/// See also:
///
/// * [FlutterDeckSplitSlideTheme], an [InheritedWidget] that propagates the
/// theme down its subtree.
/// * [FlutterDeckTheme], which describes the overall theme information for the
/// slide deck.
class FlutterDeckSplitSlideThemeData {
  /// Creates a theme to style [FlutterDeckSplitSlide].
  const FlutterDeckSplitSlideThemeData({
    this.leftBackgroundColor,
    this.leftColor,
    this.rightBackgroundColor,
    this.rightColor,
  });

  /// Background color of the left side of the slide.
  final Color? leftBackgroundColor;

  /// Text color on the left side of the slide.
  final Color? leftColor;

  /// Background color of the right side of the slide.
  final Color? rightBackgroundColor;

  /// Text color on the right side of the slide.
  final Color? rightColor;

  /// Creates a copy of this object with the given fields replaced with the new
  /// values.
  FlutterDeckSplitSlideThemeData copyWith({
    Color? leftBackgroundColor,
    Color? leftColor,
    Color? rightBackgroundColor,
    Color? rightColor,
  }) {
    return FlutterDeckSplitSlideThemeData(
      leftBackgroundColor: leftBackgroundColor ?? this.leftBackgroundColor,
      leftColor: leftColor ?? this.leftColor,
      rightBackgroundColor: rightBackgroundColor ?? this.rightBackgroundColor,
      rightColor: rightColor ?? this.rightColor,
    );
  }

  /// Merge the given [FlutterDeckSplitSlideThemeData] with this one.
  FlutterDeckSplitSlideThemeData merge(FlutterDeckSplitSlideThemeData? other) {
    if (other == null) return this;

    return copyWith(
      leftBackgroundColor: other.leftBackgroundColor,
      leftColor: other.leftColor,
      rightBackgroundColor: other.rightBackgroundColor,
      rightColor: other.rightColor,
    );
  }
}

/// An inherited widget that defines the visual properties of
/// [FlutterDeckSplitSlide].
///
/// Used by [FlutterDeckSplitSlide] to control the visual properties of slides
/// in the slide deck.
class FlutterDeckSplitSlideTheme extends InheritedTheme {
  /// Creates a theme to style [FlutterDeckSplitSlide].
  ///
  /// The [data] argument must not be null.
  const FlutterDeckSplitSlideTheme({required this.data, required super.child, super.key});

  /// The visual properties of [FlutterDeckSplitSlide].
  final FlutterDeckSplitSlideThemeData data;

  /// Returns the [data] from the closest [FlutterDeckSplitSlideTheme] ancestor.
  /// If there is no ancestor, it returns
  /// [FlutterDeckThemeData.splitSlideTheme].
  ///
  /// The returned theme data will never be null.
  static FlutterDeckSplitSlideThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<FlutterDeckSplitSlideTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).splitSlideTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckSplitSlideTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) => FlutterDeckSplitSlideTheme(data: data, child: child);
}
