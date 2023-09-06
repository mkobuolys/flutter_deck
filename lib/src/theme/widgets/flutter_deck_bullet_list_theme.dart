import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

///
class FlutterDeckBulletListThemeData {
  ///
  const FlutterDeckBulletListThemeData({
    this.color,
    this.textStyle,
  });

  ///
  final Color? color;

  ///
  final TextStyle? textStyle;

  ///
  FlutterDeckBulletListThemeData copyWith({
    Color? color,
    TextStyle? textStyle,
  }) {
    return FlutterDeckBulletListThemeData(
      color: color ?? this.color,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  ///
  FlutterDeckBulletListThemeData merge(FlutterDeckBulletListThemeData? other) {
    if (other == null) return this;

    return copyWith(
      color: other.color,
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
    );
  }
}

///
class FlutterDeckBulletListTheme extends InheritedTheme {
  ///
  const FlutterDeckBulletListTheme({
    required this.data,
    required super.child,
    super.key,
  });

  ///
  final FlutterDeckBulletListThemeData data;

  ///
  static FlutterDeckBulletListThemeData of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<FlutterDeckBulletListTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).bulletListTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckBulletListTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      FlutterDeckBulletListTheme(data: data, child: child);
}
