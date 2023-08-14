import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

/// A base widget for a slide with a standard layout.
///
/// This class is used to create a slide with a standard layout. It is
/// responsible for placing the header, footer, and content of the slide in the
/// correct places. Also, it is responsible for displaying the background of the
/// slide.
///
/// If you want to create your own reusable layout, use this class and pass in
/// the appropriate builders: [backgroundBuilder], [contentBuilder],
/// [headerBuilder], and [footerBuilder].
class FlutterDeckSlideBase extends StatelessWidget {
  /// Creates a new slide with a standard layout.
  ///
  /// [backgroundBuilder], [contentBuilder], [headerBuilder], and
  /// [footerBuilder] are optional.
  const FlutterDeckSlideBase({
    this.backgroundBuilder,
    this.contentBuilder,
    this.footerBuilder,
    this.headerBuilder,
    super.key,
  });

  /// A builder for the background of the slide. It is responsible for placing
  /// the background of the slide. If not provided, an appropriate
  /// [FlutterDeckBackground] from the global configuration of the slide deck is
  /// used based on the current theme.
  final WidgetBuilder? backgroundBuilder;

  /// A builder for the content of the slide. It is responsible for placing the
  /// content between the header and footer of the slide.
  final WidgetBuilder? contentBuilder;

  /// A builder for the footer of the slide. It is responsible for placing the
  /// footer at the bottom of the slide.
  final WidgetBuilder? footerBuilder;

  /// A builder for the header of the slide.  It is responsible for placing the
  /// header at the top of the slide.
  final WidgetBuilder? headerBuilder;

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
          child: backgroundBuilder?.call(context) ?? background,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (headerBuilder != null) headerBuilder!(context),
            Expanded(
              child: contentBuilder?.call(context) ?? const SizedBox.shrink(),
            ),
            if (footerBuilder != null) footerBuilder!(context),
          ],
        ),
      ],
    );
  }
}
