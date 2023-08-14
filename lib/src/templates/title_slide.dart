import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/flutter_deck_speaker_info.dart';
import 'package:flutter_deck/src/templates/slide_base.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
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
            AutoSizeText(
              title,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              AutoSizeText(
                subtitle!,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
            if (speakerInfo != null) ...[
              const SizedBox(height: 64),
              _SpeakerInfo(speakerInfo: speakerInfo),
            ],
          ],
        ),
      ),
      footerBuilder: footerConfiguration.showFooter
          ? (context) => FlutterDeckFooter.fromConfiguration(
                configuration: footerConfiguration,
                slideNumberColor: colorScheme.onBackground,
                socialHandleColor: colorScheme.onBackground,
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

class _SpeakerInfo extends StatelessWidget {
  const _SpeakerInfo({
    required this.speakerInfo,
  });

  final FlutterDeckSpeakerInfo speakerInfo;

  @override
  Widget build(BuildContext context) {
    const imageHeight = 160.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          speakerInfo.imagePath,
          height: imageHeight,
          width: imageHeight,
        ),
        const SizedBox(width: 32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              speakerInfo.name,
              style: Theme.of(context).textTheme.displaySmall,
              maxLines: 1,
            ),
            AutoSizeText(
              speakerInfo.description,
              style: Theme.of(context).textTheme.headlineMedium,
              maxLines: 1,
            ),
            AutoSizeText(
              speakerInfo.socialHandle,
              style: Theme.of(context).textTheme.headlineMedium,
              maxLines: 1,
            ),
          ],
        ),
      ],
    );
  }
}
