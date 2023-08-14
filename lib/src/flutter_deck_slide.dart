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
    required WidgetBuilder builder,
    super.key,
  }) : _builder = builder;

  ///
  FlutterDeckSlide.blank({
    required WidgetBuilder builder,
    WidgetBuilder? backgroundBuilder,
    Key? key,
  }) : this._(
          builder: (context) => FlutterDeckBlankSlide(
            builder: builder,
            backgroundBuilder: backgroundBuilder,
          ),
          key: key,
        );

  ///
  const FlutterDeckSlide.custom({
    required WidgetBuilder builder,
    Key? key,
  }) : this._(
          builder: builder,
          key: key,
        );

  ///
  FlutterDeckSlide.image({
    required Image image,
    String? label,
    WidgetBuilder? backgroundBuilder,
    Key? key,
  }) : this._(
          builder: (context) => FlutterDeckImageSlide(
            image: image,
            label: label,
            backgroundBuilder: backgroundBuilder,
          ),
          key: key,
        );

  ///
  FlutterDeckSlide.split({
    required WidgetBuilder leftBuilder,
    required WidgetBuilder rightBuilder,
    Color? leftBackgroundColor,
    Color? rightBackgroundColor,
    SplitSlideRatio? splitRatio,
    Key? key,
  }) : this._(
          builder: (context) => FlutterDeckSplitSlide(
            leftBuilder: leftBuilder,
            rightBuilder: rightBuilder,
            leftBackgroundColor: leftBackgroundColor,
            rightBackgroundColor: rightBackgroundColor,
            splitRatio: splitRatio,
          ),
          key: key,
        );

  ///
  FlutterDeckSlide.template({
    WidgetBuilder? backgroundBuilder,
    WidgetBuilder? contentBuilder,
    WidgetBuilder? footerBuilder,
    WidgetBuilder? headerBuilder,
    Key? key,
  }) : this._(
          builder: (context) => FlutterDeckSlideBase(
            backgroundBuilder: backgroundBuilder,
            contentBuilder: contentBuilder,
            footerBuilder: footerBuilder,
            headerBuilder: headerBuilder,
          ),
          key: key,
        );

  ///
  FlutterDeckSlide.title({
    required String title,
    String? subtitle,
    WidgetBuilder? backgroundBuilder,
    Key? key,
  }) : this._(
          builder: (context) => FlutterDeckTitleSlide(
            title: title,
            subtitle: subtitle,
            backgroundBuilder: backgroundBuilder,
          ),
          key: key,
        );

  final WidgetBuilder _builder;

  /// An abstract method that must be implemented by subclasses.
  ///
  /// Usually, this method is implemented in the template.
  // Widget slide(BuildContext context) => const SizedBox();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const FlutterDeckDrawer(),
      body: _SlideBody(child: _builder(context)),
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
