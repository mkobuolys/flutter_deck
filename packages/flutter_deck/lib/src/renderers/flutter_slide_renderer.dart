import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/flutter_deck.dart';

/// An abstract class for a slide renderer.
///
/// This class can be extended to create a custom renderer for the slide deck.
abstract class FlutterSlideRenderer {
  /// Const constructor.
  const FlutterSlideRenderer();

  /// Renders the slide.
  ///
  /// The [context] argument is the build context.
  /// The [slide] argument is the slide to render.
  /// The [deck] argument is the [FlutterDeck] instance to use for rendering.
  Future<Uint8List> render(BuildContext context, Widget slide, FlutterDeck deck, {FlutterDeckConfiguration? configuration});
}
