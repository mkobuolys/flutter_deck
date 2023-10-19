import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/flutter_deck_speaker_info.dart';
import 'package:flutter_deck/src/templates/slide_base.dart';
import 'package:flutter_deck/src/theme/templates/flutter_deck_title_slide_theme.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

/// A slide widget that represents a title slide.
///
/// This class is used to create the title slide in a slide deck. It is
/// responsible for rendering the default header and footer of the slide deck,
/// and placing the [title] and [subtitle] in the correct places. Also, if the
/// [FlutterDeckSpeakerInfo] is set, it will render the speaker info below the
/// title and subtitle.
///
/// To use a custom background, you can pass the [backgroundBuilder].
///
/// This template uses the [FlutterDeckTitleSlideTheme] to style the slide.
class FlutterDeckTitleSlide extends StatelessWidget {
  /// Creates a new title slide.
  ///
  /// The [title] argument must not be null. The [subtitle] and
  /// [backgroundBuilder] arguments are optional.
  const FlutterDeckTitleSlide({
    required this.title,
    this.subtitle,
    this.backgroundBuilder,
    super.key,
  });

  /// The title of the slide.
  final String title;

  /// The subtitle of the slide.
  ///
  /// If this is null, no subtitle will be displayed.
  final String? subtitle;

  /// A builder for the background of the slide.
  final WidgetBuilder? backgroundBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckTitleSlideTheme.of(context);
    final configuration = context.flutterDeck.configuration;
    final footerConfiguration = configuration.footer;
    final headerConfiguration = configuration.header;
    final speakerInfo = context.flutterDeck.speakerInfo;

    return FlutterDeckSlideBase(
      backgroundBuilder: backgroundBuilder,
      contentBuilder: (context) => Padding(
        padding: FlutterDeckLayout.slidePadding * 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AutoSizeText(title, style: theme.titleTextStyle),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Expanded(
                child: AutoSizeText(subtitle!, style: theme.subtitleTextStyle),
              ),
            ],
            if (speakerInfo != null) ...[
              const SizedBox(height: 64),
              FlutterDeckSpeakerInfoWidget(speakerInfo: speakerInfo),
            ],
          ],
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
