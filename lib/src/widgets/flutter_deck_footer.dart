import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_configuration.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/theme/widgets/flutter_deck_footer_theme.dart';

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
  const FlutterDeckFooter({
    this.showSlideNumber = false,
    this.showSocialHandle = false,
    super.key,
  });

  /// Creates a widget that renders a footer for a slide from a configuration.
  /// The configuration is used to determine whether to show the slide number
  /// and the social handle.
  FlutterDeckFooter.fromConfiguration({
    required FlutterDeckFooterConfiguration configuration,
    super.key,
  })  : showSlideNumber = configuration.showSlideNumbers,
        showSocialHandle = configuration.showSocialHandle;

  /// Whether to show the slide number in the footer.
  final bool showSlideNumber;

  /// Whether to show the speaker's social handle in the footer.
  final bool showSocialHandle;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckFooterTheme.of(context);

    return Padding(
      padding: FlutterDeckLayout.slidePadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (showSocialHandle)
            Text(
              context.flutterDeck.speakerInfo?.socialHandle ?? '',
              style: theme.socialHandleTextStyle?.copyWith(
                color: theme.socialHandleColor,
                fontWeight: FontWeight.bold,
              ),
            )
          else
            const SizedBox.shrink(),
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
