import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/flutter_deck_slide.dart';
import 'package:flutter_deck/src/flutter_deck_speaker_info.dart';
import 'package:flutter_deck/src/presenter/presenter.dart';
import 'package:flutter_deck/src/renderers/flutter_slide_renderer.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme_notifier.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';

/// The main class used to interact with the slide deck.
///
/// The [FlutterDeck] is used to:
/// * Navigate between slides and steps;
/// * Access the current slide and step number;
/// * Access the current slide configuration;
/// * Access the global deck configuration;
/// * Access the speaker info;
/// * Control the slide deck's drawer;
/// * Control the slide deck's theme.
///
/// The [FlutterDeck] is available in the widget tree and can be accessed using
/// the [FlutterDeck.of] method or the `flutterDeck` extension on
/// [BuildContext].
///
/// See also:
/// * [FlutterDeckConfiguration], which is used to configure the slide deck.
/// * [FlutterDeckRouter], which is used to navigate between slides and steps.
/// * [FlutterDeckSpeakerInfo], which is used to access the speaker info.
/// * [FlutterDeckControlsNotifier], which is used to control the slide deck.
/// * [FlutterDeckDrawerNotifier], which is used to control the slide deck's
/// drawer.
/// * [FlutterDeckLocalizationNotifier], which is used to control the slide
/// deck's localization.
/// * [FlutterDeckMarkerNotifier], which is used to control the slide deck's
/// marker.
/// * [FlutterDeckThemeNotifier], which is used to control the slide deck's
/// theme.
class FlutterDeck extends InheritedWidget {
  /// Default constructor for [FlutterDeck].
  ///
  /// The [configuration] is required and is used to configure the slide deck.
  ///
  /// The [router] is required and is used to navigate between slides.
  ///
  /// The [speakerInfo] is optional and is used to access the speaker info.
  ///
  /// The [autoplayNotifier] is required and is used to control the slide deck's
  /// autoplay feature.
  ///
  /// The [controlsNotifier] is required and is used to control the slide deck.
  ///
  /// The [drawerNotifier] is required and is used to control the slide deck's
  /// drawer.
  ///
  /// The [localizationNotifier] is required and is used to control the slide
  /// deck's localization.
  ///
  /// The [markerNotifier] is required and is used to control the slide deck's
  /// marker.
  ///
  /// The [themeNotifier] is required and is used to control the slide deck's
  /// theme.
  ///
  /// The [slideRenderer] is required and is used to render the slides.
  const FlutterDeck({
    required FlutterDeckConfiguration configuration,
    required FlutterDeckRouter router,
    required FlutterDeckSpeakerInfo? speakerInfo,
    required FlutterDeckAutoplayNotifier autoplayNotifier,
    required FlutterDeckControlsNotifier controlsNotifier,
    required FlutterDeckDrawerNotifier drawerNotifier,
    required FlutterDeckLocalizationNotifier localizationNotifier,
    required FlutterDeckMarkerNotifier markerNotifier,
    required FlutterDeckPresenterController presenterController,
    required FlutterDeckThemeNotifier themeNotifier,
    required FlutterSlideRenderer slideRenderer,
    int? stepNumber,
    required super.child,
    super.key,
  }) : _configuration = configuration,
       _router = router,
       _speakerInfo = speakerInfo,
       _autoplayNotifier = autoplayNotifier,
       _controlsNotifier = controlsNotifier,
       _drawerNotifier = drawerNotifier,
       _localizationNotifier = localizationNotifier,
       _markerNotifier = markerNotifier,
       _presenterController = presenterController,
       _themeNotifier = themeNotifier,
       _slideRenderer = slideRenderer,
       _stepNumber = stepNumber;

  final FlutterDeckConfiguration _configuration;
  final FlutterDeckRouter _router;
  final FlutterDeckSpeakerInfo? _speakerInfo;
  final FlutterDeckAutoplayNotifier _autoplayNotifier;
  final FlutterDeckControlsNotifier _controlsNotifier;
  final FlutterDeckDrawerNotifier _drawerNotifier;
  final FlutterDeckLocalizationNotifier _localizationNotifier;
  final FlutterDeckMarkerNotifier _markerNotifier;
  final FlutterDeckPresenterController _presenterController;
  final FlutterDeckThemeNotifier _themeNotifier;
  final FlutterSlideRenderer _slideRenderer;
  final int? _stepNumber;

  /// Returns the [FlutterDeckRouter] for the slide deck.
  FlutterDeckRouter get router => _router;

  /// Go to the next slide or step in the deck.
  ///
  /// If the current step is the last step, the next slide is displayed.
  /// If the current slide is the last slide, nothing happens.
  void next() => _router.next();

  /// Go to the previous slide in the deck.
  ///
  /// If the current step is the first step, the previous slide is displayed.
  /// If the current slide is the first slide, nothing happens.
  void previous() => _router.previous();

  /// Go to a specific slide by its number.
  ///
  /// If the slide number is invalid, nothing happens.
  void goToSlide(int slideNumber) => _router.goToSlide(slideNumber);

  /// Go to a specific step by its number.
  ///
  /// If the step number is invalid, nothing happens.
  void goToStep(int stepNumber) => _router.goToStep(stepNumber);

  /// Returns the current slide number.
  int get slideNumber => _router.currentSlideIndex + 1;

  /// Returns the current step number.
  int get stepNumber => _stepNumber ?? _router.currentStep;

