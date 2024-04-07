import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/templates/image_slide.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

/// Defines the visual properties of [FlutterDeckImageSlide].
///
/// Used by [FlutterDeckImageSlideTheme] to control the visual properties of
/// slides in a deck.
///
/// To obtain the current [FlutterDeckImageSlideThemeData], use
/// [FlutterDeckImageSlideTheme.of] to access the closest ancestor
/// [FlutterDeckImageSlideTheme] of the current [BuildContext].
///
/// See also:
///
/// * [FlutterDeckImageSlideTheme], an [InheritedWidget] that propagates the
/// theme down its subtree.
/// * [FlutterDeckTheme], which describes the overall theme information for the
/// slide deck.
class FlutterDeckImageSlideThemeData {
  /// Creates a theme to style [FlutterDeckImageSlide].
  const FlutterDeckImageSlideThemeData({
    this.labelTextStyle,
  });

  /// Text style for the image label.
  final TextStyle? labelTextStyle;

  /// Creates a copy of this object with the given fields replaced with the new
  /// values.
  FlutterDeckImageSlideThemeData copyWith({
    TextStyle? labelTextStyle,
  }) {
    return FlutterDeckImageSlideThemeData(
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
    );
  }

  /// Merge the given [FlutterDeckImageSlideThemeData] with this one.
  FlutterDeckImageSlideThemeData merge(FlutterDeckImageSlideThemeData? other) {
    if (other == null) return this;

    return copyWith(
      labelTextStyle:
          labelTextStyle?.merge(other.labelTextStyle) ?? other.labelTextStyle,
    );
  }
}

/// An inherited widget that defines the visual properties of
/// [FlutterDeckImageSlide].
///
/// Used by [FlutterDeckImageSlide] to control the visual properties of slides
/// in the slide deck.
class FlutterDeckImageSlideTheme extends InheritedTheme {
  /// Creates a theme to style [FlutterDeckImageSlide].
  ///
  /// The [data] argument must not be null.
  const FlutterDeckImageSlideTheme({
    required this.data,
    required super.child,
    super.key,
  });

  /// The visual properties of [FlutterDeckImageSlide].
  final FlutterDeckImageSlideThemeData data;

  /// Returns the [data] from the closest [FlutterDeckImageSlideTheme] ancestor.
  /// If there is no ancestor, it returns
  /// [FlutterDeckThemeData.imageSlideTheme].
  ///
  /// The returned theme data will never be null.
  static FlutterDeckImageSlideThemeData of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<FlutterDeckImageSlideTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).imageSlideTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckImageSlideTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      FlutterDeckImageSlideTheme(data: data, child: child);
}
