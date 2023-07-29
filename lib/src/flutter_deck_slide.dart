import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck_configuration.dart';
import 'package:flutter_deck/src/templates/templates.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';

/// The base class for a slide in a slide deck.
///
/// This class is used to create a slide in a slide deck. It is responsible for
/// wrapping the slide in a [Scaffold] and displaying the navigation drawer.
///
/// It is recommended to extend this class directly only if you want to create
/// a custom slide with its own layout. If the slide has a standard layout, a
/// better option is to extend the [FlutterDeckSlideBase] class.
///
/// See also:
///
/// * [FlutterDeckSlideBase], which represents a slide with a standard layout.
/// * [FlutterDeckBlankSlide], which represents a blank slide.
/// * [FlutterDeckImageSlide], which represents a slide with an image.
/// * [FlutterDeckSplitSlide], which represents a slide with two columns.
/// * [FlutterDeckTitleSlide], which represents a title slide.
/// * [FlutterDeckSlideConfiguration], which represents a configuration for a
/// single slide.
abstract class FlutterDeckSlide extends StatelessWidget {
  /// Creates a new slide.
  ///
  /// The [configuration] argument must not be null. This configuration
  /// overrides the global configuration of the slide deck.
  const FlutterDeckSlide({
    required this.configuration,
    super.key,
  });

  /// The configuration of the slide.
  final FlutterDeckSlideConfiguration configuration;

  /// An abstract method that must be implemented by subclasses.
  ///
  /// Usually, this method is implemented in the template.
  Widget slide(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const FlutterDeckDrawer(),
      body: _SlideBody(child: slide(context)),
    );
  }
}

class _SlideBody extends StatelessWidget {
  const _SlideBody({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scaffoldState = Scaffold.of(context);

    return FlutterDeckDrawerListener(
      onDrawerToggle: () {
        scaffoldState.isDrawerOpen
            ? scaffoldState.closeDrawer()
            : scaffoldState.openDrawer();
      },
      child: child,
    );
  }
}
