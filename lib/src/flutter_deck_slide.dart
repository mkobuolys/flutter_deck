import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_configuration.dart';
import 'package:flutter_deck/src/templates/templates.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';

///
abstract class FlutterDeckSlideWidget {
  ///
  const FlutterDeckSlideWidget({
    required this.configuration,
  });

  ///
  final FlutterDeckSlideConfiguration configuration;

  ///
  FlutterDeckSlide build(BuildContext context);
}

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
class FlutterDeckSlide extends StatelessWidget {
  /// Creates a new slide.
  ///
  /// The [configuration] argument must not be null. This configuration
  /// overrides the global configuration of the slide deck.
  const FlutterDeckSlide._({
    required Widget child,
    super.key,
  }) : _child = child;

  ///
  FlutterDeckSlide.blank({
    required Widget child,
    Key? key,
  }) : this._(
          child: FlutterDeckBlankSlide(child: child),
          key: key,
        );

  ///
  const FlutterDeckSlide.custom({
    required Widget child,
    Key? key,
  }) : this._(
          child: child,
          key: key,
        );

  ///
  FlutterDeckSlide.image({
    required Image image,
    String? label,
    Key? key,
  }) : this._(
          child: FlutterDeckImageSlide(image: image, label: label),
          key: key,
        );

  ///
  FlutterDeckSlide.split({
    required Widget left,
    required Widget right,
    Color? leftBackgroundColor,
    Color? rightBackgroundColor,
    SplitSlideRatio? splitRatio,
    Key? key,
  }) : this._(
          child: FlutterDeckSplitSlide(
            left: left,
            right: right,
            leftBackgroundColor: leftBackgroundColor,
            rightBackgroundColor: rightBackgroundColor,
            splitRatio: splitRatio,
          ),
          key: key,
        );

  ///
  FlutterDeckSlide.template({
    Widget? background,
    Widget? content,
    Widget? footer,
    Widget? header,
    Key? key,
  }) : this._(
          child: FlutterDeckSlideBase(
            background: background,
            content: content,
            footer: footer,
            header: header,
          ),
          key: key,
        );

  ///
  FlutterDeckSlide.title({
    required String title,
    String? subtitle,
    Key? key,
  }) : this._(
          child: FlutterDeckTitleSlide(title: title, subtitle: subtitle),
          key: key,
        );

  final Widget _child;

  /// An abstract method that must be implemented by subclasses.
  ///
  /// Usually, this method is implemented in the template.
  // Widget slide(BuildContext context) => const SizedBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const FlutterDeckDrawer(),
      body: _SlideBody(child: _child),
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
      child: context.flutterDeck.configuration.showProgress
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [child, const FlutterDeckProgressIndicator()],
            )
          : child,
    );
  }
}
