import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

///
class FlutterDeckHeaderThemeData {
  ///
  const FlutterDeckHeaderThemeData({
    this.color,
    this.textStyle,
  });

  ///
  final Color? color;

  ///
  final TextStyle? textStyle;

  ///
  FlutterDeckHeaderThemeData copyWith({
    Color? color,
    TextStyle? textStyle,
  }) {
    return FlutterDeckHeaderThemeData(
      color: color ?? this.color,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  ///
  FlutterDeckHeaderThemeData merge(FlutterDeckHeaderThemeData? other) {
    if (other == null) return this;

    return copyWith(
      color: other.color,
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
    );
  }
}

///
class FlutterDeckHeaderTheme extends InheritedTheme {
  ///
  const FlutterDeckHeaderTheme({
    required this.data,
    required super.child,
    super.key,
  });

  ///
  final FlutterDeckHeaderThemeData data;

  ///
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
