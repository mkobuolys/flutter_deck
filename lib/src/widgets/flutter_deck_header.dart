import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck_configuration.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/templates/templates.dart';

/// A widget that renders a header for a slide. The header can contain the slide
/// title. The title is rendered as an [AutoSizeText] widget and is
/// automatically resized to fit the available space.
///
/// For the [FlutterDeckSplitSlide] layout, the header is constrained to fit the
/// left side of the slide. For the full-width slide layout, the header is
/// constrained to the width of the slide.
class FlutterDeckHeader extends StatelessWidget {
  /// Creates a widget that renders a header for a slide. The header contains
  /// the [title] of the slide.
  ///
  /// If [maxWidth] is provided, the header will be constrained to that width.
  /// Otherwise, it will be constrained to the width of the slide.
  ///
  /// If [color] is provided, it will be used for the text color of the title.
  const FlutterDeckHeader({
    required this.title,
    this.maxWidth,
    this.color,
    super.key,
  });

  /// Creates a widget that renders a header for a slide from a configuration.
  /// The configuration is used to determine the title of the slide.
  ///
  /// If [maxWidth] is provided, the header will be constrained to that width.
  /// Otherwise, it will be constrained to the width of the slide.
  ///
  /// If [color] is provided, it will be used for the text color of the title.
  FlutterDeckHeader.fromConfiguration({
    required FlutterDeckHeaderConfiguration configuration,
    this.maxWidth,
    this.color,
    super.key,
  }) : title = configuration.title;

  /// The title of the slide.
  final String title;

  /// The color to use for the title. If not provided, the color scheme's
  /// `onBackground` color will be used.
  final Color? color;

  /// The maximum width of the header. If not provided, the header will be
  /// constrained to the width of the slide.
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.displayLarge;

    return Container(
      alignment: Alignment.centerLeft,
      constraints: BoxConstraints(
        maxWidth: maxWidth ?? MediaQuery.of(context).size.width,
      ),
      child: Padding(
        padding: FlutterDeckLayout.slidePadding,
        child: AutoSizeText(
          title,
          style: textStyle?.copyWith(color: color ?? colorScheme.onBackground),
          maxFontSize: textStyle?.fontSize ?? double.infinity,
        ),
      ),
    );
  }
}
