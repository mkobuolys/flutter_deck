import 'package:flutter/services.dart';
import 'package:flutter_deck/src/flutter_deck_slide.dart';
import 'package:flutter_deck/src/templates/templates.dart';
import 'package:flutter_deck/src/theme/templates/flutter_deck_slide_theme.dart';
import 'package:flutter_deck/src/transitions/transitions.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

/// The global configuration for the slide deck.
///
/// This class is used to configure the slide deck. It is passed to the slide
/// deck and later overridden by the configuration for each slide.
class FlutterDeckConfiguration {
  /// Creates a global configuration for the slide deck.
  const FlutterDeckConfiguration({
    this.background = const FlutterDeckBackgroundConfiguration(),
    this.controls = const FlutterDeckControlsConfiguration(),
    this.footer = const FlutterDeckFooterConfiguration(showFooter: false),
    this.header = const FlutterDeckHeaderConfiguration(showHeader: false),
    this.transition = const FlutterDeckTransition.none(),
    this.showProgress = true,
  });

  /// The background configuration for the slide deck. By default, the
  /// background is transparent and [FlutterDeckSlideThemeData.backgroundColor]
  /// is used.
  ///
  /// This configuration is used by all the templates that use the
  /// [FlutterDeckSlideBase] class and do not pass the background builder
  /// explicitly. This also means that the configuration cannot be overridden
  /// via the slide configuration, but rather by passing a background builder
  /// for the [FlutterDeckSlide].
  final FlutterDeckBackgroundConfiguration background;

  /// Configures the controls for the slide deck. By default, controls are
  /// enabled. The default keyboard controls are:
  /// - Next slide: ArrowRight
  /// - Previous slide: ArrowLeft
  /// - Open drawer: Period
  ///
  /// This configuration cannot be overridden by the slide configuration.
  final FlutterDeckControlsConfiguration controls;

  /// Footer component configuration for the slide deck. By default, the footer
  /// is not shown.
  final FlutterDeckFooterConfiguration footer;

  /// Header component configuration for the slide deck. By default, the header
  /// is not shown.
  final FlutterDeckHeaderConfiguration header;

  /// The transition to use when navigating between slides.
  ///
  /// The default transition is [FlutterDeckTransition.none].
  final FlutterDeckTransition transition;

  /// Whether to show the presentation progress or not.
  ///
  /// The default is true.
  final bool showProgress;
}

/// The configuration for a slide.
///
/// This class is used to configure a slide. It is passed to the slide and later
/// overrides the global slide deck configuration.
class FlutterDeckSlideConfiguration extends FlutterDeckConfiguration {
  /// Creates a configuration for a slide.
  ///
  /// [route] must not be null.
  ///
  /// [hidden] defines whether the slide is hidden or not. Hidden slides are not
  /// included in the slide deck and cannot be navigated to. The default is
  /// false.
  ///
  /// [steps] is the number of steps in the slide. The default is 1.
  ///
  /// [footer], [header], [showProgress], and [transition] are optional
  /// overrides for the global configuration.
  const FlutterDeckSlideConfiguration({
    required this.route,
    this.hidden = false,
    this.steps = 1,
    FlutterDeckFooterConfiguration? footer,
    FlutterDeckHeaderConfiguration? header,
    bool? showProgress,
    FlutterDeckTransition? transition,
  })  : _footerConfigurationOverride = footer,
        _headerConfigurationOverride = header,
        _showProgressOverride = showProgress,
        _transitionOverride = transition;

  /// Creates a configuration for a slide. This constructor is used internally
  /// to create a configuration when the global configuration is overridden.
  const FlutterDeckSlideConfiguration._({
    required this.route,
    this.hidden = false,
    this.steps = 1,
    super.footer,
    super.header,
    super.showProgress,
    super.transition,
  })  : _footerConfigurationOverride = null,
        _headerConfigurationOverride = null,
        _showProgressOverride = null,
        _transitionOverride = null;

  /// The route for the slide.
  final String route;

