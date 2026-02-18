import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/templates/templates.dart';

/// A signature for a function that builds a big fact slide.
typedef FlutterDeckBigFactSlideBuilder =
    Widget Function(
      BuildContext context,
      String title,
      String? subtitle,
      WidgetBuilder? backgroundBuilder,
      WidgetBuilder? footerBuilder,
      WidgetBuilder? headerBuilder,
      int? subtitleMaxLines,
    );

/// A signature for a function that builds a blank slide.
typedef FlutterDeckBlankSlideBuilder =
    Widget Function(
      BuildContext context,
      WidgetBuilder builder,
      WidgetBuilder? backgroundBuilder,
      WidgetBuilder? footerBuilder,
      WidgetBuilder? headerBuilder,
    );

/// A signature for a function that builds an image slide.
typedef FlutterDeckImageSlideBuilder =
    Widget Function(
      BuildContext context,
      Image Function(BuildContext context) imageBuilder,
      String? label,
      WidgetBuilder? backgroundBuilder,
      WidgetBuilder? footerBuilder,
      WidgetBuilder? headerBuilder,
    );

/// A signature for a function that builds a quote slide.
typedef FlutterDeckQuoteSlideBuilder =
    Widget Function(
      BuildContext context,
      String quote,
      String? attribution,
      int? quoteMaxLines,
      WidgetBuilder? backgroundBuilder,
      WidgetBuilder? footerBuilder,
      WidgetBuilder? headerBuilder,
    );

/// A signature for a function that builds a split slide.
typedef FlutterDeckSplitSlideBuilder =
    Widget Function(
      BuildContext context,
      WidgetBuilder leftBuilder,
      WidgetBuilder rightBuilder,
      WidgetBuilder? backgroundBuilder,
      WidgetBuilder? footerBuilder,
      WidgetBuilder? headerBuilder,
      SplitSlideRatio? splitRatio,
    );

/// A signature for a function that builds a template slide.
typedef FlutterDeckTemplateSlideBuilder =
    Widget Function(
      BuildContext context,
      WidgetBuilder? backgroundBuilder,
      WidgetBuilder? contentBuilder,
      WidgetBuilder? footerBuilder,
      WidgetBuilder? headerBuilder,
    );

/// A signature for a function that builds a title slide.
typedef FlutterDeckTitleSlideBuilder =
    Widget Function(
      BuildContext context,
      String title,
      String? subtitle,
      WidgetBuilder? backgroundBuilder,
      WidgetBuilder? footerBuilder,
      WidgetBuilder? headerBuilder,
      WidgetBuilder? speakerInfoBuilder,
    );

/// The configuration for the slide deck template overrides.
///
/// This configuration allows overriding the default slide templates.
class FlutterDeckTemplateOverrideConfiguration {
  /// Creates a configuration for the slide deck template overrides.
  const FlutterDeckTemplateOverrideConfiguration({
    this.bigFactSlideBuilder,
    this.blankSlideBuilder,
    this.imageSlideBuilder,
    this.quoteSlideBuilder,
    this.splitSlideBuilder,
    this.templateSlideBuilder,
    this.titleSlideBuilder,
  });

  /// The builder for the big fact slide.
  final FlutterDeckBigFactSlideBuilder? bigFactSlideBuilder;

  /// The builder for the blank slide.
  final FlutterDeckBlankSlideBuilder? blankSlideBuilder;

  /// The builder for the image slide.
  final FlutterDeckImageSlideBuilder? imageSlideBuilder;

  /// The builder for the quote slide.
  final FlutterDeckQuoteSlideBuilder? quoteSlideBuilder;

  /// The builder for the split slide.
  final FlutterDeckSplitSlideBuilder? splitSlideBuilder;

  /// The builder for the template slide.
  final FlutterDeckTemplateSlideBuilder? templateSlideBuilder;

  /// The builder for the title slide.
  final FlutterDeckTitleSlideBuilder? titleSlideBuilder;
}
