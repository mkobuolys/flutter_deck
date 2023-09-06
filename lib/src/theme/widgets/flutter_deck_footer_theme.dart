import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

///
class FlutterDeckFooterThemeData {
  ///
  const FlutterDeckFooterThemeData({
    this.slideNumberColor,
    this.slideNumberTextStyle,
    this.socialHandleColor,
    this.socialHandleTextStyle,
  });

  ///
  final Color? slideNumberColor;

  ///
  final TextStyle? slideNumberTextStyle;

  ///
  final Color? socialHandleColor;

  ///
  final TextStyle? socialHandleTextStyle;

  ///
  FlutterDeckFooterThemeData copyWith({
    Color? slideNumberColor,
    TextStyle? slideNumberTextStyle,
    Color? socialHandleColor,
    TextStyle? socialHandleTextStyle,
  }) {
    return FlutterDeckFooterThemeData(
      slideNumberColor: slideNumberColor ?? this.slideNumberColor,
      slideNumberTextStyle: slideNumberTextStyle ?? this.slideNumberTextStyle,
      socialHandleColor: socialHandleColor ?? this.socialHandleColor,
      socialHandleTextStyle:
          socialHandleTextStyle ?? this.socialHandleTextStyle,
    );
  }

  ///
  FlutterDeckFooterThemeData merge(FlutterDeckFooterThemeData? other) {
    if (other == null) return this;

    return copyWith(
      slideNumberColor: other.slideNumberColor,
      slideNumberTextStyle:
          slideNumberTextStyle?.merge(other.slideNumberTextStyle) ??
              other.slideNumberTextStyle,
      socialHandleColor: other.socialHandleColor,
      socialHandleTextStyle:
          socialHandleTextStyle?.merge(other.socialHandleTextStyle) ??
              other.socialHandleTextStyle,
    );
  }
}

///
class FlutterDeckFooterTheme extends InheritedTheme {
  ///
  const FlutterDeckFooterTheme({
    required this.data,
    required super.child,
    super.key,
  });

  ///
  final FlutterDeckFooterThemeData data;

  ///
  static FlutterDeckFooterThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<FlutterDeckFooterTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).footerTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckFooterTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      FlutterDeckFooterTheme(data: data, child: child);
}
