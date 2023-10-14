import 'package:flutter/material.dart';
import 'package:flutter_deck/src/theme/flutter_deck_text_theme.dart';
import 'package:flutter_deck/src/theme/templates/templates.dart';
import 'package:flutter_deck/src/theme/widgets/widgets.dart';

const _flutterBlue = Color(0xff0553B1);

/// Defines the visual properties of a slide deck.
///
/// Used by [FlutterDeckTheme] to control the visual properties of a slide deck.
///
/// To obtain the current [FlutterDeckThemeData], use [FlutterDeckTheme.of] to
/// access the closest ancestor [FlutterDeckTheme] of the current
/// [BuildContext].
///
/// See also:
///
/// * [FlutterDeckTheme], an [InheritedWidget] that propagates the theme down
/// its subtree.
class FlutterDeckThemeData {
  /// Creates a theme to style a slide deck.
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

  /// Creates a default light theme to style a slide deck.
  factory FlutterDeckThemeData.light() =>
      FlutterDeckThemeData(brightness: Brightness.light);

  /// Creates a default dark theme to style a slide deck.
  factory FlutterDeckThemeData.dark() =>
      FlutterDeckThemeData(brightness: Brightness.dark);

  /// Creates a theme to style a slide deck from a [ThemeData].
  factory FlutterDeckThemeData.fromTheme(ThemeData theme) {
    final defaultTheme = FlutterDeckThemeData(brightness: theme.brightness);
    final customTheme = FlutterDeckThemeData.fromThemeAndText(
      theme,
      defaultTheme.textTheme,
    );

    return defaultTheme.merge(customTheme);
  }

