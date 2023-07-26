import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/templates/slide_base.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

/// The base class for a blank slide in a slide deck.
///
/// This class is used to create a blank slide in a slide deck. It is
/// responsible for rendering the default header and footer of the slide deck,
/// and placing the content of the [body] of the slide in the correct place.
///
/// To use a custom background, you can override the [background] method.
abstract class FlutterDeckBlankSlide extends FlutterDeckSlideBase {
  /// Creates a new blank slide.
  ///
  /// The [configuration] argument must not be null. This configuration
  /// overrides the global configuration of the slide deck.
  const FlutterDeckBlankSlide({
    required super.configuration,
    super.key,
  });

  /// Creates the body of the slide.
  ///
  /// This method is called by the [slide] method. It is responsible for
  /// rendering the body of the slide between the header and footer.
  Widget body(BuildContext context);

  @override
  Widget? content(BuildContext context) {
    return Padding(
      padding: FlutterDeckLayout.slidePadding,
      child: body(context),
    );
  }

  @override
  Widget? header(BuildContext context) {
    final headerConfiguration = context.flutterDeck.configuration.header;

    return headerConfiguration.showHeader
        ? FlutterDeckHeader.fromConfiguration(
            configuration: headerConfiguration,
          )
        : null;
  }

  @override
  Widget? footer(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final footerConfiguration = context.flutterDeck.configuration.footer;

    return footerConfiguration.showFooter
        ? FlutterDeckFooter.fromConfiguration(
            configuration: footerConfiguration,
            slideNumberColor: colorScheme.onBackground,
            socialHandleColor: colorScheme.onBackground,
          )
        : null;
  }

  @override
  Widget? background(BuildContext context) => null;
}