  /// Returns the speaker info.
  FlutterDeckSpeakerInfo? get speakerInfo => _speakerInfo;

  /// Returns the configuration for the current slide.
  FlutterDeckSlideConfiguration get configuration {
    if (_configuration is FlutterDeckSlideConfiguration) {
      return _configuration;
    }

    return _router.currentSlideConfiguration;
  }

  /// Returns the global configuration for the slide deck.
  FlutterDeckConfiguration get globalConfiguration => _configuration;

  /// Returns the [FlutterDeckAutoplayNotifier] for the slide deck.
  FlutterDeckAutoplayNotifier get autoplayNotifier => _autoplayNotifier;

  /// Returns the [FlutterDeckControlsNotifier] for the slide deck.
  FlutterDeckControlsNotifier get controlsNotifier => _controlsNotifier;

  /// Returns the [FlutterDeckDrawerNotifier] for the slide deck.
  FlutterDeckDrawerNotifier get drawerNotifier => _drawerNotifier;

  /// Returns the [FlutterDeckLocalizationNotifier] for the slide deck.
  FlutterDeckLocalizationNotifier get localizationNotifier => _localizationNotifier;

  /// Returns the [FlutterDeckMarkerNotifier] for the slide deck.
  FlutterDeckMarkerNotifier get markerNotifier => _markerNotifier;

  /// Returns the [FlutterDeckPresenterController] for the slide deck.
  FlutterDeckPresenterController get presenterController => _presenterController;

  /// Returns the [FlutterDeckThemeNotifier] for the slide deck.
  FlutterDeckThemeNotifier get themeNotifier => _themeNotifier;

  /// Find the current [FlutterDeck] in the widget tree.
  ///
  /// See [BuildContext.dependOnInheritedWidgetOfExactType].
  static FlutterDeck of(BuildContext context) {
    final flutterDeck = context.dependOnInheritedWidgetOfExactType<FlutterDeck>();

    assert(flutterDeck != null, 'No FlutterDeck found in context');

    return flutterDeck!;
  }

  /// Creates a copy of this [FlutterDeck] but with the given fields replaced with
  /// the new values.
  FlutterDeck copyWith({
    FlutterDeckConfiguration? configuration,
    FlutterDeckRouter? router,
    FlutterDeckSpeakerInfo? speakerInfo,
    FlutterDeckAutoplayNotifier? autoplayNotifier,
    FlutterDeckControlsNotifier? controlsNotifier,
    FlutterDeckDrawerNotifier? drawerNotifier,
    FlutterDeckLocalizationNotifier? localizationNotifier,
    FlutterDeckMarkerNotifier? markerNotifier,
    FlutterDeckPresenterController? presenterController,
    FlutterDeckThemeNotifier? themeNotifier,
    FlutterSlideRenderer? slideRenderer,
    int? stepNumber,
    Widget? child,
  }) {
    return FlutterDeck(
      configuration: configuration ?? _configuration,
      router: router ?? _router,
      speakerInfo: speakerInfo ?? _speakerInfo,
      autoplayNotifier: autoplayNotifier ?? _autoplayNotifier,
      controlsNotifier: controlsNotifier ?? _controlsNotifier,
      drawerNotifier: drawerNotifier ?? _drawerNotifier,
      localizationNotifier: localizationNotifier ?? _localizationNotifier,
      markerNotifier: markerNotifier ?? _markerNotifier,
      presenterController: presenterController ?? _presenterController,
      themeNotifier: themeNotifier ?? _themeNotifier,
      slideRenderer: slideRenderer ?? _slideRenderer,
      stepNumber: stepNumber ?? _stepNumber,
      child: child ?? super.child,
    );
  }

  /// Exports a specific [slide] using the provided [configuration].
  ///
  /// The [configuration] is optional and is used to override the default
  /// configuration.
  ///
  /// The [stepNumber] is optional and is used to override the current step.
  Future<Uint8List> exportSlide(
    BuildContext context,
    Widget slide, {
    FlutterDeckConfiguration? configuration,
    int? stepNumber,
  }) {
    var slideConfig = configuration ?? globalConfiguration;

    if (slide is FlutterDeckSlideWidget && slide.configuration != null) {
      slideConfig = slide.configuration!.mergeWithGlobal(slideConfig);
    } else if (slide is FlutterDeckSlide && slide.configuration != null) {
      slideConfig = slide.configuration!.mergeWithGlobal(slideConfig);
    }

    return _slideRenderer.render(context, slide, copyWith(configuration: slideConfig, stepNumber: stepNumber ?? 1));
  }

  @override
  bool updateShouldNotify(FlutterDeck oldWidget) =>
      _configuration != oldWidget._configuration ||
      _router != oldWidget._router ||
      _speakerInfo != oldWidget._speakerInfo ||
      _controlsNotifier != oldWidget._controlsNotifier ||
      _drawerNotifier != oldWidget._drawerNotifier ||
      _markerNotifier != oldWidget._markerNotifier ||
      _themeNotifier != oldWidget._themeNotifier;
}

/// An extension on [BuildContext] that simplifies accessing the [FlutterDeck]
/// from the widget tree.
extension FlutterDeckX on BuildContext {
  /// Returns the [FlutterDeck] from the widget tree.
  ///
  /// See [FlutterDeck.of].
  FlutterDeck get flutterDeck => FlutterDeck.of(this);
}