  /// Creates a theme to style a slide deck from a [ThemeData] and a
  /// [FlutterDeckTextTheme].
  factory FlutterDeckThemeData.fromThemeAndText(
    ThemeData theme,
    FlutterDeckTextTheme textTheme,
  ) {
    final colorScheme = theme.colorScheme;

    return FlutterDeckThemeData._(
      bigFactSlideTheme: FlutterDeckBigFactSlideThemeData(
        titleTextStyle: textTheme.display,
        subtitleTextStyle: textTheme.subtitle,
      ),
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
      imageSlideTheme: FlutterDeckImageSlideThemeData(
        labelTextStyle: textTheme.bodySmall,
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

  /// Creates a theme to style a slide deck.
  ///
  /// This constructor is private because it should not be used directly.
  /// Instead, use one of the public constructors.
  const FlutterDeckThemeData._({
    required this.bigFactSlideTheme,
    required this.bulletListTheme,
    required this.codeHighlightTheme,
    required this.footerTheme,
    required this.headerTheme,
    required this.imageSlideTheme,
    required this.slideTheme,
    required this.speakerInfoWidgetTheme,
    required this.splitSlideTheme,
    required this.titleSlideTheme,
    required this.materialTheme,
    required this.textTheme,
  });

  /// The visual properties of a big fact slide.
  final FlutterDeckBigFactSlideThemeData bigFactSlideTheme;

  /// The visual properties of a bullet list widget.
  final FlutterDeckBulletListThemeData bulletListTheme;

  /// The visual properties of a code highlight widget.
  final FlutterDeckCodeHighlightThemeData codeHighlightTheme;

  /// The visual properties of a footer.
  final FlutterDeckFooterThemeData footerTheme;

  /// The visual properties of a header.
  final FlutterDeckHeaderThemeData headerTheme;

  /// The visual properties of an image slide.
  final FlutterDeckImageSlideThemeData imageSlideTheme;

  /// The base visual properties of a slide.
  final FlutterDeckSlideThemeData slideTheme;

  /// The visual properties of a speaker info widget.
  final FlutterDeckSpeakerInfoWidgetThemeData speakerInfoWidgetTheme;

  /// The visual properties of a split slide.
  final FlutterDeckSplitSlideThemeData splitSlideTheme;

  /// The visual properties of a title slide.
  final FlutterDeckTitleSlideThemeData titleSlideTheme;

  /// The base Material theme used by the slide deck.
  final ThemeData materialTheme;

  /// The visual properties of text.
  final FlutterDeckTextTheme textTheme;

  /// Creates a copy of this theme but with the given fields replaced with the
  /// new values.
  FlutterDeckThemeData copyWith({
    FlutterDeckBigFactSlideThemeData? bigFactSlideTheme,
    FlutterDeckBulletListThemeData? bulletListTheme,
    FlutterDeckCodeHighlightThemeData? codeHighlightTheme,
    FlutterDeckFooterThemeData? footerTheme,
    FlutterDeckHeaderThemeData? headerTheme,
    FlutterDeckImageSlideThemeData? imageSlideTheme,
    FlutterDeckSlideThemeData? slideTheme,
    FlutterDeckSpeakerInfoWidgetThemeData? speakerInfoWidgetTheme,
    FlutterDeckSplitSlideThemeData? splitSlideTheme,
    FlutterDeckTitleSlideThemeData? titleSlideTheme,
    FlutterDeckTextTheme? textTheme,
  }) {
    return FlutterDeckThemeData._(
      bigFactSlideTheme: this.bigFactSlideTheme.merge(bigFactSlideTheme),
      bulletListTheme: this.bulletListTheme.merge(bulletListTheme),
      codeHighlightTheme: this.codeHighlightTheme.merge(codeHighlightTheme),
      footerTheme: this.footerTheme.merge(footerTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      imageSlideTheme: this.imageSlideTheme.merge(imageSlideTheme),
      slideTheme: this.slideTheme.merge(slideTheme),
      speakerInfoWidgetTheme:
          this.speakerInfoWidgetTheme.merge(speakerInfoWidgetTheme),
      splitSlideTheme: this.splitSlideTheme.merge(splitSlideTheme),
      titleSlideTheme: this.titleSlideTheme.merge(titleSlideTheme),
      materialTheme: materialTheme,
      textTheme: this.textTheme.merge(textTheme),
    );
  }

  /// Merge the given [FlutterDeckThemeData] with this one.
  FlutterDeckThemeData merge(FlutterDeckThemeData? other) {
    if (other == null) return this;

    return copyWith(
      bigFactSlideTheme: bigFactSlideTheme.merge(other.bigFactSlideTheme),
      bulletListTheme: bulletListTheme.merge(other.bulletListTheme),
      codeHighlightTheme: codeHighlightTheme.merge(other.codeHighlightTheme),
      footerTheme: footerTheme.merge(other.footerTheme),
      headerTheme: headerTheme.merge(other.headerTheme),
      imageSlideTheme: imageSlideTheme.merge(other.imageSlideTheme),
      slideTheme: slideTheme.merge(other.slideTheme),
      speakerInfoWidgetTheme:
          speakerInfoWidgetTheme.merge(other.speakerInfoWidgetTheme),
      splitSlideTheme: splitSlideTheme.merge(other.splitSlideTheme),
      titleSlideTheme: titleSlideTheme.merge(other.titleSlideTheme),
      textTheme: textTheme.merge(other.textTheme),
    );
  }
}

/// An inherited widget that defines the visual properties of
/// [FlutterDeckTheme].
///
/// Used by [FlutterDeckTheme] to control the visual properties of a slide deck.
class FlutterDeckTheme extends InheritedWidget {
  /// Creates a theme to style a slide deck.
  ///
  /// The [data] argument must not be null.
  const FlutterDeckTheme({
    required this.data,
    required super.child,
    super.key,
  });

  /// The visual properties of a slide deck.
  final FlutterDeckThemeData data;

  /// Returns the [data] from the closest [FlutterDeckTheme] ancestor. If there
  /// is no ancestor, assertion error is thrown.
  static FlutterDeckThemeData of(BuildContext context) {
    final theme =
        context.dependOnInheritedWidgetOfExactType<FlutterDeckTheme>();

    assert(theme != null, 'No FlutterDeckTheme found in context');

    return theme!.data;
  }

  @override
  bool updateShouldNotify(FlutterDeckTheme oldWidget) => data != oldWidget.data;
}

/// An extension on [BuildContext] that simplifies accessing the
/// [FlutterDeckTheme] from the widget tree.
extension FlutterDeckThemeX on BuildContext {
  /// Returns the [FlutterDeckTheme] from the widget tree.
  ///
  /// See [FlutterDeckTheme.of].
  FlutterDeckThemeData get flutterDeckTheme => FlutterDeckTheme.of(this);

  /// Returns whether the dark mode is enabled based on the given [themeMode]
  /// and the current platform brightness.
  bool darkModeEnabled(ThemeMode themeMode) {
    final brightness = MediaQuery.of(this).platformBrightness;

    return switch (themeMode) {
      ThemeMode.system => brightness == Brightness.dark,
      ThemeMode.light => false,
      ThemeMode.dark => true,
    };
  }
}
