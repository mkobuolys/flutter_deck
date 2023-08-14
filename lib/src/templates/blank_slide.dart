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
class FlutterDeckBlankSlide extends StatelessWidget {
  /// Creates a new blank slide.
  ///
  /// The [configuration] argument must not be null. This configuration
  /// overrides the global configuration of the slide deck.
  const FlutterDeckBlankSlide({
    required this.builder,
    this.backgroundBuilder,
    super.key,
  });

  ///
  final WidgetBuilder builder;

  ///
  final WidgetBuilder? backgroundBuilder;

  /// Creates the body of the slide.
  ///
  /// This method is called by the [slide] method. It is responsible for
  /// rendering the body of the slide between the header and footer.
  // Widget body(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final configuration = context.flutterDeck.configuration;
    final footerConfiguration = configuration.footer;
    final headerConfiguration = configuration.header;

    return FlutterDeckSlideBase(
      backgroundBuilder: backgroundBuilder,
      contentBuilder: (context) => Padding(
        padding: FlutterDeckLayout.slidePadding,
        child: builder(context),
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
