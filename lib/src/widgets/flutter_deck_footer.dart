import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_configuration.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_deck/src/theme/widgets/flutter_deck_footer_theme.dart';

/// A widget that renders a footer for a slide. The footer can contain the slide
/// number, the speaker's social handle and a custom text.
///
/// To customize the footer style, use [FlutterDeckFooterTheme].
///
/// Example:
///
/// ```dart
/// FlutterDeckFooterTheme(
///   data: FlutterDeckFooterThemeData(
///     slideNumberColor: Colors.white,
///     slideNumberTextStyle: FlutterDeckTheme.of(context).textTheme.bodySmall,
///     socialHandleColor: Colors.white,
///     socialHandleTextStyle:
///         FlutterDeckTheme.of(context).textTheme.bodyMedium,
///   ),
///   child: FlutterDeckFooter.fromConfiguration(
///     configuration: const FlutterDeckFooterConfiguration(),
///   ),
/// );
/// ```
class FlutterDeckFooter extends StatelessWidget {
  /// Creates a widget that renders a footer for a slide.
  ///
  /// If [showSlideNumber] is true, the slide number will be rendered. By
  /// default, it is false.
  ///
  /// If [showSocialHandle] is true, the speaker's social handle will be
  /// rendered. By default, it is false. If [widget] is also provided, [widget]
  /// will be rendered instead.
  ///
  /// if [widget] is not null, it will be rendered. By default, it is null.
  const FlutterDeckFooter({
    this.showSlideNumber = false,
    this.showSocialHandle = false,
    this.widget,
    super.key,
  });

  /// Creates a widget that renders a footer for a slide from a configuration.
  /// The configuration is used to determine whether to show the slide number,
  /// the social handle and the text.
  FlutterDeckFooter.fromConfiguration({
    required FlutterDeckFooterConfiguration configuration,
    super.key,
  })  : showSlideNumber = configuration.showSlideNumbers,
        showSocialHandle = configuration.showSocialHandle,
        widget = configuration.widget;

  /// Whether to show the slide number in the footer.
  final bool showSlideNumber;

  /// Whether to show the speaker's social handle in the footer.
  final bool showSocialHandle;

  /// A text to show in the footer.
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckFooterTheme.of(context);

    return Padding(
      padding: FlutterDeckLayout.slidePadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (widget != null)
            DefaultTextStyle(
              style: FlutterDeckTheme.of(context).textTheme.bodySmall,
              child: widget!,
            )
          else if (showSocialHandle)
            Text(
              context.flutterDeck.speakerInfo?.socialHandle ?? '',
              style: theme.socialHandleTextStyle?.copyWith(
                color: theme.socialHandleColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (showSlideNumber)
            Text(
              '${context.flutterDeck.slideNumber}',
              style: theme.slideNumberTextStyle?.copyWith(
                color: theme.slideNumberColor,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
        ],
      ),
    );
  }
}
