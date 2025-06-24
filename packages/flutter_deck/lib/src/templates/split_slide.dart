import 'package:flutter/material.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
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
  const SplitSlideRatio({this.left = 1, this.right = 1});

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
/// To use a custom footer, you can pass the [footerBuilder].
///
/// To use a custom header, you can pass the [headerBuilder].
///
/// This template uses the [FlutterDeckSplitSlideTheme] to style the slide.
class FlutterDeckSplitSlide extends StatelessWidget {
  /// Creates a new split slide.
  ///
  /// The [leftBuilder] and [rightBuilder] arguments must not be null. The
  /// [backgroundBuilder], [footerBuilder], [headerBuilder] and [splitRatio]
  /// arguments are optional.
  ///
  /// If [splitRatio] is not specified, the left and right columns will have the
  /// same width.
  const FlutterDeckSplitSlide({
    required this.leftBuilder,
    required this.rightBuilder,
    this.backgroundBuilder,
    this.footerBuilder,
    this.headerBuilder,
    SplitSlideRatio? splitRatio,
    super.key,
  }) : splitRatio = splitRatio ?? const SplitSlideRatio();

  /// Creates the content of the left column.
  final WidgetBuilder leftBuilder;

  /// Creates the content of the right column.
  final WidgetBuilder rightBuilder;

  /// A builder for the background of the slide.
  final WidgetBuilder? backgroundBuilder;

  /// A builder for the footer of the slide.
  final WidgetBuilder? footerBuilder;

  /// A builder for the header of the slide.
  final WidgetBuilder? headerBuilder;

  /// The ratio of the left and right columns.
  ///
  /// By default, the left and right columns will have the same width.
  final SplitSlideRatio splitRatio;

  Widget _buildFooter(BuildContext context) {
    final theme = FlutterDeckSplitSlideTheme.of(context);

    return footerBuilder?.call(context) ??
        FlutterDeckFooterTheme(
          data: FlutterDeckFooterTheme.of(
            context,
          ).copyWith(slideNumberColor: theme.rightColor, socialHandleColor: theme.leftColor),
          child: FlutterDeckFooter.fromConfiguration(configuration: context.flutterDeck.configuration.footer),
        );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = FlutterDeckSplitSlideTheme.of(context);

    return headerBuilder?.call(context) ??
        LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth * splitRatio.left / (splitRatio.left + splitRatio.right);

            return FlutterDeckHeaderTheme(
              data: FlutterDeckHeaderTheme.of(context).copyWith(color: theme.leftColor),
              child: FlutterDeckHeader.fromConfiguration(
                configuration: context.flutterDeck.configuration.header,
                maxWidth: maxWidth,
              ),
            );
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckSplitSlideTheme.of(context);
    final FlutterDeckSlideConfiguration(footer: footerConfiguration, header: headerConfiguration) =
        context.flutterDeck.configuration;

    return FlutterDeckSlideBase(
      backgroundBuilder:
          backgroundBuilder ??
          (context) => FlutterDeckBackground.custom(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _BackgroundSection(flex: splitRatio.left, color: theme.leftBackgroundColor),
                _BackgroundSection(flex: splitRatio.right, color: theme.rightBackgroundColor),
              ],
            ),
          ),
      contentBuilder: (context) => Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ContentSection(flex: splitRatio.left, color: theme.leftColor, builder: leftBuilder),
          _ContentSection(flex: splitRatio.right, color: theme.rightColor, builder: rightBuilder),
        ],
      ),
      footerBuilder: footerConfiguration.showFooter ? _buildFooter : null,
      headerBuilder: headerConfiguration.showHeader ? _buildHeader : null,
    );
  }
}

class _BackgroundSection extends StatelessWidget {
  const _BackgroundSection({required this.flex, required this.color});

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
  const _ContentSection({required this.flex, required this.color, required this.builder});

  final int flex;
  final Color? color;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final materialTheme = Theme.of(context);
    final theme = FlutterDeckTheme.of(context);

    return Theme(
      data: materialTheme.copyWith(
        textTheme: materialTheme.textTheme.apply(bodyColor: color, displayColor: color, decorationColor: color),
      ),
      child: FlutterDeckTheme(
        data: theme.copyWith(textTheme: theme.textTheme.apply(color: color)),
        child: Builder(
          builder: (context) => Expanded(
            flex: flex,
            child: Padding(padding: FlutterDeckLayout.slidePadding, child: builder(context)),
          ),
        ),
      ),
    );
  }
}
