import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

///
class FlutterDeckSplitSlideThemeData {
  ///
  const FlutterDeckSplitSlideThemeData({
    this.leftBackgroundColor,
    this.leftColor,
    this.rightBackgroundColor,
    this.rightColor,
  });

  ///
  final Color? leftBackgroundColor;

  ///
  final Color? leftColor;

  ///
  final Color? rightBackgroundColor;

  ///
  final Color? rightColor;

  ///
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

  ///
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

///
class FlutterDeckSplitSlideTheme extends InheritedTheme {
  ///
  const FlutterDeckSplitSlideTheme({
    required this.data,
    required super.child,
    super.key,
  });

  ///
  final FlutterDeckSplitSlideThemeData data;

  ///
  static FlutterDeckSplitSlideThemeData of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<FlutterDeckSplitSlideTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).splitSlideTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckSplitSlideTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      FlutterDeckSplitSlideTheme(data: data, child: child);
}
