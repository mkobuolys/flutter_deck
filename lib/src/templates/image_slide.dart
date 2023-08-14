import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/templates/slide_base.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

///
typedef ImageBuilder = Image Function(BuildContext context);

/// The base class for a slide that only contains an image.
///
/// This class is used to create a slide that only contains an image. It is
/// responsible for rendering the default header and footer of the slide deck,
/// and placing the [image] in the correct place.
///
/// To use a custom background, you can override the [background] method.
class FlutterDeckImageSlide extends StatelessWidget {
  /// Creates a new image slide.
  ///
  /// The [configuration] argument must not be null. This configuration
  /// overrides the global configuration of the slide deck.
  const FlutterDeckImageSlide({
    required this.imageBuilder,
    this.label,
    this.backgroundBuilder,
    super.key,
  });

  /// The image to display in the slide.
  final ImageBuilder imageBuilder;

  /// The label to display below the image.
  ///
  /// If this is null, no label will be displayed.
  final String? label;

  ///
  final WidgetBuilder? backgroundBuilder;

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
        child: Column(
          children: [
            Expanded(
              child: Center(child: imageBuilder(context)),
            ),
            if (label != null) ...[
              const SizedBox(height: 4),
              Text(label!, style: Theme.of(context).textTheme.bodySmall),
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
