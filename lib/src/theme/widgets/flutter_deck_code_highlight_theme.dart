import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

///
class FlutterDeckCodeHighlightThemeData {
  ///
  const FlutterDeckCodeHighlightThemeData({
    this.backgroundColor,
    this.textStyle,
  });

  ///
  final Color? backgroundColor;

  ///
  final TextStyle? textStyle;

  ///
  FlutterDeckCodeHighlightThemeData copyWith({
    Color? backgroundColor,
    TextStyle? textStyle,
  }) {
    return FlutterDeckCodeHighlightThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  ///
  FlutterDeckCodeHighlightThemeData merge(
    FlutterDeckCodeHighlightThemeData? other,
  ) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor,
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
    );
  }
}

///
class FlutterDeckCodeHighlightTheme extends InheritedTheme {
  ///
  const FlutterDeckCodeHighlightTheme({
    required this.data,
    required super.child,
    super.key,
  });

  ///
  final FlutterDeckCodeHighlightThemeData data;

  ///
  static FlutterDeckCodeHighlightThemeData of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<FlutterDeckCodeHighlightTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).codeHighlightTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckCodeHighlightTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      FlutterDeckCodeHighlightTheme(data: data, child: child);
}
