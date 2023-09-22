import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/templates/slide_base.dart';
import 'package:flutter_deck/src/theme/templates/flutter_deck_image_slide_theme.dart';
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
///
/// This template uses the [FlutterDeckImageSlideTheme] to style the slide.
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
    final theme = FlutterDeckImageSlideTheme.of(context);
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
              Text(label!, style: theme.labelTextStyle),
            ],
          ],
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
