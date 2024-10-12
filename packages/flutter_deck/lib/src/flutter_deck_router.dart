import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/presenter/presenter.dart';
import 'package:go_router/go_router.dart';

const _queryParameterStep = 'step';
const _presenterViewRoute = '/presenter-view';

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
  final Widget widget;
}

/// A router for the slide deck.
///
/// This class is used to build the [GoRouter] for the FlutterDeckApp and to
/// control the navigation between slides.
///
/// [FlutterDeckRouter] is a [ChangeNotifier] and notifies listeners when the
/// current slide or step changes.
class FlutterDeckRouter extends ChangeNotifier {
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
  late bool _isPresenterView;

  late GoRouter _router;

  /// Builds the [GoRouter] for the slide deck.
  ///
  /// This method should only be called once and the result should be passed to
  /// the MaterialApp or CupertinoApp's `router` constructor.
  ///
  /// The optional parameter [isPresenterView] can be used to force the deck to
  /// run in presenter view mode or not. If not provided, the deck will run in
  /// presenter view mode if the app is running on the web and the route is
  /// `/presenter-view`.
  GoRouter build({bool? isPresenterView}) {
    _validateRoutes();
    _initRouterData(isPresenterView: isPresenterView);

    return _router = GoRouter(
      routes: _isPresenterView
          ? [
              GoRoute(path: '/', redirect: (_, __) => _presenterViewRoute),
              GoRoute(
                path: _presenterViewRoute,
                builder: (_, __) => const PresenterView(),
              ),
            ]
          : [
              GoRoute(path: '/', redirect: (_, __) => slides.first.route),
              for (final slide in slides)
                GoRoute(
                  path: slide.route,
                  pageBuilder: (context, state) => CustomTransitionPage(
                    key: state.pageKey,
                    restorationId: state.pageKey.value,
                    transitionsBuilder: slide.configuration.transition.build,
                    child: Builder(builder: (context) => slide.widget),
                  ),
                ),
            ],
    )..routeInformationProvider.addListener(notifyListeners);
  }

  void _initRouterData({bool? isPresenterView}) {
    _currentSlideIndex = 0;
    _currentSlideStep = 1;
    _isPresenterView = false;

    if (isPresenterView != null) {
      _isPresenterView = isPresenterView;
      return;
    }

    if (!kIsWeb) return;

    final uri = Uri.parse(Uri.base.fragment);

    _isPresenterView = uri.path == _presenterViewRoute;

    final slideIndex = slides.indexWhere((s) => s.route == uri.path);

    if (slideIndex < 0) return;

    final stepNumber = uri.queryParameters[_queryParameterStep];

    _currentSlideIndex = slideIndex;
    _currentSlideStep = stepNumber != null ? int.tryParse(stepNumber) ?? 1 : 1;
  }

  /// Go to the next slide or step.
  ///
  /// If the current step is the last step, the next slide is displayed.
  /// If the current slide is the last slide, nothing happens.
  void next() {
    final steps = currentSlideConfiguration.steps;

    if (steps > 1 && _currentSlideStep < steps) {
      _currentSlideStep++;

      return _updateRoute();
    }

    if (_currentSlideIndex + 1 >= slides.length) return;

    _currentSlideIndex++;
    _currentSlideStep = 1;

    _updateRoute();
  }

  /// Go to the previous slide or step.
  ///
  /// If the current step is the first step, the previous slide is displayed.
  /// If the current slide is the first slide, nothing happens.
  void previous() {
    final steps = currentSlideConfiguration.steps;

    if (steps > 1 && _currentSlideStep > 1) {
      _currentSlideStep--;

      return _updateRoute();
    }

    if (_currentSlideIndex - 1 < 0) return;

    _currentSlideIndex--;
    _currentSlideStep = 1;

    _updateRoute();
  }

  /// Go to the slide with the given [slideNumber].
  ///
  /// If the slide number is invalid, nothing happens.
  void goToSlide(int slideNumber) {
    final index = slideNumber - 1;

    if (index < 0 || index >= slides.length) return;

    _currentSlideIndex = index;
    _currentSlideStep = 1;

    _updateRoute();
  }

  /// Go to the slide step with the given [stepNumber].
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

    _currentSlideStep = stepNumber;
    _updateRoute();
  }

  void _updateRoute() {
    if (_isPresenterView) return notifyListeners();

    final location = Uri(
      path: slides[_currentSlideIndex].route,
      queryParameters: _currentSlideStep > 1
          ? {_queryParameterStep: '$_currentSlideStep'}
          : null,
    ).toString();

    _router.go(location);
  }

  /// Returns the configuration for the current slide.
  FlutterDeckSlideConfiguration get currentSlideConfiguration =>
      slides[_currentSlideIndex].configuration;

  /// Returns the index of the current slide.
  int get currentSlideIndex => _currentSlideIndex;

  /// Returns the current step of the slide.
  int get currentStep => _currentSlideStep;

  /// Whether the deck runs in presenter view mode.
  bool get isPresenterView => _isPresenterView;

  void _validateRoutes() {
    assert(
      !slides.map((s) => s.route).contains(_presenterViewRoute),
      'The route $_presenterViewRoute is reserved for the presenter view. '
      'Please use a different route.',
    );

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
