import 'package:flutter/material.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
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
///
/// To use a custom footer, you can pass the [footerBuilder].
///
/// To use a custom header, you can pass the [headerBuilder].
class FlutterDeckBlankSlide extends StatelessWidget {
  /// Creates a new blank slide.
  ///
  /// The [builder] argument must not be null. The [backgroundBuilder],
  /// [footerBuilder], and [headerBuilder] argument are optional.
  const FlutterDeckBlankSlide({
    required this.builder,
    this.backgroundBuilder,
    this.footerBuilder,
    this.headerBuilder,
    super.key,
  });

  /// Creates the content of the slide.
  final WidgetBuilder builder;

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
    final FlutterDeckSlideConfiguration(footer: footerConfiguration, header: headerConfiguration) =
        context.flutterDeck.configuration;

    return FlutterDeckSlideBase(
      backgroundBuilder: backgroundBuilder,
      contentBuilder: (context) => Padding(padding: FlutterDeckLayout.slidePadding, child: builder(context)),
      footerBuilder: footerConfiguration.showFooter ? _buildFooter : null,
      headerBuilder: headerConfiguration.showHeader ? _buildHeader : null,
    );
  }
}
