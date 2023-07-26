import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck_configuration.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/flutter_deck_speaker_info.dart';
import 'package:flutter_deck/src/inherited_flutter_deck.dart';
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
/// The [FlutterDeck] is available in the widget tree via the
/// [InheritedFlutterDeck] widget. The [FlutterDeck] can be accessed using the
/// [FlutterDeck.of] method or the `flutterDeck` extension on [BuildContext].
///
/// See also:
/// * [FlutterDeckConfiguration], which is used to configure the slide deck.
/// * [FlutterDeckRouter], which is used to navigate between slides and steps.
/// * [FlutterDeckSpeakerInfo], which is used to access the speaker info.
/// * [FlutterDeckDrawerNotifier], which is used to control the slide deck's
///  drawer.
/// * [FlutterDeckThemeNotifier], which is used to control the slide deck's
/// theme.
class FlutterDeck {
  /// Default constructor for [FlutterDeck].
  ///
  /// The [configuration] is required and is used to configure the slide deck.
  ///
  /// The [router] is required and is used to navigate between slides.
  ///
  /// The [speakerInfo] is optional and is used to access the speaker info.
  ///
  /// The [drawerNotifier] is required and is used to control the slide deck's
  /// drawer.
  ///
  /// The [themeNotifier] is required and is used to control the slide deck's
  /// theme.
  const FlutterDeck({
    required FlutterDeckConfiguration configuration,
    required FlutterDeckRouter router,
    required FlutterDeckSpeakerInfo? speakerInfo,
    required FlutterDeckDrawerNotifier drawerNotifier,
    required FlutterDeckThemeNotifier themeNotifier,
  })  : _configuration = configuration,
        _router = router,
        _speakerInfo = speakerInfo,
        _drawerNotifier = drawerNotifier,
        _themeNotifier = themeNotifier;

  final FlutterDeckConfiguration _configuration;
  final FlutterDeckRouter _router;
  final FlutterDeckSpeakerInfo? _speakerInfo;
  final FlutterDeckDrawerNotifier _drawerNotifier;
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

  /// Returns the [FlutterDeckDrawerNotifier] for the slide deck.
  FlutterDeckDrawerNotifier get drawerNotifier => _drawerNotifier;

  /// Returns the [FlutterDeckThemeNotifier] for the slide deck.
  FlutterDeckThemeNotifier get themeNotifier => _themeNotifier;

  /// Find the current [FlutterDeck] in the widget tree.
  ///
  /// See [BuildContext.dependOnInheritedWidgetOfExactType].
  static FlutterDeck of(BuildContext context) {
    final inheritedFlutterDeck =
        context.dependOnInheritedWidgetOfExactType<InheritedFlutterDeck>();

    assert(inheritedFlutterDeck != null, 'No FlutterDeck found in context');

    return inheritedFlutterDeck!.flutterDeck;
  }
}

/// An extension on [BuildContext] that simplifies accessing the [FlutterDeck]
/// from the widget tree.
extension FlutterDeckX on BuildContext {
  /// Returns the [FlutterDeck] from the widget tree.
  ///
  /// See [FlutterDeck.of].
  FlutterDeck get flutterDeck => FlutterDeck.of(this);
}
