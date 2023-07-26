import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck_slide.dart';

/// The base class for a slide with a standard layout.
///
/// This class is used to create a slide with a standard layout. It is
/// responsible for placing the header, footer, and content of the slide in the
/// correct places. Also, it is responsible for displaying the background of the
/// slide.
///
/// If you want to create your own reusable layout, you can extend this class
/// and override the [header], [footer], [content], and [background] methods.
abstract class FlutterDeckSlideBase extends FlutterDeckSlide {
  /// Creates a new slide with a standard layout.
  ///
  /// The [configuration] argument must not be null. This configuration
  /// overrides the global configuration of the slide deck.
  const FlutterDeckSlideBase({
    required super.configuration,
    super.key,
  });

  /// Creates the content of the slide.
  ///
  /// This method is called by the [slide] method. It is responsible for
  /// placing the content between the header and footer of the slide.
  Widget? content(BuildContext context);

  /// Creates the header of the slide.
  ///
  /// This method is called by the [slide] method. It is responsible for
  /// placing the header at the top of the slide.
  Widget? header(BuildContext context);

  /// Creates the footer of the slide.
  ///
  /// This method is called by the [slide] method. It is responsible for
  /// placing the footer at the bottom of the slide.
  Widget? footer(BuildContext context);

  /// Creates the background of the slide.
  ///
  /// This method is called by the [slide] method. It is responsible for
  /// placing the background of the slide. If no background is provided, the
  /// slide will have a background of [Scaffold.backgroundColor].
  Widget? background(BuildContext context);

  @override
  Widget slide(BuildContext context) {
    final contentWidget = content(context);
    final headerWidget = header(context);
    final footerWidget = footer(context);

    Widget widget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerWidget != null) headerWidget,
        Expanded(child: contentWidget ?? const SizedBox.shrink()),
        if (footerWidget != null) footerWidget,
      ],
    );

    final backgroundWidget = background(context);

    if (backgroundWidget != null) {
      widget = Stack(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: backgroundWidget,
          ),
          widget,
        ],
      );
    }

    return widget;
  }
}
