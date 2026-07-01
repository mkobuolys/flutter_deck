import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/widgets/internal/marker/flutter_deck_marker_notifier.dart';

/// Clears the marker drawings when the current slide changes if marker
/// persistence is disabled.
///
/// When persistence is enabled (the default), this controller does nothing and
/// each slide keeps its own drawings. When disabled, the controller listens to
/// the [FlutterDeckRouter] and clears all drawings whenever the current slide
/// changes. Step changes within the same slide do not clear the drawings.
class FlutterDeckMarkerController {
  /// Creates a [FlutterDeckMarkerController].
  FlutterDeckMarkerController({
    required FlutterDeckRouter router,
    required FlutterDeckMarkerNotifier markerNotifier,
    required bool persist,
  }) : _router = router,
       _markerNotifier = markerNotifier,
       _persist = persist;

  final FlutterDeckRouter _router;
  final FlutterDeckMarkerNotifier _markerNotifier;
  final bool _persist;

  late int _lastSlideIndex;

  /// Initializes the controller.
  void init() {
    if (_persist) return;

    _lastSlideIndex = _router.currentSlideIndex;
    _router.addListener(_onSlideChanged);
  }

  /// Disposes the controller.
  void dispose() {
    if (_persist) return;

    _router.removeListener(_onSlideChanged);
  }

  void _onSlideChanged() {
    final slideIndex = _router.currentSlideIndex;

    if (slideIndex == _lastSlideIndex) return;

    _lastSlideIndex = slideIndex;
    _markerNotifier.clearAll();
  }
}
