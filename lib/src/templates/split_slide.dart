import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/templates/slide_base.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_deck/src/theme/templates/flutter_deck_split_slide_theme.dart';
import 'package:flutter_deck/src/theme/widgets/flutter_deck_footer_theme.dart';
import 'package:flutter_deck/src/theme/widgets/flutter_deck_header_theme.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

/// A split ratio for a [FlutterDeckSplitSlide].
///
/// This class is used to specify the ratio of the two columns and works in the
/// same way as the [Expanded.flex] property.
class SplitSlideRatio {
  /// Creates a new split ratio.
  ///
  /// By default, the left and right columns will have the same width.
  const SplitSlideRatio({
    this.left = 1,
    this.right = 1,
  });

  /// The ratio of the left column.
  final int left;

  /// The ratio of the right column.
  final int right;
}

/// A slide widget that represents a slide with two columns.
///
/// This class is used to create a slide that contains two columns side by side.
/// It is responsible for rendering the default header and footer of the slide
/// deck, and use the [leftBuilder] and [rightBuilder] to create the content of
/// the left and right columns.
///
/// To use a custom background, you can pass the [backgroundBuilder].
///
/// This template uses the [FlutterDeckSplitSlideTheme] to style the slide.
class FlutterDeckSplitSlide extends StatelessWidget {
  /// Creates a new split slide.
  ///
  /// The [leftBuilder] and [rightBuilder] arguments must not be null. The
  /// [backgroundBuilder] and [splitRatio] arguments are optional.
  ///
  /// If [splitRatio] is not specified, the left and right columns will have the
  /// same width.
  const FlutterDeckSplitSlide({
    required this.leftBuilder,
    required this.rightBuilder,
    this.backgroundBuilder,
    SplitSlideRatio? splitRatio,
    super.key,
  }) : splitRatio = splitRatio ?? const SplitSlideRatio();

  /// Creates the content of the left column.
  final WidgetBuilder leftBuilder;

  /// Creates the content of the right column.
  final WidgetBuilder rightBuilder;

  /// A builder for the background of the slide.
  final WidgetBuilder? backgroundBuilder;

  /// The ratio of the left and right columns.
  ///
  /// By default, the left and right columns will have the same width.
  final SplitSlideRatio splitRatio;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckSplitSlideTheme.of(context);
    final configuration = context.flutterDeck.configuration;
    final footerConfiguration = configuration.footer;
    final headerConfiguration = configuration.header;

    return FlutterDeckSlideBase(
      backgroundBuilder: (context) => FlutterDeckBackground.custom(
        child: Row(
          children: [
            _BackgroundSection(
              flex: splitRatio.left,
              color: theme.leftBackgroundColor,
            ),
            _BackgroundSection(
              flex: splitRatio.right,
              color: theme.rightBackgroundColor,
            ),
          ],
        ),
      ),
      contentBuilder: (context) => Row(
        children: [
          _ContentSection(
            flex: splitRatio.left,
            color: theme.leftColor,
            builder: leftBuilder,
          ),
          _ContentSection(
            flex: splitRatio.right,
            color: theme.rightColor,
            builder: rightBuilder,
          ),
        ],
      ),
      footerBuilder: footerConfiguration.showFooter
          ? (context) => FlutterDeckFooterTheme(
                data: FlutterDeckFooterTheme.of(context).copyWith(
                  slideNumberColor: theme.rightColor,
                  socialHandleColor: theme.leftColor,
                ),
                child: FlutterDeckFooter.fromConfiguration(
                  configuration: footerConfiguration,
                ),
              )
          : null,
      headerBuilder: headerConfiguration.showHeader
          ? (context) => LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth *
                      splitRatio.left /
                      (splitRatio.left + splitRatio.right);

                  return FlutterDeckHeaderTheme(
                    data: FlutterDeckHeaderTheme.of(context).copyWith(
                      color: theme.leftColor,
                    ),
                    child: FlutterDeckHeader.fromConfiguration(
                      configuration: headerConfiguration,
                      maxWidth: maxWidth,
                    ),
                  );
                },
              )
          : null,
    );
  }
}

class _BackgroundSection extends StatelessWidget {
  const _BackgroundSection({
    required this.flex,
    required this.color,
  });

  final int flex;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: ColoredBox(color: color ?? Colors.transparent),
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  const _ContentSection({
    required this.flex,
    required this.color,
    required this.builder,
  });

  final int flex;
  final Color? color;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context);

    return FlutterDeckTheme(
      data: theme.copyWith(textTheme: theme.textTheme.apply(color: color)),
      child: Builder(
        builder: (context) => Expanded(
          flex: flex,
          child: Padding(
            padding: FlutterDeckLayout.slidePadding,
            child: builder(context),
          ),
        ),
      ),
    );
  }
}
