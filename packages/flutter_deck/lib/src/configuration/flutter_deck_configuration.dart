import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/configuration/flutter_deck_slide_size.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck_slide.dart';
import 'package:flutter_deck/src/templates/templates.dart';
import 'package:flutter_deck/src/theme/templates/flutter_deck_slide_theme.dart';
import 'package:flutter_deck/src/transitions/transitions.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

export 'package:flutter_deck/src/controls/flutter_deck_controls_configuration.dart';

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
    this.marker = const FlutterDeckMarkerConfiguration(),
    this.progressIndicator = const FlutterDeckProgressIndicator.solid(),
    this.showProgress = true,
    this.slideSize = const FlutterDeckSlideSize.responsive(),
    this.transition = const FlutterDeckTransition.none(),
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

  /// Configures the controls for the slide deck. By default, the presenter
  /// toolbar is visible, the default keyboard controls are enabled, and
  /// gestures are enabled on mobile platforms only.
  ///
  /// The default keyboard shortcuts are:
  /// - Next slide: \[ArrowRight\]
  /// - Previous slide: \[ArrowLeft\]
  /// - Toggle marker: \[KeyM\]
  /// - Toggle navigation drawer: \[Period\]
  ///
  /// This configuration cannot be overridden by the slide configuration.
  final FlutterDeckControlsConfiguration controls;

  /// Footer component configuration for the slide deck. By default, the footer
  /// is not shown.
  final FlutterDeckFooterConfiguration footer;

  /// Header component configuration for the slide deck. By default, the header
  /// is not shown.
  final FlutterDeckHeaderConfiguration header;

  /// The marker configuration for the slide deck.
  final FlutterDeckMarkerConfiguration marker;

  /// The progress indicator to show in the slide deck.
  ///
  /// The default is [FlutterDeckProgressIndicator.solid] with a primary color
  /// from the theme.
  final FlutterDeckProgressIndicator progressIndicator;

  /// Whether to show the presentation progress or not.
  ///
  /// The default is true.
  final bool showProgress;

  /// The size of the slides in the slide deck.
  ///
  /// By default, the size is [FlutterDeckSlideSize.responsive], which means the
  /// size is not constrained and will be responsive to the size of the screen.
  ///
  /// This configuration cannot be overridden by the slide configuration.
  final FlutterDeckSlideSize slideSize;

  /// The transition to use when navigating between slides.
  ///
  /// The default transition is [FlutterDeckTransition.none].
  final FlutterDeckTransition transition;
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
  /// [initial] defines whether the slide is the initial slide or not. The
  /// default is false.
  ///
  /// [speakerNotes] are the speaker notes for the slide. The default is an
  /// empty string.
  ///
  /// [steps] is the number of steps in the slide. The default is 1.
  ///
  /// [title] is the title of the slide. If the title is set, it will be used in
  /// the navigation drawer instead of the header title (or route as a
  /// fallback).
  ///
  /// [footer], [header], [progressIndicator], [showProgress], and [transition]
  /// are optional overrides for the global configuration.
  const FlutterDeckSlideConfiguration({
    required this.route,
    this.hidden = false,
    this.initial = false,
    this.speakerNotes = '',
    this.steps = 1,
    this.title,
    FlutterDeckFooterConfiguration? footer,
    FlutterDeckHeaderConfiguration? header,
    FlutterDeckProgressIndicator? progressIndicator,
    bool? showProgress,
    FlutterDeckTransition? transition,
  })  : _footerConfigurationOverride = footer,
        _headerConfigurationOverride = header,
        _progressIndicatorOverride = progressIndicator,
        _showProgressOverride = showProgress,
        _transitionOverride = transition;

  /// Creates a configuration for a slide. This constructor is used internally
  /// to create a configuration when the global configuration is overridden.
  const FlutterDeckSlideConfiguration._({
    required this.route,
    this.hidden = false,
    this.initial = false,
    this.speakerNotes = '',
    this.steps = 1,
    this.title,
    super.footer,
    super.header,
    super.progressIndicator,
    super.showProgress,
    super.transition,
  })  : _footerConfigurationOverride = null,
        _headerConfigurationOverride = null,
        _progressIndicatorOverride = null,
        _showProgressOverride = null,
        _transitionOverride = null;

  /// The route for the slide.
  final String route;

  /// The title of the slide.
  ///
  /// If the title is set, it will be used in the navigation drawer instead of
  /// the header title (or route as a fallback).
  final String? title;

  /// The speaker notes for the slide.
  ///
  /// Speaker notes are not shown in the slide deck and are only visible in the
  /// presenter view.
  ///
  /// The default is an empty string.
  final String speakerNotes;

  /// Whether the slide is hidden or not.
  ///
  /// Hidden slides are not included in the slide deck and cannot be navigated
  /// to.
  ///
  /// The default is false.
  final bool hidden;

  /// Whether the slide is the initial slide or not.
  ///
  /// On Web, this property is only used when the path is not set. If the path
  /// is set, it will determine the initial slide.
  ///
  /// The default is false.
  final bool initial;

  /// The number of steps in the slide.
  final int steps;

  final FlutterDeckFooterConfiguration? _footerConfigurationOverride;
  final FlutterDeckHeaderConfiguration? _headerConfigurationOverride;
  final FlutterDeckProgressIndicator? _progressIndicatorOverride;
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
      initial: initial,
      speakerNotes: speakerNotes,
      steps: steps,
      title: title,
      footer: _footerConfigurationOverride ?? configuration.footer,
      header: _headerConfigurationOverride ?? configuration.header,
      progressIndicator:
          _progressIndicatorOverride ?? configuration.progressIndicator,
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

/// The configuration for the slide deck footer.
///
/// The footer is the component at the bottom of the slide deck that shows the
/// slide number and social handle and an optional custom widget.
class FlutterDeckFooterConfiguration {
  /// Creates a configuration for the slide deck footer. By default, the footer
  /// is shown. By default, the slide number, social handle and custom widget
  /// are not shown.
  const FlutterDeckFooterConfiguration({
    this.showFooter = true,
    this.showSlideNumbers = false,
    this.showSocialHandle = false,
    this.widget,
  });

  /// Whether to show the footer or not.
  final bool showFooter;

  /// Whether to show the slide number or not.
  final bool showSlideNumbers;

  /// Whether to show the social handle or not. If [widget] is provided, this is
  /// never shown.
  final bool showSocialHandle;

  /// A custom widget to show in the footer (instead of the social handle).
  final Widget? widget;
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

/// The configuration for the slide deck marker.
class FlutterDeckMarkerConfiguration {
  /// Creates a configuration for the slide deck marker. By default, the marker
  /// is red with a stroke width of 5px.
  const FlutterDeckMarkerConfiguration({
    this.color = const Color(0xFFFF5252),
    this.strokeWidth = 5.0,
  });

  /// The color of the marker.
  final Color color;

  /// The stroke width of the marker.
  final double strokeWidth;
}
