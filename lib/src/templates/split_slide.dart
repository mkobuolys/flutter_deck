import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/templates/slide_base.dart';
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
class FlutterDeckSplitSlide extends StatelessWidget {
  /// Creates a new split slide.
  ///
  /// The [leftBuilder] and [rightBuilder] arguments must not be null. The
  /// [backgroundBuilder], [leftBackgroundColor], [rightBackgroundColor], and
  /// [splitRatio] arguments are optional.
  ///
  /// If [splitRatio] is not specified, the left and right columns will have the
  /// same width.
  const FlutterDeckSplitSlide({
    required this.leftBuilder,
    required this.rightBuilder,
    this.backgroundBuilder,
    this.leftBackgroundColor,
    this.rightBackgroundColor,
    SplitSlideRatio? splitRatio,
    super.key,
  }) : splitRatio = splitRatio ?? const SplitSlideRatio();

  /// Creates the content of the left column.
  final WidgetBuilder leftBuilder;

  /// Creates the content of the right column.
  final WidgetBuilder rightBuilder;

  /// A builder for the background of the slide.
  final WidgetBuilder? backgroundBuilder;

  /// The background color of the left column.
  ///
  /// If this is null, the [ColorScheme.background] color of the slide is used.
  final Color? leftBackgroundColor;

  /// The background color of the right column.
  ///
  /// If this is null, the [ColorScheme.primary] color of the slide is used.
  final Color? rightBackgroundColor;

  /// The ratio of the left and right columns.
  ///
  /// By default, the left and right columns will have the same width.
  final SplitSlideRatio splitRatio;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final configuration = context.flutterDeck.configuration;
    final footerConfiguration = configuration.footer;
    final headerConfiguration = configuration.header;

    return FlutterDeckSlideBase(
      backgroundBuilder: (context) => FlutterDeckBackground.custom(
        child: Row(
          children: [
            _BackgroundSection(
              flex: splitRatio.left,
              color: leftBackgroundColor ?? colorScheme.background,
            ),
            _BackgroundSection(
              flex: splitRatio.right,
              color: rightBackgroundColor ?? colorScheme.primary,
            ),
          ],
        ),
      ),
      contentBuilder: (context) => Row(
        children: [
          _ContentSection(flex: splitRatio.left, child: leftBuilder(context)),
          _ContentSection(flex: splitRatio.right, child: rightBuilder(context)),
        ],
      ),
      footerBuilder: footerConfiguration.showFooter
          ? (context) => FlutterDeckFooter.fromConfiguration(
                configuration: footerConfiguration,
                slideNumberColor: colorScheme.onPrimary,
                socialHandleColor: colorScheme.onBackground,
              )
          : null,
      headerBuilder: headerConfiguration.showHeader
          ? (context) => LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth *
                      splitRatio.left /
                      (splitRatio.left + splitRatio.right);

                  return FlutterDeckHeader.fromConfiguration(
                    configuration: headerConfiguration,
                    maxWidth: maxWidth,
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
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: ColoredBox(color: color),
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  const _ContentSection({
    required this.flex,
    required this.child,
  });

  final int flex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: FlutterDeckLayout.slidePadding,
        child: child,
      ),
    );
  }
}
