import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck_configuration.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/flutter_deck_speaker_info.dart';
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
  /// The [controlsNotifier] is required and is used to control the slide deck.
  ///
  /// The [drawerNotifier] is required and is used to control the slide deck's
  /// drawer.
  ///
  /// The [markerNotifier] is required and is used to control the slide deck's
  /// marker.
  ///
  /// The [themeNotifier] is required and is used to control the slide deck's
  /// theme.
  const FlutterDeck({
    required FlutterDeckConfiguration configuration,
    required FlutterDeckRouter router,
    required FlutterDeckSpeakerInfo? speakerInfo,
    required FlutterDeckControlsNotifier controlsNotifier,
    required FlutterDeckDrawerNotifier drawerNotifier,
    required FlutterDeckMarkerNotifier markerNotifier,
    required FlutterDeckThemeNotifier themeNotifier,
    required super.child,
    super.key,
  })  : _configuration = configuration,
        _router = router,
        _speakerInfo = speakerInfo,
        _controlsNotifier = controlsNotifier,
        _drawerNotifier = drawerNotifier,
        _markerNotifier = markerNotifier,
        _themeNotifier = themeNotifier;

  final FlutterDeckConfiguration _configuration;
  final FlutterDeckRouter _router;
  final FlutterDeckSpeakerInfo? _speakerInfo;
  final FlutterDeckControlsNotifier _controlsNotifier;
  final FlutterDeckDrawerNotifier _drawerNotifier;
  final FlutterDeckMarkerNotifier _markerNotifier;
  final FlutterDeckThemeNotifier _themeNotifier;

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
  int get slideNumber => _router.getCurrentSlideIndex() + 1;

  /// Returns the current step number.
  int get stepNumber => _router.getCurrentStep();

  /// Returns the speaker info.
  FlutterDeckSpeakerInfo? get speakerInfo => _speakerInfo;

  /// Returns the configuration for the current slide.
  FlutterDeckSlideConfiguration get configuration =>
      _router.getCurrentSlideConfiguration();

  /// Returns the global configuration for the slide deck.
  FlutterDeckConfiguration get globalConfiguration => _configuration;

  /// Returns the [FlutterDeckControlsNotifier] for the slide deck.
  FlutterDeckControlsNotifier get controlsNotifier => _controlsNotifier;

  /// Returns the [FlutterDeckDrawerNotifier] for the slide deck.
  FlutterDeckDrawerNotifier get drawerNotifier => _drawerNotifier;

  /// Returns the [FlutterDeckMarkerNotifier] for the slide deck.
  FlutterDeckMarkerNotifier get markerNotifier => _markerNotifier;

  /// Returns the [FlutterDeckThemeNotifier] for the slide deck.
  FlutterDeckThemeNotifier get themeNotifier => _themeNotifier;

  /// Find the current [FlutterDeck] in the widget tree.
  ///
  /// See [BuildContext.dependOnInheritedWidgetOfExactType].
  static FlutterDeck of(BuildContext context) {
    final flutterDeck =
        context.dependOnInheritedWidgetOfExactType<FlutterDeck>();

    assert(flutterDeck != null, 'No FlutterDeck found in context');

    return flutterDeck!;
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
