import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/templates/templates.dart';

/// A slide widget that represents a big fact Slide
/// This class is used to create the big fact slide in a slide deck.
/// It renders two lines of text, a Big title and a subtitle.
/// It reders the default header and footer of the slide deck, if they are
/// enabled in the configuration.

class FlutterDeckBigFactSlide extends StatelessWidget {
  /// Creates a new title slide.
  /// The [title] and [subtitle] arguments must not be null.
  /// The [backgroundBuilder] argument is optional.
  /// The [titleMaxLines] is the maximum number of lines for the title by
  /// default = 3.
  const FlutterDeckBigFactSlide({
    required this.title,
    this.subtitle,
    this.titleMaxLines,
    this.backgroundBuilder,
    super.key,
  });

  /// The title of the slide.
  final String title;

  /// The subtitle of the slide.
  final String? subtitle;

  /// maxLines for the title of the slide.
  final int? titleMaxLines;

  /// A builder for the background of the slide.
  final WidgetBuilder? backgroundBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckBigFactSlideTheme.of(context);
    final configuration = context.flutterDeck.configuration;
    final footerConfiguration = configuration.footer;
    final headerConfiguration = configuration.header;
    return FlutterDeckSlideBase(
      backgroundBuilder: backgroundBuilder,
      contentBuilder: (context) => Padding(
        padding: FlutterDeckLayout.slidePadding * 4,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                title,
                style: theme.titleTextStyle,
                textAlign: TextAlign.center,
                maxLines: titleMaxLines ?? 3,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                AutoSizeText(
                  subtitle!,
                  style: theme.subtitleTextStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
      footerBuilder: footerConfiguration.showFooter
          ? (context) => FlutterDeckFooter.fromConfiguration(
                configuration: footerConfiguration,
              )
          : null,
      headerBuilder: headerConfiguration.showHeader
          ? (context) => FlutterDeckHeader.fromConfiguration(
                configuration: headerConfiguration,
              )
          : null,
    );
  }
}
