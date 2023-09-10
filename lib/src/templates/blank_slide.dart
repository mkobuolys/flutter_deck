import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/templates/slide_base.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

/// A slide widget that represents a blank slide.
///
/// This class is used to create a blank slide in a slide deck. It is
/// responsible for rendering the default header and footer of the slide deck,
/// and rendering the content of the slide using the provided [builder].
///
/// To use a custom background, you can pass the [backgroundBuilder].
class FlutterDeckBlankSlide extends StatelessWidget {
  /// Creates a new blank slide.
  ///
  /// The [builder] argument must not be null. The [backgroundBuilder] argument
  /// is optional.
  const FlutterDeckBlankSlide({
    required this.builder,
    this.backgroundBuilder,
    super.key,
  });

  /// Creates the content of the slide.
  final WidgetBuilder builder;

  /// A builder for the background of the slide.
  final WidgetBuilder? backgroundBuilder;

  @override
  Widget build(BuildContext context) {
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
