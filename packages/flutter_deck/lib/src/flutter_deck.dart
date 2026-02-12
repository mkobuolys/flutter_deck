import 'package:flutter/material.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck_app.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/flutter_deck_speaker_info.dart';
import 'package:flutter_deck/src/plugins/plugins.dart';
import 'package:flutter_deck/src/presenter/presenter.dart';
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
/// the [FlutterDeckProvider.of] method or the `flutterDeck` extension on
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
@immutable
class FlutterDeck {
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
  /// The [localizationNotifier] is required and is used to control the slide
  /// deck's localization.
  ///
  /// The [markerNotifier] is required and is used to control the slide deck's
  /// marker.
  ///
  /// The [themeNotifier] is required and is used to control the slide deck's
  /// theme.
  ///
  /// The [plugins] is required and is used to add plugins to the slide deck.
  const FlutterDeck({
    required FlutterDeckConfiguration configuration,
    required FlutterDeckRouter router,
    required FlutterDeckSpeakerInfo? speakerInfo,
    required FlutterDeckControlsNotifier controlsNotifier,
    required FlutterDeckDrawerNotifier drawerNotifier,
    required FlutterDeckLocalizationNotifier localizationNotifier,
    required FlutterDeckMarkerNotifier markerNotifier,
    required FlutterDeckPresenterController presenterController,
    required FlutterDeckThemeNotifier themeNotifier,
    required List<FlutterDeckPlugin> plugins,
    int? stepNumber,
  }) : _configuration = configuration,
       _router = router,
       _speakerInfo = speakerInfo,
       _controlsNotifier = controlsNotifier,
       _drawerNotifier = drawerNotifier,
       _localizationNotifier = localizationNotifier,
       _markerNotifier = markerNotifier,
       _presenterController = presenterController,
       _themeNotifier = themeNotifier,
       _plugins = plugins,
       _stepNumber = stepNumber;

  final FlutterDeckConfiguration _configuration;
  final FlutterDeckRouter _router;
  final FlutterDeckSpeakerInfo? _speakerInfo;
  final FlutterDeckControlsNotifier _controlsNotifier;
  final FlutterDeckDrawerNotifier _drawerNotifier;
  final FlutterDeckLocalizationNotifier _localizationNotifier;
  final FlutterDeckMarkerNotifier _markerNotifier;
  final FlutterDeckPresenterController _presenterController;
  final FlutterDeckThemeNotifier _themeNotifier;
  final List<FlutterDeckPlugin> _plugins;

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
  FlutterDeckSlideConfiguration get configuration =>
      _configuration is FlutterDeckSlideConfiguration ? _configuration : _router.currentSlideConfiguration;

  /// Returns the global configuration for the slide deck.
  FlutterDeckConfiguration get globalConfiguration => _configuration;

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

  /// Returns the list of plugins for the slide deck.
  List<FlutterDeckPlugin> get plugins => _plugins;

  /// Returns the plugin of type [T] for the slide deck.
  T? maybeGetPlugin<T extends FlutterDeckPlugin>() => _plugins.whereType<T>().firstOrNull;

  /// Wraps the given [child] widget with the [FlutterDeckProvider].
  Widget wrap(BuildContext context, {required Widget child}) {
    return FlutterDeckProvider(flutterDeck: this, child: child);
  }

  /// Creates a copy of this [FlutterDeck] but with the given fields replaced with
  /// the new values.
  FlutterDeck copyWith({
    FlutterDeckConfiguration? configuration,
    FlutterDeckRouter? router,
    FlutterDeckSpeakerInfo? speakerInfo,
    FlutterDeckControlsNotifier? controlsNotifier,
    FlutterDeckDrawerNotifier? drawerNotifier,
    FlutterDeckLocalizationNotifier? localizationNotifier,
    FlutterDeckMarkerNotifier? markerNotifier,
    FlutterDeckPresenterController? presenterController,
    FlutterDeckThemeNotifier? themeNotifier,
    List<FlutterDeckPlugin>? plugins,
    int? stepNumber,
  }) {
    return FlutterDeck(
      configuration: configuration ?? _configuration,
      router: router ?? _router,
      speakerInfo: speakerInfo ?? _speakerInfo,
      controlsNotifier: controlsNotifier ?? _controlsNotifier,
      drawerNotifier: drawerNotifier ?? _drawerNotifier,
      localizationNotifier: localizationNotifier ?? _localizationNotifier,
      markerNotifier: markerNotifier ?? _markerNotifier,
      presenterController: presenterController ?? _presenterController,
      themeNotifier: themeNotifier ?? _themeNotifier,
      plugins: plugins ?? _plugins,
      stepNumber: stepNumber ?? _stepNumber,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlutterDeck &&
          runtimeType == other.runtimeType &&
          _configuration == other._configuration &&
          _router == other._router &&
          _speakerInfo == other._speakerInfo &&
          _controlsNotifier == other._controlsNotifier &&
          _drawerNotifier == other._drawerNotifier &&
          _markerNotifier == other._markerNotifier &&
          _themeNotifier == other._themeNotifier;

  @override
  int get hashCode =>
      _configuration.hashCode ^
      _router.hashCode ^
      _speakerInfo.hashCode ^
      _controlsNotifier.hashCode ^
      _drawerNotifier.hashCode ^
      _markerNotifier.hashCode ^
      _themeNotifier.hashCode;
}

/// Provides the [FlutterDeck] to the widget tree.
///
/// This widget is used to provide the [FlutterDeck] to the widget tree.
/// It is recommended to use the [FlutterDeckApp] as the root widget of your
/// app, as it will automatically create a [FlutterDeckProvider].
///
/// See also:
///
/// * [FlutterDeck], which is the main widget of a slide deck.
/// * [FlutterDeckApp], which is the entry point to the slide deck.
class FlutterDeckProvider extends InheritedWidget {
  /// Creates a new [FlutterDeckProvider].
  ///
  /// The [flutterDeck] argument must not be null.
  const FlutterDeckProvider({required this.flutterDeck, required super.child, super.key});

  /// The [FlutterDeck] to provide to the widget tree.
  final FlutterDeck flutterDeck;

  /// Find the current [FlutterDeck] in the widget tree.
  ///
  /// See [BuildContext.dependOnInheritedWidgetOfExactType].
  static FlutterDeck of(BuildContext context) {
    final flutterDeckProvider = context.dependOnInheritedWidgetOfExactType<FlutterDeckProvider>();

    assert(flutterDeckProvider != null, 'No FlutterDeckProvider found in context');

    return flutterDeckProvider!.flutterDeck;
  }

  @override
  bool updateShouldNotify(FlutterDeckProvider oldWidget) => flutterDeck != oldWidget.flutterDeck;
}

/// An extension on [BuildContext] that simplifies accessing the [FlutterDeck]
/// from the widget tree.
extension FlutterDeckX on BuildContext {
  /// Returns the [FlutterDeck] from the widget tree.
  ///
  /// See [FlutterDeckProvider.of].
  FlutterDeck get flutterDeck => FlutterDeckProvider.of(this);
}
