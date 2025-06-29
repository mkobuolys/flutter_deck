import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme_notifier.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';
import 'package:flutter_deck_client/flutter_deck_client.dart';

/// A controller that manages the presenter view of the Flutter Deck.
///
/// The controller listens to changes in the
/// [FlutterDeckClient.flutterDeckStateStream] and updates the state of the
/// presentation accordingly.
///
/// The controller also listens to changes in the [FlutterDeckControlsNotifier],
/// [FlutterDeckLocalizationNotifier], [FlutterDeckMarkerNotifier],
/// [FlutterDeckThemeNotifier], and [FlutterDeckRouter] to synchronize the
/// presentation state with all listeners.
///
/// The controller is responsible for initializing the [FlutterDeckClient] and
/// disposing of it when the presenter view is disposed.
class FlutterDeckPresenterController {
  /// Creates a new [FlutterDeckPresenterController] with the given
  /// dependencies.
  ///
  /// The [controlsNotifier], [localizationNotifier], [markerNotifier],
  /// [themeNotifier], and [router] are required dependencies that are used to
  /// manage the state of the presentation.
  ///
  /// The [client] is an optional dependency that can be used to provide a
  /// custom implementation of the [FlutterDeckClient]. If not provided, this controller
  /// will not be able to communicate with a remote presenter view.
  FlutterDeckPresenterController({
    required FlutterDeckControlsNotifier controlsNotifier,
    required FlutterDeckLocalizationNotifier localizationNotifier,
    required FlutterDeckMarkerNotifier markerNotifier,
    required FlutterDeckThemeNotifier themeNotifier,
    required FlutterDeckRouter router,
    FlutterDeckClient? client,
  }) : _controlsNotifier = controlsNotifier,
       _localizationNotifier = localizationNotifier,
       _markerNotifier = markerNotifier,
       _themeNotifier = themeNotifier,
       _router = router,
       _client = client;

  final FlutterDeckControlsNotifier _controlsNotifier;
  final FlutterDeckLocalizationNotifier _localizationNotifier;
  final FlutterDeckMarkerNotifier _markerNotifier;
  final FlutterDeckThemeNotifier _themeNotifier;
  final FlutterDeckRouter _router;
  final FlutterDeckClient? _client;

  late FlutterDeckState _state;
  StreamSubscription<FlutterDeckState>? _stateSubscription;

  /// Initializes the presenter controller and sets up the initial state.
  void init() {
    if (_client == null) return;

    _initState();

    if (_stateSubscription != null) {
      if (!_router.isPresenterView) _client.updateState(_state);

      return;
    }

    _client.init(!_router.isPresenterView ? _state : null);

    _stateSubscription = _client.flutterDeckStateStream.listen(_onStateChanged);
    _localizationNotifier.addListener(_onLocalizationChanged);
    _markerNotifier.addListener(_onMarkerStateChanged);
    _themeNotifier.addListener(_onThemeChanged);
    _router.addListener(_onRouteChanged);
  }

  void _initState() {
    _state = FlutterDeckState(
      locale: _localizationNotifier.value.toLanguageTag(),
      slideIndex: _router.currentSlideIndex,
      slideStep: _router.currentStep,
      themeMode: _themeNotifier.value.name,
    );
  }

  /// Disposes the controller and cleans up resources.
  void dispose() {
    _stateSubscription?.cancel();
    _client?.dispose();
    _localizationNotifier.removeListener(_onLocalizationChanged);
    _markerNotifier.removeListener(_onMarkerStateChanged);
    _themeNotifier.removeListener(_onThemeChanged);
    _router.removeListener(_onRouteChanged);
  }

  /// Returns whether the presenter view is available.
  bool get available => _client != null;

  /// Opens the presenter view.
  void open() => _client?.openPresenterView();

  void _onRouteChanged() =>
      _notify(_state.copyWith(slideIndex: _router.currentSlideIndex, slideStep: _router.currentStep));

  void _onLocalizationChanged() => _notify(_state.copyWith(locale: _localizationNotifier.value.toLanguageTag()));

  void _onMarkerStateChanged() => _notify(_state.copyWith(markerEnabled: _markerNotifier.enabled));

  void _onThemeChanged() => _notify(_state.copyWith(themeMode: _themeNotifier.value.name));

  void _notify(FlutterDeckState state) {
    if (_state == state) return;

    _client?.updateState(_state = state);
  }

  void _onStateChanged(FlutterDeckState state) {
    if (_state == state) return;

    if (state.slideIndex != _state.slideIndex) {
      _controlsNotifier.goToSlide(state.slideIndex + 1);
    }

    if (state.slideStep != _state.slideStep) {
      _controlsNotifier.goToStep(state.slideStep);
    }

    if (state.locale != _state.locale) {
      _localizationNotifier.update(Locale.fromSubtags(languageCode: state.locale));
    }

    if (state.markerEnabled != _state.markerEnabled) {
      _controlsNotifier.toggleMarker();
    }

    if (state.themeMode != _state.themeMode) {
      _themeNotifier.update(ThemeMode.values.byName(state.themeMode));
    }

    _state = state;
  }
}
