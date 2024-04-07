import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/flutter_deck_slide.dart';
import 'package:go_router/go_router.dart';

const _queryParameterStep = 'step';

/// A slide route for the slide deck.
class FlutterDeckRouterSlide {
  /// Creates a slide route for the slide deck.
  ///
  /// [configuration], [route], and [widget] must not be null.
  const FlutterDeckRouterSlide({
    required this.configuration,
    required this.route,
    required this.widget,
  });

  /// The configuration for the slide.
  final FlutterDeckSlideConfiguration configuration;

  /// The route for the slide.
  final String route;

  /// The slide widget to display.
  final FlutterDeckSlideWidget widget;
}

/// A router for the slide deck.
///
/// This class is used to build the [GoRouter] for the FlutterDeckApp and to
/// control the navigation between slides.
class FlutterDeckRouter {
  /// Default constructor for [FlutterDeckRouter].
  FlutterDeckRouter({
    required this.slides,
  });

  /// The slides to use in the slide deck.
  ///
  /// The order of the slides determines the order in which they will be
  /// displayed. The first slide will be displayed when the app is first opened.
  final List<FlutterDeckRouterSlide> slides;

  late int _currentSlideIndex;
  late int _currentSlideStep;

  late GoRouter _router;

  /// Builds the [GoRouter] for the slide deck.
  ///
  /// This method should only be called once and the result should be passed to
  /// the MaterialApp or CupertinoApp's `router` constructor.
  GoRouter build() {
    _validateRoutes();
    _initRouterData();

    return _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          redirect: (_, __) => slides.first.route,
        ),
        for (final slide in slides)
          GoRoute(
            path: slide.route,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              restorationId: state.pageKey.value,
              transitionsBuilder: slide.configuration.transition.build,
              child: Builder(builder: slide.widget.build),
            ),
          ),
      ],
    );
  }

  void _initRouterData() {
    _currentSlideIndex = 0;
    _currentSlideStep = 1;

    if (!kIsWeb) return;

    final uri = Uri.parse(Uri.base.fragment);
    final slideIndex = slides.indexWhere((s) => s.route == uri.path);

    if (slideIndex < 0) return;

    final stepNumber = uri.queryParameters[_queryParameterStep];

    _currentSlideIndex = slideIndex;
    _currentSlideStep = stepNumber != null ? int.tryParse(stepNumber) ?? 1 : 1;
  }

  /// Adds a listener to the slide router.
  void addListener(void Function() listener) =>
      _router.routeInformationProvider.addListener(listener);

  /// Removes a listener from the slide router.
  void removeListener(void Function() listener) =>
      _router.routeInformationProvider.removeListener(listener);

  /// Go to the next slide or step.
  ///
  /// If the current step is the last step, the next slide is displayed.
  /// If the current slide is the last slide, nothing happens.
  void next() {
    final steps = currentSlideConfiguration.steps;

    if (steps > 1 && _currentSlideStep < steps) {
      final location = Uri(
        path: slides[_currentSlideIndex].route,
        queryParameters: {_queryParameterStep: '${++_currentSlideStep}'},
      ).toString();

      return _router.go(location);
    }

    if (_currentSlideIndex + 1 >= slides.length) return;

    _currentSlideStep = 1;
    _router.go(slides[++_currentSlideIndex].route);
  }

  /// Go to the previous slide or step.
  ///
  /// If the current step is the first step, the previous slide is displayed.
  /// If the current slide is the first slide, nothing happens.
  void previous() {
    final steps = currentSlideConfiguration.steps;

    if (steps > 1 && _currentSlideStep > 1) {
      final location = Uri(
        path: slides[_currentSlideIndex].route,
        queryParameters: {_queryParameterStep: '${--_currentSlideStep}'},
      ).toString();

      return _router.go(location);
    }

    if (_currentSlideIndex - 1 < 0) return;

    _currentSlideStep = 1;
    _router.go(slides[--_currentSlideIndex].route);
  }

  /// Go to a specific slide by its number.
  ///
  /// If the slide number is invalid, nothing happens.
  void goToSlide(int slideNumber) {
    final index = slideNumber - 1;

    if (index < 0 || index >= slides.length) return;

    _currentSlideStep = 1;
    _router.go(slides[_currentSlideIndex = index].route);
  }

  /// Go to a specific step by its number.
  ///
  /// If the step number is invalid or the same as the current step,
  /// nothing happens.
  void goToStep(int stepNumber) {
    final steps = currentSlideConfiguration.steps;

    if (stepNumber == _currentSlideStep ||
        stepNumber < 1 ||
        stepNumber > steps) {
      return;
    }

    final location = Uri(
      path: currentSlideConfiguration.route,
      queryParameters: {_queryParameterStep: '$stepNumber'},
    ).toString();

    _currentSlideStep = stepNumber;
    _router.go(location);
  }

  /// Returns the configuration for the current slide.
  FlutterDeckSlideConfiguration get currentSlideConfiguration =>
      slides[_currentSlideIndex].configuration;

  /// Returns the index of the current slide.
  int get currentSlideIndex => _currentSlideIndex;

  /// Returns the current step of the slide.
  int get currentStep => _currentSlideStep;

  void _validateRoutes() {
    final duplicatedRoutes = slides
        .fold(
          <String, List<String>>{},
          (routesMap, slide) {
            final route = slide.route;

            (routesMap[route] ??= []).add(route);

            return routesMap;
          },
        )
        .values
        .where((routes) => routes.length > 1)
        .expand((route) => route)
        .toSet()
        .join(', ');

    assert(
      duplicatedRoutes.isEmpty,
      'Slide routes must be unique. Duplicate routes found: $duplicatedRoutes',
    );
  }
}
