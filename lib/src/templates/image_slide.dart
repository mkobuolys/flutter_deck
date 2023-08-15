import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/templates/slide_base.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

/// A signature for a function that builds an image for a slide.
typedef ImageBuilder = Image Function(BuildContext context);

/// A slide widget that represents a slide with an image.
///
/// This class is used to create a slide that only contains an image. It is
/// responsible for rendering the default header and footer of the slide deck,
/// and rendering the image using the provided [imageBuilder].
///
/// To use a custom background, you can pass the [backgroundBuilder].
class FlutterDeckImageSlide extends StatelessWidget {
  /// Creates a new image slide.
  ///
  /// The [imageBuilder] argument must not be null. The [label] and
  /// [backgroundBuilder] arguments are optional.
  const FlutterDeckImageSlide({
    required this.imageBuilder,
    this.label,
    this.backgroundBuilder,
    super.key,
  });

  /// Creates the image of the slide.
  final ImageBuilder imageBuilder;

  /// The label to display below the image.
  ///
  /// If this is null, no label will be displayed.
  final String? label;

  /// A builder for the background of the slide.
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
