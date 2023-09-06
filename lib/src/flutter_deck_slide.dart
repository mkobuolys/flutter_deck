import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_configuration.dart';
import 'package:flutter_deck/src/flutter_deck_speaker_info.dart';
import 'package:flutter_deck/src/templates/templates.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';

/// An abstract class that must be extended when creating a new slide for the
/// slide deck.
///
/// This class is used to create a new slide for the slide deck. It ensures that
/// each slide has a defined [FlutterDeckSlideConfiguration] and a [build]
/// method to create the slide. Diffently from the [StatelessWidget] class, the
/// [build] method returns a [FlutterDeckSlide] instead of a [Widget].
///
/// See also:
///
/// * [FlutterDeckSlide], which represents a slide in a slide deck.
/// * [FlutterDeckSlide.blank], which creates a blank slide.
/// * [FlutterDeckSlide.custom], which creates a custom slide.
/// * [FlutterDeckSlide.image], which creates a slide with an image.
/// * [FlutterDeckSlide.split], which creates a slide with two columns.
/// * [FlutterDeckSlide.template], which creates a slide with a standard layout.
/// * [FlutterDeckSlide.title], which creates a title slide.
///
/// Example:
///
/// ```dart
/// import 'package:flutter/widgets.dart';
/// import 'package:flutter_deck/flutter_deck.dart';
///
/// class ExampleSlide extends FlutterDeckSlideWidget {
///   const ExampleSlide()
///       : super(
///           configuration: const FlutterDeckSlideConfiguration(
///             route: '/example',
///             header: FlutterDeckHeaderConfiguration(title: 'Example'),
///           ),
///         );
///
///   @override
///   FlutterDeckSlide build(BuildContext context) {
///     return FlutterDeckSlide.blank(
///       builder: (context) => const Center(
///         child: Text('This is an example slide'),
///       ),
///     );
///   }
/// }
/// ```
abstract class FlutterDeckSlideWidget {
  /// Creates a new slide for the slide deck.
  ///
  /// This constructor must be called by the subclasses to create a new slide.
  /// The [configuration] argument must not be null.
  const FlutterDeckSlideWidget({
    required this.configuration,
  });

  /// The configuration of the slide.
  final FlutterDeckSlideConfiguration configuration;

  /// Creates the slide.
  FlutterDeckSlide build(BuildContext context);
}

/// The main widget for a slide in a slide deck.
///
/// This class is used to create a slide in a slide deck. It is responsible for
/// wrapping the slide in a [Scaffold] and displaying the navigation drawer.
///
/// To create a new slide, use one of the named constructors.
class FlutterDeckSlide extends StatelessWidget {
  /// Creates a new slide.
  ///
  /// This constructor is private and should not be used directly. Instead, use
  /// one of the named constructors to create a new slide.
  const FlutterDeckSlide._({
    required WidgetBuilder builder,
    required FlutterDeckThemeData? theme,
    super.key,
  })  : _builder = builder,
        _theme = theme;

  /// Creates a new blank slide.
  ///
  /// This constructor creates a blank slide in a slide deck with the default
  /// header and footer, and the content in-between.
  ///
  /// The [builder] argument must not be null. The [backgroundBuilder] argument
  /// is optional.
  FlutterDeckSlide.blank({
    required WidgetBuilder builder,
    WidgetBuilder? backgroundBuilder,
    FlutterDeckThemeData? theme,
    Key? key,
  }) : this._(
          builder: (context) => FlutterDeckBlankSlide(
            builder: builder,
            backgroundBuilder: backgroundBuilder,
          ),
          theme: theme,
          key: key,
        );

  /// Creates a new custom slide.
  ///
  /// This constructor creates a custom slide in a slide deck. This constructor
  /// does not provide any default layout for the slide. It is up to the user to
  /// define it.
  ///
  /// The [builder] argument must not be null.
  const FlutterDeckSlide.custom({
    required WidgetBuilder builder,
    FlutterDeckThemeData? theme,
    Key? key,
  }) : this._(
          builder: builder,
          theme: theme,
          key: key,
        );

