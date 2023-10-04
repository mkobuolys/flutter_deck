import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/templates/big_fact_slide.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

/// Defines the visual properties of [FlutterDeckBigFactSlide].
///
/// Used by [FlutterDeckBigFactSlideTheme] to control the visual properties of
/// slides in a deck.
///
/// To obtain the current [FlutterDeckBigFactSlideThemeData], use
/// [FlutterDeckBigFactSlideTheme.of] to access the closest ancestor
/// [FlutterDeckBigFactSlideTheme] of the current [BuildContext].
///
/// See also:
///
/// * [FlutterDeckBigFactSlideTheme], an [InheritedWidget] that propagates the
/// theme down its subtree.
/// * [FlutterDeckTheme], which describes the overall theme information for the
/// slide deck.
class FlutterDeckBigFactSlideThemeData {
  /// Creates a theme to style [FlutterDeckBigFactSlide].
  const FlutterDeckBigFactSlideThemeData({
    this.titleTextStyle,
    this.subtitleTextStyle,
  });

  /// Text style for the title of the slide.
  final TextStyle? titleTextStyle;

  /// Text style for the subtitle of the slide.
  final TextStyle? subtitleTextStyle;

  /// Creates a copy of this object with the given fields replaced with the new
  /// values.
  FlutterDeckBigFactSlideThemeData copyWith({
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
  }) {
    return FlutterDeckBigFactSlideThemeData(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
    );
  }

  /// Merge the given [FlutterDeckBigFactSlideThemeData] with this one.
  FlutterDeckBigFactSlideThemeData merge(
    FlutterDeckBigFactSlideThemeData? other,
  ) {
    if (other == null) return this;

    return copyWith(
      titleTextStyle:
          titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle?.merge(other.subtitleTextStyle) ??
          other.subtitleTextStyle,
    );
  }
}

/// An inherited widget that defines the visual properties of
/// [FlutterDeckBigFactSlide].
///
/// Used by [FlutterDeckBigFactSlide] to control the visual properties of slides
/// in the slide deck.
class FlutterDeckBigFactSlideTheme extends InheritedTheme {
  /// Creates a theme to style [FlutterDeckBigFactSlide].
  ///
  /// The [data] argument must not be null.
  const FlutterDeckBigFactSlideTheme({
    required this.data,
    required super.child,
    super.key,
  });

  /// The visual properties of [FlutterDeckBigFactSlide].
  final FlutterDeckBigFactSlideThemeData data;

  /// Returns the [data] from the closest [FlutterDeckBigFactSlideTheme]
  /// ancestor.
  /// 
  /// If there is no ancestor, it returns
  /// [FlutterDeckThemeData.bigFactSlideTheme].
  ///
  /// The returned theme data will never be null.
  static FlutterDeckBigFactSlideThemeData of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<FlutterDeckBigFactSlideTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).bigFactSlideTheme;
  }

  @override
  bool updateShouldNotify(covariant FlutterDeckBigFactSlideTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      FlutterDeckBigFactSlideTheme(data: data, child: child);
}
