import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

///
class FlutterDeckTitleSlideThemeData {
  ///
  const FlutterDeckTitleSlideThemeData({
    this.subtitleTextStyle,
    this.titleTextStyle,
  });

  ///
  final TextStyle? subtitleTextStyle;

  ///
  final TextStyle? titleTextStyle;

  ///
  FlutterDeckTitleSlideThemeData copyWith({
    TextStyle? subtitleTextStyle,
    TextStyle? titleTextStyle,
  }) {
    return FlutterDeckTitleSlideThemeData(
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
    );
  }

  ///
  FlutterDeckTitleSlideThemeData merge(FlutterDeckTitleSlideThemeData? other) {
    if (other == null) return this;

    return copyWith(
      subtitleTextStyle: subtitleTextStyle?.merge(other.subtitleTextStyle) ??
          other.subtitleTextStyle,
      titleTextStyle:
          titleTextStyle?.merge(other.titleTextStyle) ?? other.titleTextStyle,
    );
  }
}

///
class FlutterDeckTitleSlideTheme extends InheritedTheme {
  ///
  const FlutterDeckTitleSlideTheme({
    required this.data,
    required super.child,
    super.key,
  });

  ///
  final FlutterDeckTitleSlideThemeData data;

  ///
  static FlutterDeckTitleSlideThemeData of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<FlutterDeckTitleSlideTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).titleSlideTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckTitleSlideTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      FlutterDeckTitleSlideTheme(data: data, child: child);
}
