import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

/// The base class for a slide with a standard layout.
///
/// This class is used to create a slide with a standard layout. It is
/// responsible for placing the header, footer, and content of the slide in the
/// correct places. Also, it is responsible for displaying the background of the
/// slide.
///
/// If you want to create your own reusable layout, you can extend this class
/// and override the [header], [footer], [content], and [background] methods.
class FlutterDeckSlideBase extends StatelessWidget {
  /// Creates a new slide with a standard layout.
  ///
  /// The [configuration] argument must not be null. This configuration
  /// overrides the global configuration of the slide deck.
  const FlutterDeckSlideBase({
    this.background,
    this.content,
    this.footer,
    this.header,
    super.key,
  });

  ///
  final Widget? background;

  ///
  final Widget? content;

  ///
  final Widget? footer;

  ///
  final Widget? header;

  /// Creates the content of the slide.
  ///
  /// This method is called by the [slide] method. It is responsible for
  /// placing the content between the header and footer of the slide.
  // Widget? content(BuildContext context);

  /// Creates the header of the slide.
  ///
  /// This method is called by the [slide] method. It is responsible for
  /// placing the header at the top of the slide.
  // Widget? header(BuildContext context);

  /// Creates the footer of the slide.
  ///
  /// This method is called by the [slide] method. It is responsible for
  /// placing the footer at the bottom of the slide.
  // Widget? footer(BuildContext context);

  /// Creates the background of the slide.
  ///
  /// This method is called by the [slide] method. It is responsible for
  /// placing the background of the slide. By default, it uses the appropriate
  /// [FlutterDeckBackground] from the global configuration of the slide deck
  /// based on the current theme.
  // FlutterDeckBackground background(BuildContext context) {
  //   final background = context.flutterDeck.globalConfiguration.background;

  //   return Theme.of(context).brightness == Brightness.dark
  //       ? background.dark
  //       : background.light;
  // }

  @override
  Widget build(BuildContext context) {
    final globalConfiguration = context.flutterDeck.globalConfiguration;
    final backgroundConfiguration = globalConfiguration.background;
    final background = Theme.of(context).brightness == Brightness.dark
        ? backgroundConfiguration.dark
        : backgroundConfiguration.light;

    return Stack(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: this.background ?? background,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (header != null) header!,
            Expanded(child: content ?? const SizedBox.shrink()),
            if (footer != null) footer!,
          ],
        ),
      ],
    );
  }
}
