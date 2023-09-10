import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_deck/src/widgets/flutter_deck_header.dart';

/// Defines the visual properties of [FlutterDeckHeader].
///
/// Used by [FlutterDeckHeaderTheme] to control the visual properties of the
/// header in a slide deck.
///
/// To obtain the current [FlutterDeckHeaderThemeData], use
/// [FlutterDeckHeaderTheme.of] to access the closest ancestor
/// [FlutterDeckHeaderTheme] of the current [BuildContext].
///
/// See also:
///
/// * [FlutterDeckHeaderTheme], an [InheritedWidget] that propagates the theme
/// down its subtree.
/// * [FlutterDeckTheme], which describes the overall theme information for the
/// slide deck.
class FlutterDeckHeaderThemeData {
  /// Creates a theme to style [FlutterDeckHeader].
  const FlutterDeckHeaderThemeData({
    this.color,
    this.textStyle,
  });

  /// Color of the header.
  final Color? color;

  /// Text style of the header.
  final TextStyle? textStyle;

  /// Creates a copy of this object with the given fields replaced with the new
  /// values.
  FlutterDeckHeaderThemeData copyWith({
    Color? color,
    TextStyle? textStyle,
  }) {
    return FlutterDeckHeaderThemeData(
      color: color ?? this.color,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  /// Merge the given [FlutterDeckHeaderThemeData] with this one.
  FlutterDeckHeaderThemeData merge(FlutterDeckHeaderThemeData? other) {
    if (other == null) return this;

    return copyWith(
      color: other.color,
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
    );
  }
}

/// An inherited widget that defines the visual properties of
/// [FlutterDeckHeader].
///
/// Used by [FlutterDeckHeader] to control the visual properties of the header
/// in a slide deck.
class FlutterDeckHeaderTheme extends InheritedTheme {
  /// Creates a theme to style [FlutterDeckHeader].
  ///
  /// The [data] argument must not be null.
  const FlutterDeckHeaderTheme({
    required this.data,
    required super.child,
    super.key,
  });

  /// The visual properties of [FlutterDeckHeader].
  final FlutterDeckHeaderThemeData data;

  /// Returns the [data] from the closest [FlutterDeckHeaderTheme] ancestor.
  /// If there is no ancestor, it returns [FlutterDeckThemeData.headerTheme].
  ///
  /// The returned theme data will never be null.
  static FlutterDeckHeaderThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<FlutterDeckHeaderTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).headerTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckHeaderTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      FlutterDeckHeaderTheme(data: data, child: child);
}
