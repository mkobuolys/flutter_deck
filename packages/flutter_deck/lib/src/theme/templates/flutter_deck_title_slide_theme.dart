import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/templates/title_slide.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

/// Defines the visual properties of [FlutterDeckTitleSlide].
///
/// Used by [FlutterDeckTitleSlideTheme] to control the visual properties of
/// slides in a deck.
///
/// To obtain the current [FlutterDeckTitleSlideThemeData], use
/// [FlutterDeckTitleSlideTheme.of] to access the closest ancestor
/// [FlutterDeckTitleSlideTheme] of the current [BuildContext].
///
/// See also:
///
/// * [FlutterDeckTitleSlideTheme], an [InheritedWidget] that propagates the
/// theme down its subtree.
/// * [FlutterDeckTheme], which describes the overall theme information for the
/// slide deck.
class FlutterDeckTitleSlideThemeData {
  /// Creates a theme to style [FlutterDeckTitleSlide].
  const FlutterDeckTitleSlideThemeData({this.subtitleTextStyle, this.titleTextStyle});

  /// Text style for the subtitle of the slide.
  final TextStyle? subtitleTextStyle;

  /// Text style for the title of the slide.
  final TextStyle? titleTextStyle;

  /// Creates a copy of this object with the given fields replaced with the new
  /// values.
  FlutterDeckTitleSlideThemeData copyWith({TextStyle? subtitleTextStyle, TextStyle? titleTextStyle}) {
    return FlutterDeckTitleSlideThemeData(
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    );
  }

  /// Merge the given [FlutterDeckTitleSlideThemeData] with this one.
  FlutterDeckTitleSlideThemeData merge(FlutterDeckTitleSlideThemeData? other) {
    if (other == null) return this;

    return copyWith(
      subtitleTextStyle: subtitleTextStyle?.merge(other.subtitleTextStyle) ?? other.subtitleTextStyle,
      titleTextStyle: titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
    );
  }
}

/// An inherited widget that defines the visual properties of
/// [FlutterDeckTitleSlide].
///
/// Used by [FlutterDeckTitleSlide] to control the visual properties of slides
/// in the slide deck.
class FlutterDeckTitleSlideTheme extends InheritedTheme {
  /// Creates a theme to style [FlutterDeckTitleSlide].
  ///
  /// The [data] argument must not be null.
  const FlutterDeckTitleSlideTheme({required this.data, required super.child, super.key});

  /// The visual properties of [FlutterDeckTitleSlide].
  final FlutterDeckTitleSlideThemeData data;

  /// Returns the [data] from the closest [FlutterDeckTitleSlideTheme] ancestor.
  /// If there is no ancestor, it returns
  /// [FlutterDeckThemeData.titleSlideTheme].
  ///
  /// The returned theme data will never be null.
  static FlutterDeckTitleSlideThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<FlutterDeckTitleSlideTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).titleSlideTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckTitleSlideTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) => FlutterDeckTitleSlideTheme(data: data, child: child);
}
