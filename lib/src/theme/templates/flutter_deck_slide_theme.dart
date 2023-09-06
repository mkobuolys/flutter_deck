import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

///
class FlutterDeckSlideThemeData {
  ///
  const FlutterDeckSlideThemeData({
    this.backgroundColor,
    this.color,
  });

  ///
  final Color? backgroundColor;

  ///
  final Color? color;

  ///
  FlutterDeckSlideThemeData copyWith({
    Color? backgroundColor,
    Color? color,
  }) {
    return FlutterDeckSlideThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      color: color ?? this.color,
    );
  }

  ///
  FlutterDeckSlideThemeData merge(FlutterDeckSlideThemeData? other) {
    if (other == null) return this;

    return copyWith(
      backgroundColor: other.backgroundColor,
      color: other.color,
    );
  }
}

///
class FlutterDeckSlideTheme extends InheritedTheme {
  ///
  const FlutterDeckSlideTheme({
    required this.data,
    required super.child,
    super.key,
  });

  ///
  final FlutterDeckSlideThemeData data;

  ///
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