  /// Creates a new image slide.
  ///
  /// This constructor creates a slide in a slide deck with the default header
  /// and footer, and the image in-between.The image can be a local asset or a
  /// network image.
  ///
  /// The [imageBuilder] argument must not be null. The [label] and
  /// [backgroundBuilder] arguments are optional.
  FlutterDeckSlide.image({
    required ImageBuilder imageBuilder,
    String? label,
    WidgetBuilder? backgroundBuilder,
    FlutterDeckThemeData? theme,
    Key? key,
  }) : this._(
          builder: (context) => FlutterDeckImageSlide(
            imageBuilder: imageBuilder,
            label: label,
            backgroundBuilder: backgroundBuilder,
          ),
          theme: theme,
          key: key,
        );

  /// Creates a new slide with two columns.
  ///
  /// This constructor creates a slide with two columns in a slide deck. It is
  /// responsible for rendering the default header and footer of the slide deck,
  /// and use the [leftBuilder] and [rightBuilder] to create the content of the
  /// left and right columns.
  ///
  /// The [leftBuilder] and [rightBuilder] arguments must not be null. The
  /// [backgroundBuilder] and [splitRatio] arguments are optional.
  ///
  /// If [splitRatio] is not specified, the left and right columns will have the
  /// same width.
  FlutterDeckSlide.split({
    required WidgetBuilder leftBuilder,
    required WidgetBuilder rightBuilder,
    WidgetBuilder? backgroundBuilder,
    SplitSlideRatio? splitRatio,
    FlutterDeckThemeData? theme,
    Key? key,
  }) : this._(
          builder: (context) => FlutterDeckSplitSlide(
            leftBuilder: leftBuilder,
            rightBuilder: rightBuilder,
            backgroundBuilder: backgroundBuilder,
            splitRatio: splitRatio,
          ),
          theme: theme,
          key: key,
        );

  /// Creates a new slide with a standard layout.
  ///
  /// This constructor creates a slide with a standard layout in a slide deck.
  ///
  /// The [backgroundBuilder], [contentBuilder], [footerBuilder], and
  /// [headerBuilder] arguments are optional.
  FlutterDeckSlide.template({
    WidgetBuilder? backgroundBuilder,
    WidgetBuilder? contentBuilder,
    WidgetBuilder? footerBuilder,
    WidgetBuilder? headerBuilder,
    FlutterDeckThemeData? theme,
    Key? key,
  }) : this._(
          builder: (context) => FlutterDeckSlideBase(
            backgroundBuilder: backgroundBuilder,
            contentBuilder: contentBuilder,
            footerBuilder: footerBuilder,
            headerBuilder: headerBuilder,
          ),
          theme: theme,
          key: key,
        );

  /// Creates a new title slide.
  ///
  /// This constructor creates a title slide in a slide deck with the default
  /// header and footer, and the content in-between. The content is composed of
  /// the [title] and [subtitle]. Also, if the [FlutterDeckSpeakerInfo] is set,
  /// it will render the speaker info below the title and subtitle.
  ///
  /// The [title] argument must not be null. The [subtitle] and
  /// [backgroundBuilder] arguments are optional.
  FlutterDeckSlide.title({
    required String title,
    String? subtitle,
    WidgetBuilder? backgroundBuilder,
    FlutterDeckThemeData? theme,
    Key? key,
  }) : this._(
          builder: (context) => FlutterDeckTitleSlide(
            title: title,
            subtitle: subtitle,
            backgroundBuilder: backgroundBuilder,
          ),
          theme: theme,
          key: key,
        );

  final WidgetBuilder _builder;

  final FlutterDeckThemeData? _theme;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckTheme.of(context).merge(_theme);
    final slideTheme = theme.slideTheme;
    final textTheme = theme.textTheme;

    return FlutterDeckTheme(
      data: theme.copyWith(textTheme: textTheme.apply(color: slideTheme.color)),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: slideTheme.backgroundColor,
          drawer: const FlutterDeckDrawer(),
          body: _SlideBody(child: _builder(context)),
        ),
      ),
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
