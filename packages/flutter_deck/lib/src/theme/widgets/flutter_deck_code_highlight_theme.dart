import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_deck/src/widgets/flutter_deck_code_highlight.dart';

/// Defines the visual properties of [FlutterDeckCodeHighlight].
///
/// Used by [FlutterDeckCodeHighlightTheme] to control the visual properties of
/// the code highlighter in a slide deck.
///
/// To obtain the current [FlutterDeckCodeHighlightThemeData], use
/// [FlutterDeckCodeHighlightTheme.of] to access the closest ancestor
/// [FlutterDeckCodeHighlightTheme] of the current [BuildContext].
///
/// See also:
///
/// * [FlutterDeckCodeHighlightTheme], an [InheritedWidget] that propagates the
/// theme down its subtree.
/// * [FlutterDeckTheme], which describes the overall theme information for the
/// slide deck.
class FlutterDeckCodeHighlightThemeData {
  /// Creates a theme to style [FlutterDeckCodeHighlight].
  const FlutterDeckCodeHighlightThemeData({this.backgroundColor, this.textStyle});

  /// Background color of the code highlighter.
  final Color? backgroundColor;

  /// Text style of the code highlighter.
  final TextStyle? textStyle;

  /// Creates a copy of this object with the given fields replaced with the new
  /// values.
  FlutterDeckCodeHighlightThemeData copyWith({Color? backgroundColor, TextStyle? textStyle}) {
    return FlutterDeckCodeHighlightThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  /// Merge the given [FlutterDeckCodeHighlightThemeData] with this one.
  FlutterDeckCodeHighlightThemeData merge(FlutterDeckCodeHighlightThemeData? other) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor,
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
    );
  }
}

/// An inherited widget that defines the visual properties of
/// [FlutterDeckCodeHighlight].
///
/// Used by [FlutterDeckCodeHighlight] to control the visual properties of
/// the code highlighter in a slide deck.
class FlutterDeckCodeHighlightTheme extends InheritedTheme {
  /// Creates a theme to style [FlutterDeckCodeHighlight].
  ///
  /// The [data] argument must not be null.
  const FlutterDeckCodeHighlightTheme({required this.data, required super.child, super.key});

  /// The visual properties of [FlutterDeckCodeHighlight].
  final FlutterDeckCodeHighlightThemeData data;

  /// Returns the [data] from the closest [FlutterDeckCodeHighlightTheme]
  /// ancestor. If there is no ancestor, it returns
  /// [FlutterDeckThemeData.codeHighlightTheme].
  ///
  /// The returned theme data will never be null.
  static FlutterDeckCodeHighlightThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<FlutterDeckCodeHighlightTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).codeHighlightTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckCodeHighlightTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) => FlutterDeckCodeHighlightTheme(data: data, child: child);
}
