import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/templates/slide_base.dart';
import 'package:flutter_deck/src/theme/templates/flutter_deck_quote_slide_theme.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

/// A slide widget that represents a quote slide.
///
/// This class is used to create a quote slide in a slide deck. It renders two
/// lines of text, a [quote] and an [attribution]. It is also responsible for
/// rendering the default header and footer of the slide deck, if they are
/// enabled in the configuration.
///
/// To use a custom background, you can pass the [backgroundBuilder].
///
/// To use a custom footer, you can pass the [footerBuilder].
///
/// To use a custom header, you can pass the [headerBuilder].
///
/// This template uses the [FlutterDeckQuoteSlideTheme] to style the slide.
class FlutterDeckQuoteSlide extends StatelessWidget {
  /// Creates a new quote slide.
  ///
  /// The [quote] argument must not be null. The [attribution],
  /// [backgroundBuilder], [footerBuilder], and [headerBuilder] arguments are
  /// optional.
  ///
  /// [quoteMaxLines] is the maximum number of lines for the quote. By default
  /// it is 5.
  const FlutterDeckQuoteSlide({
    required this.quote,
    this.attribution,
    int? quoteMaxLines,
    this.backgroundBuilder,
    this.footerBuilder,
    this.headerBuilder,
    super.key,
  }) : quoteMaxLines = quoteMaxLines ?? 5;

  /// The quote of the slide.
  final String quote;

  /// The attribution of the quote.
  final String? attribution;

  /// The maximum number of lines for the quote.
  final int quoteMaxLines;

  /// A builder for the background of the slide.
  final WidgetBuilder? backgroundBuilder;

  /// A builder for the footer of the slide.
  final WidgetBuilder? footerBuilder;

  /// A builder for the header of the slide.
  final WidgetBuilder? headerBuilder;

  Widget _buildFooter(BuildContext context) =>
      footerBuilder?.call(context) ??
      FlutterDeckFooter.fromConfiguration(configuration: context.flutterDeck.configuration.footer);

  Widget _buildHeader(BuildContext context) =>
      headerBuilder?.call(context) ??
      FlutterDeckHeader.fromConfiguration(configuration: context.flutterDeck.configuration.header);

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckQuoteSlideTheme.of(context);
    final FlutterDeckSlideConfiguration(footer: footerConfiguration, header: headerConfiguration) =
        context.flutterDeck.configuration;

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
                  quote,
                  style: theme.quoteTextStyle,
                  textAlign: TextAlign.center,
                  maxLines: quoteMaxLines,
                ),
              ),
              if (attribution != null) ...[
                const SizedBox(height: 16),
                Flexible(
                  child: AutoSizeText(
                    attribution!,
                    style: theme.attributionTextStyle,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      footerBuilder: footerConfiguration.showFooter ? _buildFooter : null,
      headerBuilder: headerConfiguration.showHeader ? _buildHeader : null,
    );
  }
}
