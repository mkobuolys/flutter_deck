import 'package:flutter/material.dart';
import 'package:flutter_deck/src/theme/flutter_deck_text_theme.dart';
import 'package:flutter_deck/src/theme/templates/templates.dart';
import 'package:flutter_deck/src/theme/widgets/widgets.dart';

const _flutterBlue = Color(0xff0553B1);

///
class FlutterDeckThemeData {
  ///
  factory FlutterDeckThemeData({
    Brightness? brightness,
    ThemeData? theme,
    FlutterDeckTextTheme? textTheme,
  }) {
    theme ??= ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness ?? Brightness.light,
        seedColor: _flutterBlue,
      ),
      useMaterial3: true,
    );
    textTheme ??= const FlutterDeckTextTheme().apply(
      color: theme.colorScheme.onBackground,
    );

    return FlutterDeckThemeData.fromThemeAndText(theme, textTheme);
  }

  ///
  factory FlutterDeckThemeData.light() =>
      FlutterDeckThemeData(brightness: Brightness.light);

  ///
  factory FlutterDeckThemeData.dark() =>
      FlutterDeckThemeData(brightness: Brightness.dark);

  ///
  factory FlutterDeckThemeData.fromTheme(ThemeData theme) {
    final defaultTheme = FlutterDeckThemeData(brightness: theme.brightness);
    final customTheme = FlutterDeckThemeData.fromThemeAndText(
      theme,
      defaultTheme.textTheme,
    );

    return defaultTheme.merge(customTheme);
  }

  ///
  factory FlutterDeckThemeData.fromThemeAndText(
    ThemeData theme,
    FlutterDeckTextTheme textTheme,
  ) {
    final colorScheme = theme.colorScheme;

    return FlutterDeckThemeData._(
      bulletListTheme: FlutterDeckBulletListThemeData(
        color: colorScheme.onBackground,
        textStyle: textTheme.title,
      ),
      codeHighlightTheme: FlutterDeckCodeHighlightThemeData(
        backgroundColor: colorScheme.background,
        textStyle: textTheme.bodyMedium,
      ),
      footerTheme: FlutterDeckFooterThemeData(
        slideNumberColor: colorScheme.onBackground,
        slideNumberTextStyle: textTheme.bodySmall,
        socialHandleColor: colorScheme.onBackground,
        socialHandleTextStyle: textTheme.bodyMedium,
      ),
      headerTheme: FlutterDeckHeaderThemeData(
        color: colorScheme.onBackground,
        textStyle: textTheme.header,
      ),
      slideTheme: FlutterDeckSlideThemeData(
        backgroundColor: colorScheme.background,
        color: colorScheme.onBackground,
      ),
      speakerInfoWidgetTheme: FlutterDeckSpeakerInfoWidgetThemeData(
        descriptionTextStyle: textTheme.bodyMedium,
        nameTextStyle: textTheme.bodyLarge,
        socialHandleTextStyle: textTheme.bodyMedium,
      ),
      splitSlideTheme: FlutterDeckSplitSlideThemeData(
        leftBackgroundColor: colorScheme.background,
        leftColor: colorScheme.onBackground,
        rightBackgroundColor: colorScheme.primary,
        rightColor: colorScheme.onPrimary,
      ),
      titleSlideTheme: FlutterDeckTitleSlideThemeData(
        subtitleTextStyle: textTheme.subtitle,
        titleTextStyle: textTheme.title,
      ),
      materialTheme: theme,
      textTheme: textTheme,
    );
  }

  ///
  const FlutterDeckThemeData._({
    required this.bulletListTheme,
    required this.codeHighlightTheme,
    required this.footerTheme,
    required this.headerTheme,
    required this.slideTheme,
    required this.speakerInfoWidgetTheme,
    required this.splitSlideTheme,
    required this.titleSlideTheme,
    required this.materialTheme,
    required this.textTheme,
  });

  ///
  final FlutterDeckBulletListThemeData bulletListTheme;

  ///
  final FlutterDeckCodeHighlightThemeData codeHighlightTheme;

  ///
  final FlutterDeckFooterThemeData footerTheme;

  ///
  final FlutterDeckHeaderThemeData headerTheme;

  ///
  final FlutterDeckSlideThemeData slideTheme;

  ///
  final FlutterDeckSpeakerInfoWidgetThemeData speakerInfoWidgetTheme;

  ///
  final FlutterDeckSplitSlideThemeData splitSlideTheme;

  ///
  final FlutterDeckTitleSlideThemeData titleSlideTheme;

  ///
  final ThemeData materialTheme;

  ///
  final FlutterDeckTextTheme textTheme;

  ///
  FlutterDeckThemeData copyWith({
    FlutterDeckBulletListThemeData? bulletListTheme,
    FlutterDeckCodeHighlightThemeData? codeHighlightTheme,
    FlutterDeckFooterThemeData? footerTheme,
    FlutterDeckHeaderThemeData? headerTheme,
    FlutterDeckSlideThemeData? slideTheme,
    FlutterDeckSpeakerInfoWidgetThemeData? speakerInfoWidgetTheme,
    FlutterDeckSplitSlideThemeData? splitSlideTheme,
    FlutterDeckTitleSlideThemeData? titleSlideTheme,
    FlutterDeckTextTheme? textTheme,
  }) {
    return FlutterDeckThemeData._(
      bulletListTheme: this.bulletListTheme.merge(bulletListTheme),
      codeHighlightTheme: this.codeHighlightTheme.merge(codeHighlightTheme),
      footerTheme: this.footerTheme.merge(footerTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      slideTheme: this.slideTheme.merge(slideTheme),
      speakerInfoWidgetTheme:
          this.speakerInfoWidgetTheme.merge(speakerInfoWidgetTheme),
      splitSlideTheme: this.splitSlideTheme.merge(splitSlideTheme),
      titleSlideTheme: this.titleSlideTheme.merge(titleSlideTheme),
      materialTheme: materialTheme,
      textTheme: this.textTheme.merge(textTheme),
    );
  }

  ///
  FlutterDeckThemeData merge(FlutterDeckThemeData? other) {
    if (other == null) return this;

    return copyWith(
      bulletListTheme: bulletListTheme.merge(other.bulletListTheme),
      codeHighlightTheme: codeHighlightTheme.merge(other.codeHighlightTheme),
      footerTheme: footerTheme.merge(other.footerTheme),
      headerTheme: headerTheme.merge(other.headerTheme),
      slideTheme: slideTheme.merge(other.slideTheme),
      speakerInfoWidgetTheme:
          speakerInfoWidgetTheme.merge(other.speakerInfoWidgetTheme),
      splitSlideTheme: splitSlideTheme.merge(other.splitSlideTheme),
      titleSlideTheme: titleSlideTheme.merge(other.titleSlideTheme),
      textTheme: textTheme.merge(other.textTheme),
    );
  }
}

///
class FlutterDeckTheme extends InheritedWidget {
  ///
  const FlutterDeckTheme({
    required this.data,
    required super.child,
    super.key,
  });

  ///
  final FlutterDeckThemeData data;

  ///
  static FlutterDeckThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<FlutterDeckTheme>();

    assert(theme != null, 'No FlutterDeckTheme found in context');

    return theme!.data;
  }

  @override
  bool updateShouldNotify(FlutterDeckTheme oldWidget) => data != oldWidget.data;
}

///
extension FlutterDeckThemeX on BuildContext {
  ///
  FlutterDeckThemeData get flutterDeckTheme => FlutterDeckTheme.of(this);

  ///
  bool darkModeEnabled(ThemeMode themeMode) {
    final brightness = MediaQuery.of(this).platformBrightness;

    return switch (themeMode) {
      ThemeMode.system => brightness == Brightness.dark,
      ThemeMode.light => false,
      ThemeMode.dark => true,
    };
  }
}
