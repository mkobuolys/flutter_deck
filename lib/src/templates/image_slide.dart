import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/templates/slide_base.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

/// The base class for a slide that only contains an image.
///
/// This class is used to create a slide that only contains an image. It is
/// responsible for rendering the default header and footer of the slide deck,
/// and placing the [image] in the correct place.
///
/// To use a custom background, you can override the [background] method.
abstract class FlutterDeckImageSlide extends FlutterDeckSlideBase {
  /// Creates a new image slide.
  ///
  /// The [configuration] argument must not be null. This configuration
  /// overrides the global configuration of the slide deck.
  const FlutterDeckImageSlide({
    required super.configuration,
    super.key,
  });

  /// The image to display in the slide.
  Image get image;

  /// The label to display below the image.
  ///
  /// If this is null, no label will be displayed.
  String? get label => null;

  @override
  Widget? content(BuildContext context) {
    return Padding(
      padding: FlutterDeckLayout.slidePadding,
      child: Column(
        children: [
          Expanded(
            child: Center(child: image),
          ),
          if (label != null) ...[
            const SizedBox(height: 4),
            Text(label!, style: Theme.of(context).textTheme.bodySmall),
          ],
        ],
      ),
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
}
