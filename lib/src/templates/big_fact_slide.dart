import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/templates/slide_base.dart';
import 'package:flutter_deck/src/theme/templates/flutter_deck_big_fact_slide_theme.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

/// A slide widget that represents a big fact slide.
///
/// This class is used to create a big fact slide in a slide deck. It renders
/// two lines of text, a big [title] (fact) and a [subtitle]. It is also
/// responsible for rendering the default header and footer of the slide deck,
/// if they are enabled in the configuration.
///
/// To use a custom background, you can pass the [backgroundBuilder].
class FlutterDeckBigFactSlide extends StatelessWidget {
  /// Creates a new big fact slide.
  ///
  /// The [title] argument must not be null. The [subtitle] and
  /// [backgroundBuilder] arguments are optional.
  ///
  /// [subtitleMaxLines] is the maximum number of lines for the subtitle. By
  /// default it is 3.
  const FlutterDeckBigFactSlide({
    required this.title,
    this.subtitle,
    int? subtitleMaxLines,
    this.backgroundBuilder,
    super.key,
  }) : subtitleMaxLines = subtitleMaxLines ?? 3;

  /// The title of the slide.
  final String title;

  /// The subtitle of the slide.
  final String? subtitle;

  /// The maximum number of lines for the subtitle.
  final int subtitleMaxLines;

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
              Flexible(
                child: AutoSizeText(
                  title,
                  style: theme.titleTextStyle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 16),
                Flexible(
                  child: AutoSizeText(
                    subtitle!,
                    style: theme.subtitleTextStyle,
                    textAlign: TextAlign.center,
                    maxLines: subtitleMaxLines,
                  ),
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
