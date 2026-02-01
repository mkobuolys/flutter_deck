import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';

/// The [ChangeNotifier] used to control the autoplay of the slide deck.
class FlutterDeckAutoplayNotifier extends ChangeNotifier {
  /// Creates a [FlutterDeckAutoplayNotifier].
  FlutterDeckAutoplayNotifier({required FlutterDeckRouter router}) : _router = router;

  final FlutterDeckRouter _router;

  var _autoplayDuration = const Duration(seconds: 5);
  Timer? _autoplayTimer;

  var _isLooping = false;
  var _isPlaying = false;

  /// The duration between slides when autoplay is enabled.
  Duration get autoplayDuration => _autoplayDuration;

  /// Whether the slide deck should loop when autoplay is enabled.
  bool get isLooping => _isLooping;

  /// Whether autoplay is enabled.
  bool get isPlaying => _isPlaying;

  /// Pauses the autoplay.
  void pause() {
    if (!isPlaying) return;

    _isPlaying = false;
    _autoplayTimer?.cancel();

    notifyListeners();
  }

  /// Starts the autoplay and goes to the next slide on every
  /// [autoplayDuration].
  ///
  /// If [restart] is true, the autoplay will restart even if it is already
  /// playing.
  ///
  /// If the last slide is reached, the autoplay will stop unless [isLooping] is
  /// true.
  void play({bool restart = false}) {
    if (isPlaying && !restart) return;

    _isPlaying = true;
    notifyListeners();

    _autoplayTimer = Timer.periodic(_autoplayDuration, _onNext);
  }

  void _onNext(_) {
    final configuration = _router.currentSlideConfiguration;
    final slideNumber = _router.currentSlideIndex + 1;
    final stepNumber = _router.currentStep;

    final isLastSlide = slideNumber == _router.slides.length;
    final isLastStep = stepNumber == configuration.steps;

    if (isLastSlide && isLastStep) {
      _isLooping ? _router.goToSlide(1) : pause();
    } else {
      _router.next();
    }

    notifyListeners();
  }

  /// Toggles the autoplay loop mode.
  void toggleLooping() {
    _isLooping = !_isLooping;
    notifyListeners();
  }

  /// Updates the autoplay duration.
  void updateAutoplayDuration(Duration duration) {
    if (duration == _autoplayDuration) return;

    _autoplayDuration = duration;
    notifyListeners();

    if (isPlaying) play(restart: true);
  }
}