  /// Whether the slide is hidden or not.
  ///
  /// Hidden slides are not included in the slide deck and cannot be navigated
  /// to.
  ///
  /// The default is false.
  final bool hidden;

  /// The number of steps in the slide.
  final int steps;

  final FlutterDeckFooterConfiguration? _footerConfigurationOverride;
  final FlutterDeckHeaderConfiguration? _headerConfigurationOverride;
  final bool? _showProgressOverride;
  final FlutterDeckTransition? _transitionOverride;

  /// Merges the slide configuration with the global configuration. The slide
  /// configuration values take precedence.
  FlutterDeckSlideConfiguration mergeWithGlobal(
    FlutterDeckConfiguration configuration,
  ) {
    return FlutterDeckSlideConfiguration._(
      route: route,
      hidden: hidden,
      steps: steps,
      footer: _footerConfigurationOverride ?? configuration.footer,
      header: _headerConfigurationOverride ?? configuration.header,
      showProgress: _showProgressOverride ?? configuration.showProgress,
      transition: _transitionOverride ?? configuration.transition,
    );
  }
}

/// The configuration for the slide deck background.
class FlutterDeckBackgroundConfiguration {
  /// Creates a configuration for the slide deck background. By default, the
  /// background is transparent and the
  /// [FlutterDeckSlideThemeData.backgroundColor] is used.
  ///
  /// The [light] and [dark] configurations are used when the current theme is
  /// light or dark, respectively.
  const FlutterDeckBackgroundConfiguration({
    this.light = const FlutterDeckBackground.transparent(),
    this.dark = const FlutterDeckBackground.transparent(),
  });

  /// The background to use when the current theme is light.
  final FlutterDeckBackground light;

  /// The background to use when the current theme is dark.
  final FlutterDeckBackground dark;
}

/// The configuration for the slide deck controls.
class FlutterDeckControlsConfiguration {
  /// Creates a configuration for the slide deck controls. By default, controls
  /// are enabled. The default keyboard controls are:
  /// - Next slide: ArrowRight
  /// - Previous slide: ArrowLeft
  /// - Open drawer: Period
  const FlutterDeckControlsConfiguration({
    this.enabled = true,
    this.nextKey = LogicalKeyboardKey.arrowRight,
    this.previousKey = LogicalKeyboardKey.arrowLeft,
    this.openDrawerKey = LogicalKeyboardKey.period,
  });

  /// Whether controls are enabled or not.
  final bool enabled;

  /// The key to use for going to the next slide.
  final LogicalKeyboardKey nextKey;

  /// The key to use for going to the previous slide.
  final LogicalKeyboardKey previousKey;

  /// The key to use for opening the navigation drawer.
  final LogicalKeyboardKey openDrawerKey;
}

/// The configuration for the slide deck footer.
///
/// The footer is the component at the bottom of the slide deck that shows the
/// slide number and social handle.
class FlutterDeckFooterConfiguration {
  /// Creates a configuration for the slide deck footer. By default, the footer
  /// is shown. By default, the slide number and social handle are not shown.
  const FlutterDeckFooterConfiguration({
    this.showFooter = true,
    this.showSlideNumbers = false,
    this.showSocialHandle = false,
  });

  /// Whether to show the footer or not.
  final bool showFooter;

  /// Whether to show the slide number or not.
  final bool showSlideNumbers;

  /// Whether to show the social handle or not.
  final bool showSocialHandle;
}

/// The configuration for the slide deck header.
///
/// The header is the component at the top of the slide deck that shows the
/// slide title.
class FlutterDeckHeaderConfiguration {
  /// Creates a configuration for the slide deck header. By default, the header
  /// is shown. The title must not be empty.
  const FlutterDeckHeaderConfiguration({
    this.showHeader = true,
    this.title = '',
  }) : assert(
          !showHeader || title != '',
          'If showHeader is true, title must not be empty.',
        );

  /// Whether to show the header or not.
  final bool showHeader;

  /// The title to show in the header.
  final String title;
}
