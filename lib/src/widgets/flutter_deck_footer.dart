import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_configuration.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';

/// A widget that renders a footer for a slide. The footer can contain the slide
/// number and the speaker's social handle.
class FlutterDeckFooter extends StatelessWidget {
  /// Creates a widget that renders a footer for a slide.
  ///
  /// If [showSlideNumber] is true, the slide number will be rendered. By
  /// default, it is false.
  ///
  /// If [showSocialHandle] is true, the speaker's social handle will be
  /// rendered. By default, it is false.
  ///
  /// If [slideNumberColor] is provided, it will be used for the text color of
  /// the slide number. Otherwise, the color scheme's `onBackground` color will
  /// be used.
  ///
  /// If [socialHandleColor] is provided, it will be used for the text color of
  /// the social handle. Otherwise, the color scheme's `onBackground` color will
  /// be used.
  const FlutterDeckFooter({
    this.showSlideNumber = false,
    this.showSocialHandle = false,
    this.slideNumberColor,
    this.socialHandleColor,
    super.key,
  });

  /// Creates a widget that renders a footer for a slide from a configuration.
  /// The configuration is used to determine whether to show the slide number
  /// and the social handle.
  ///
  /// If [slideNumberColor] is provided, it will be used for the text color of
  /// the slide number. Otherwise, the color scheme's `onBackground` color will
  /// be used.
  ///
  /// If [socialHandleColor] is provided, it will be used for the text color of
  /// the social handle. Otherwise, the color scheme's `onBackground` color will
  /// be used.
  FlutterDeckFooter.fromConfiguration({
    required FlutterDeckFooterConfiguration configuration,
    this.slideNumberColor,
    this.socialHandleColor,
    super.key,
  })  : showSlideNumber = configuration.showSlideNumbers,
        showSocialHandle = configuration.showSocialHandle;

  /// Whether to show the slide number in the footer.
  final bool showSlideNumber;

  /// Whether to show the speaker's social handle in the footer.
  final bool showSocialHandle;

  /// The color to use for the slide number. If not provided, the color scheme's
  /// `onBackground` color will be used.
  final Color? slideNumberColor;

  /// The color to use for the social handle. If not provided, the color
  /// scheme's `onBackground` color will be used.
  final Color? socialHandleColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: FlutterDeckLayout.slidePadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (showSocialHandle)
            Text(
              context.flutterDeck.speakerInfo?.socialHandle ?? '',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: socialHandleColor ?? colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
            )
          else
            const SizedBox.shrink(),
          if (showSlideNumber)
            Text(
              '${context.flutterDeck.slideNumber}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: slideNumberColor ?? colorScheme.onBackground,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
        ],
      ),
    );
  }
}
