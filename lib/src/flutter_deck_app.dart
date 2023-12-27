import 'package:flutter/material.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/controls/fullscreen/fullscreen.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_router.dart';
import 'package:flutter_deck/src/flutter_deck_slide.dart';
import 'package:flutter_deck/src/flutter_deck_speaker_info.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme_notifier.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';
import 'package:go_router/go_router.dart';

/// The main widget of a slide deck.
///
/// This widget is an entry point to the slide deck. It is responsible for
/// displaying the slides, and handling the navigation between them.
///
/// It is recommended to use the [FlutterDeckApp] as the root widget of your
/// app. This widget will create a [MaterialApp] with the correct theme, will
/// build the router, keyboard shortcuts, and will provide the [FlutterDeck] to
/// all the widgets in the tree.
class FlutterDeckApp extends StatefulWidget {
  /// Creates a new slide deck.
  ///
  /// The [slides] argument must not be null, and must contain at least one
  /// slide.
  ///
  /// The [configuration] argument can be used to provide a global configuration
  /// for the slide deck. This configuration will be used for all slides, unless
  /// a slide has its own configuration.
  ///
  /// The [speakerInfo] argument can be used to provide information about the
  /// speaker. This information will be displayed in the title slide as well as
  /// the footer of all slides.
  ///
  /// The [lightTheme] and [darkTheme] arguments can be used to provide custom
  /// themes for the slide deck.
  ///
  /// The [themeMode] argument can be used to provide a custom theme mode for
  /// the slide deck.
  ///
  /// See also:
  ///
  /// * [FlutterDeckSlide], which represents a single slide.
  /// * [FlutterDeckConfiguration], which represents a global configuration for
  /// the slide deck.
  /// * [FlutterDeckSlideConfiguration], which represents a configuration for a
  /// single slide.
  /// * [FlutterDeckThemeData], which represents a theme for the slide deck.
  /// * [FlutterDeckSpeakerInfo], which represents information about the
  /// speaker.
  const FlutterDeckApp({
    required this.slides,
    this.configuration = const FlutterDeckConfiguration(),
    this.speakerInfo,
    this.lightTheme,
    this.darkTheme,
    this.themeMode = ThemeMode.system,
    super.key,
  }) : assert(slides.length > 0, 'You must provide at least one slide');

  /// A global configuration for the slide deck.
  ///
  /// This configuration will be used for all slides, unless a slide has its own
  /// configuration.
  ///
  /// If not provided, the default [FlutterDeckConfiguration] is used.
  ///
  /// See also:
  ///
  /// * [FlutterDeckSlideConfiguration], which can be used to override the
  ///  global configuration for a specific slide.
  final FlutterDeckConfiguration configuration;

  /// The slides to use in the slide deck.
  ///
  /// The order of the slides determines the order in which they will be
  /// displayed. The first slide will be displayed when the app is first opened.
  final List<FlutterDeckSlideWidget> slides;

  /// Information about the speaker.
  final FlutterDeckSpeakerInfo? speakerInfo;

  /// The theme to use when the app is in light mode.
  ///
  /// If not provided, the default [FlutterDeckThemeData.light] is used.
  final FlutterDeckThemeData? lightTheme;

  /// The theme to use when the app is in dark mode.
  ///
  /// If not provided, the default [FlutterDeckThemeData.dark] is used.
  final FlutterDeckThemeData? darkTheme;

  /// The theme mode to use.
  ///
  /// By default, the system theme mode is used.
  final ThemeMode themeMode;

  @override
  State<FlutterDeckApp> createState() => _FlutterDeckAppState();
}

class _FlutterDeckAppState extends State<FlutterDeckApp> {
  late FlutterDeckRouter _flutterDeckRouter;
  late GoRouter _router;

  late FlutterDeckControlsNotifier _controlsNotifier;
  late FlutterDeckDrawerNotifier _drawerNotifier;
  late FlutterDeckMarkerNotifier _markerNotifier;
  late FlutterDeckThemeNotifier _themeNotifier;

  @override
  void initState() {
    super.initState();

    _buildRouter();

    _controlsNotifier = FlutterDeckControlsNotifier(
      drawerNotifier: _drawerNotifier = FlutterDeckDrawerNotifier(),
      markerNotifier: _markerNotifier = FlutterDeckMarkerNotifier(),
      fullscreenManager: FlutterDeckFullscreenManager(),
      router: _flutterDeckRouter,
    );
    _themeNotifier = FlutterDeckThemeNotifier(widget.themeMode);
  }

  void _buildRouter() {
    final slides = [
      for (final slide in widget.slides.where((s) => !s.configuration.hidden))
        FlutterDeckRouterSlide(
          configuration: slide.configuration.mergeWithGlobal(
            widget.configuration,
          ),
          route: slide.configuration.route,
          widget: slide,
        ),
    ];

    _flutterDeckRouter = FlutterDeckRouter(slides: slides);
    _router = _flutterDeckRouter.build();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _themeNotifier,
      builder: (context, themeMode, _) {
        final theme = context.darkModeEnabled(themeMode)
            ? widget.darkTheme ?? FlutterDeckThemeData.dark()
            : widget.lightTheme ?? FlutterDeckThemeData.light();

        return MaterialApp.router(
          routerConfig: _router,
          theme: theme.materialTheme,
          builder: (context, child) => FlutterDeck(
            configuration: widget.configuration,
            router: _flutterDeckRouter,
            speakerInfo: widget.speakerInfo,
            controlsNotifier: _controlsNotifier,
            drawerNotifier: _drawerNotifier,
            markerNotifier: _markerNotifier,
            themeNotifier: _themeNotifier,
            child: FlutterDeckControlsListener(
              notifier: _controlsNotifier,
              child: FlutterDeckTheme(
                data: theme,
                child: child!,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
