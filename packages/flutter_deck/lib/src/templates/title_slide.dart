import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
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
/// To use a custom footer, you can pass the [footerBuilder].
///
/// To use a custom header, you can pass the [headerBuilder].
///
/// To use a custom speaker info widget, you can pass the [speakerInfoBuilder].
///
/// This template uses the [FlutterDeckTitleSlideTheme] to style the slide.
class FlutterDeckTitleSlide extends StatelessWidget {
  /// Creates a new title slide.
  ///
  /// The [title] argument must not be null. The [subtitle],
  /// [backgroundBuilder], [footerBuilder], [headerBuilder], and
  /// [speakerInfoBuilder] arguments are optional.
  const FlutterDeckTitleSlide({
    required this.title,
    this.subtitle,
    this.backgroundBuilder,
    this.footerBuilder,
    this.headerBuilder,
    this.speakerInfoBuilder,
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

  /// A builder for the footer of the slide.
  final WidgetBuilder? footerBuilder;

  /// A builder for the header of the slide.
  final WidgetBuilder? headerBuilder;

  /// A builder for the speaker info part of the slide.
  final WidgetBuilder? speakerInfoBuilder;

  Widget _buildFooter(BuildContext context) =>
      footerBuilder?.call(context) ??
      FlutterDeckFooter.fromConfiguration(configuration: context.flutterDeck.configuration.footer);

  Widget _buildHeader(BuildContext context) =>
      headerBuilder?.call(context) ??
      FlutterDeckHeader.fromConfiguration(configuration: context.flutterDeck.configuration.header);

  Widget? _buildSpeakerInfo(BuildContext context) {
    if (speakerInfoBuilder != null) return speakerInfoBuilder!(context);

    final speakerInfo = context.flutterDeck.speakerInfo;

    return speakerInfo != null ? FlutterDeckSpeakerInfoWidget(speakerInfo: speakerInfo) : null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckTitleSlideTheme.of(context);
    final FlutterDeckSlideConfiguration(footer: footerConfiguration, header: headerConfiguration) =
        context.flutterDeck.configuration;
    final speakerInfo = _buildSpeakerInfo(context);

    return FlutterDeckSlideBase(
      backgroundBuilder: backgroundBuilder,
      contentBuilder: (context) => Padding(
        padding: FlutterDeckLayout.slidePadding * 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(child: AutoSizeText(title, style: theme.titleTextStyle)),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Flexible(child: AutoSizeText(subtitle!, style: theme.subtitleTextStyle)),
            ],
            if (speakerInfo != null) ...[const SizedBox(height: 64), speakerInfo],
          ],
        ),
      ),
      footerBuilder: footerConfiguration.showFooter ? _buildFooter : null,
      headerBuilder: headerConfiguration.showHeader ? _buildHeader : null,
    );
  }
}
