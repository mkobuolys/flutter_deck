import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';

/// A class that handles pre-caching of images for the slide deck.
class FlutterDeckImagePreloader {
  /// Creates a [FlutterDeckImagePreloader].
  FlutterDeckImagePreloader({required FlutterDeckRouter router}) : _router = router;

  final FlutterDeckRouter _router;
  final Set<String> _cachedImages = {};

  /// Disposes the preloader.
  void dispose() {
    _router.removeListener(_onRouterChanged);
  }

  /// Initializes the preloader.
  void init() {
    _router.addListener(_onRouterChanged);
    _onRouterChanged();
  }

  void _onRouterChanged() {
    final slides = _router.slides;
    final currentIndex = _router.currentSlideIndex;

    // Preload images for the next 2 slides
    for (var i = 1; i <= 2; i++) {
      final nextIndex = currentIndex + i;

      if (nextIndex >= slides.length) break;

      final slide = slides[nextIndex];
      final preloadImages = slide.configuration.preloadImages;

      if (preloadImages.isEmpty) continue;

      for (final image in preloadImages) {
        if (_cachedImages.contains(image)) continue;

        _precacheImage(image);
        _cachedImages.add(image);
      }
    }
  }

  void _precacheImage(String image) {
    if (image.startsWith('http') || image.startsWith('https')) {
      precacheImage(NetworkImage(image), _router.navigatorKey.currentContext!);
    } else {
      precacheImage(AssetImage(image), _router.navigatorKey.currentContext!);
    }
  }
}
