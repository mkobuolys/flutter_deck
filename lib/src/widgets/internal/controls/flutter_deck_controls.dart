import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_deck/src/widgets/internal/controls/actions/actions.dart';

/// A widget that allows the user to control the slide deck.
///
/// The widget renders the following controls:
///
/// * Previous button
/// * Next button
/// * Slide number button, which also opens the navigation drawer
/// * Marker controls
/// * Theme switcher
///
/// Controls are only rendered if they are enabled in the global configuration.
/// Control component visibility is also handled by this widget. The controls
/// will be hidden after 3 seconds of cursor inactivity.
///
/// This widget is automatically added to the widget tree and should not be used
/// directly by the user.
class FlutterDeckControls extends StatelessWidget {
  /// Creates a [FlutterDeckControls].
  ///
  /// The [child] argument must not be null.
  const FlutterDeckControls({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;

    if (!flutterDeck.globalConfiguration.controls.enabled) return child;

    final controlsNotifier = flutterDeck.controlsNotifier;

    return ListenableBuilder(
      listenable: controlsNotifier,
      builder: (context, child) => Stack(
        children: [
          child!,
          if (controlsNotifier.controlsVisible)
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                margin: FlutterDeckLayout.slidePadding,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _PreviousButton(),
                    _SlideNumberButton(),
                    _NextButton(),
                    _MarkerControls(),
                    _OptionsMenuButton(),
                  ],
                ),
              ),
            ),
        ],
      ),
      child: child,
    );
  }
}

class _PreviousButton extends StatelessWidget {
  const _PreviousButton();

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final controlsNotifier = flutterDeck.controlsNotifier;
    final controls = flutterDeck.globalConfiguration.controls;
    final shortcut = controls.previousKey.keyLabel;

    return ListenableBuilder(
      listenable: controlsNotifier,
      builder: (context, child) {
        final isFirstSlide = flutterDeck.slideNumber == 1;
        final isFirstStep = flutterDeck.stepNumber == 1;
        final enabled = !(isFirstSlide && isFirstStep) &&
            !controlsNotifier.intentDisabled(const GoPreviousIntent());

        return IconButton(
          icon: const Icon(Icons.keyboard_arrow_left_rounded),
          tooltip: 'Previous'
              '${controls.shortcutsEnabled ? ' ($shortcut)' : ''}',
          onPressed: enabled ? controlsNotifier.previous : null,
        );
      },
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final controlsNotifier = flutterDeck.controlsNotifier;
    final controls = flutterDeck.globalConfiguration.controls;
    final shortcut = controls.nextKey.keyLabel;

    return ListenableBuilder(
      listenable: controlsNotifier,
      builder: (context, child) {
        final isLastSlide =
            flutterDeck.slideNumber == flutterDeck.router.slides.length;
        final isLastStep =
            flutterDeck.stepNumber == flutterDeck.configuration.steps;
        final enabled = !(isLastSlide && isLastStep) &&
            !controlsNotifier.intentDisabled(const GoNextIntent());

        return IconButton(
          icon: const Icon(Icons.keyboard_arrow_right_rounded),
          tooltip: 'Next'
              '${controls.shortcutsEnabled ? ' ($shortcut)' : ''}',
          onPressed: enabled ? controlsNotifier.next : null,
        );
      },
    );
  }
}

class _SlideNumberButton extends StatelessWidget {
  const _SlideNumberButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final flutterDeck = context.flutterDeck;
    final controlsNotifier = flutterDeck.controlsNotifier;
    final controls = flutterDeck.globalConfiguration.controls;
    final shortcut = controls.openDrawerKey.keyLabel;

    return ListenableBuilder(
      listenable: controlsNotifier,
      builder: (context, child) {
        final enabled =
            !controlsNotifier.intentDisabled(const ToggleDrawerIntent());

        return IconButton(
          icon: Text(
            '${flutterDeck.slideNumber}',
            style: TextStyle(
              color: enabled ? theme.iconTheme.color : theme.disabledColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          tooltip: 'Open navigation drawer'
              '${controls.shortcutsEnabled ? ' ($shortcut)' : ''}',
          onPressed: enabled ? controlsNotifier.toggleDrawer : null,
        );
      },
    );
  }
}

class _MarkerControls extends StatelessWidget {
  const _MarkerControls();

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final controlsNotifier = flutterDeck.controlsNotifier;
    final markerNotifier = flutterDeck.markerNotifier;
    final controls = flutterDeck.globalConfiguration.controls;
    final shortcut = controls.toggleMarkerKey.keyLabel;

    return ListenableBuilder(
      listenable: markerNotifier,
      builder: (context, child) => markerNotifier.enabled
          ? Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_off_rounded),
                  tooltip: 'Turn off marker'
                      '${controls.shortcutsEnabled ? ' ($shortcut)' : ''}',
                  onPressed: controlsNotifier.toggleMarker,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_forever_rounded),
                  tooltip: 'Erase all',
                  onPressed: markerNotifier.paths.isNotEmpty
                      ? markerNotifier.clear
                      : null,
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}

class _MarkerButton extends StatelessWidget {
  const _MarkerButton();

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final controlsNotifier = flutterDeck.controlsNotifier;
    final controls = flutterDeck.globalConfiguration.controls;
    final shortcut = controls.toggleMarkerKey.keyLabel;

    return MenuItemButton(
      leadingIcon: const Icon(Icons.edit_rounded),
      trailingIcon: controls.shortcutsEnabled ? Text('($shortcut)') : null,
      onPressed: controlsNotifier.toggleMarker,
      child: const Text('Toggle marker'),
    );
  }
}

class _ThemeButton extends StatelessWidget {
  const _ThemeButton();

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.flutterDeck.themeNotifier;

    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, themeMode, _) => context.darkModeEnabled(themeMode)
          ? MenuItemButton(
              leadingIcon: const Icon(Icons.light_mode_rounded),
              onPressed: () => themeNotifier.update(ThemeMode.light),
              child: const Text('Use light mode'),
            )
          : MenuItemButton(
              leadingIcon: const Icon(Icons.dark_mode_rounded),
              onPressed: () => themeNotifier.update(ThemeMode.dark),
              child: const Text('Use dark mode'),
            ),
    );
  }
}

class _OptionsMenuButton extends StatelessWidget {
  const _OptionsMenuButton();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) => IconButton(
        icon: const Icon(Icons.more_vert_rounded),
        tooltip: 'Open menu',
        onPressed: controller.isOpen ? controller.close : controller.open,
      ),
      menuChildren: const [
        _ThemeButton(),
        _MarkerButton(),
      ],
    );
  }
}
