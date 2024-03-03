import 'package:flutter/material.dart';
import 'package:flutter_deck/src/controls/actions/actions.dart';
import 'package:flutter_deck/src/controls/localized_shortcut_labeler.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

/// A widget that allows the user to control the slide deck.
///
/// The widget renders the following controls:
///
/// * Previous button
/// * Next button
/// * Slide number button, which also opens the navigation drawer
/// * Marker controls
/// * Toggle fullscreen button (when on a supported platform)
/// * Theme switcher
/// * Autoplay controls
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

    if (!flutterDeck.globalConfiguration.controls.presenterToolbarVisible) {
      return child;
    }

    final controlsNotifier = flutterDeck.controlsNotifier;

    return ListenableBuilder(
      listenable: controlsNotifier,
      builder: (context, child) => Stack(
        children: [
          child!,
          if (controlsNotifier.controlsVisible)
            const Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: _Controls(),
            ),
        ],
      ),
      child: child,
    );
  }
}

class _Controls extends StatelessWidget {
  const _Controls();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Builder(
        builder: (context) => Container(
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
    );
  }
}

class _PreviousButton extends StatelessWidget {
  const _PreviousButton();

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final controlsNotifier = flutterDeck.controlsNotifier;
    final shortcuts = flutterDeck.globalConfiguration.controls.shortcuts;
    final shortcut = LocalizedShortcutLabeler.instance.getShortcutLabel(
      shortcuts.previousSlide,
      MaterialLocalizations.of(context),
    );

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
              '${shortcuts.enabled ? ' ($shortcut)' : ''}',
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
    final shortcuts = flutterDeck.globalConfiguration.controls.shortcuts;
    final shortcut = LocalizedShortcutLabeler.instance.getShortcutLabel(
      shortcuts.nextSlide,
      MaterialLocalizations.of(context),
    );

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
              '${shortcuts.enabled ? ' ($shortcut)' : ''}',
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
    final shortcuts = flutterDeck.globalConfiguration.controls.shortcuts;
    final shortcut = LocalizedShortcutLabeler.instance.getShortcutLabel(
      shortcuts.toggleNavigationDrawer,
      MaterialLocalizations.of(context),
    );

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
              '${shortcuts.enabled ? ' ($shortcut)' : ''}',
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
    final shortcuts = flutterDeck.globalConfiguration.controls.shortcuts;
    final shortcut = LocalizedShortcutLabeler.instance.getShortcutLabel(
      shortcuts.toggleMarker,
      MaterialLocalizations.of(context),
    );

    return ListenableBuilder(
      listenable: markerNotifier,
      builder: (context, child) => markerNotifier.enabled
          ? Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_off_rounded),
                  tooltip: 'Turn off marker'
                      '${shortcuts.enabled ? ' ($shortcut)' : ''}',
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

class _AutoplayMenuButton extends StatelessWidget {
  const _AutoplayMenuButton();

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final autoplayNotifier = flutterDeck.autoplayNotifier;
    final markerNotifier = flutterDeck.markerNotifier;

    return ListenableBuilder(
      listenable: markerNotifier,
      builder: (context, _) => SubmenuButton(
        leadingIcon: const Icon(Icons.play_arrow_rounded),
        menuChildren: [
          if (!markerNotifier.enabled) ...[
            MenuItemButton(
              leadingIcon: autoplayNotifier.isPlaying
                  ? const Icon(Icons.pause_rounded)
                  : const Icon(Icons.play_arrow_rounded),
              onPressed: autoplayNotifier.isPlaying
                  ? autoplayNotifier.pause
                  : autoplayNotifier.play,
              child: const Text('Play'),
            ),
            const _PopupMenuDivider(),
            const _AutoplayDurationButton(
              duration: Duration(seconds: 1),
              label: 'Every second',
            ),
            const _AutoplayDurationButton(
              duration: Duration(seconds: 2),
              label: 'Every 2 seconds',
            ),
            const _AutoplayDurationButton(
              duration: Duration(seconds: 3),
              label: 'Every 3 seconds',
            ),
            const _AutoplayDurationButton(
              duration: Duration(seconds: 5),
              label: 'Every 5 seconds',
            ),
            const _AutoplayDurationButton(
              duration: Duration(seconds: 10),
              label: 'Every 10 seconds',
            ),
            const _AutoplayDurationButton(
              duration: Duration(seconds: 15),
              label: 'Every 15 seconds',
            ),
            const _AutoplayDurationButton(
              duration: Duration(seconds: 30),
              label: 'Every 30 seconds',
            ),
            const _AutoplayDurationButton(
              duration: Duration(seconds: 60),
              label: 'Every minute',
            ),
            const _PopupMenuDivider(),
            const _AutoplayLoopButton(),
          ],
        ],
        child: const Text('Auto-play'),
      ),
    );
  }
}

class _LocalizationMenuButton extends StatelessWidget {
  const _LocalizationMenuButton();

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final localizationNotifier = flutterDeck.localizationNotifier;

    return ValueListenableBuilder(
      valueListenable: localizationNotifier,
      builder: (context, locale, _) => SubmenuButton(
        leadingIcon: const Icon(Icons.language_rounded),
        menuChildren: [
          for (final supportedLocale in localizationNotifier.supportedLocales)
            _MenuSelectionButton(
              selected: supportedLocale == locale,
              label: supportedLocale.languageCode,
              onPressed: () => localizationNotifier.update(supportedLocale),
            ),
        ],
        child: Text('Language: ${locale.languageCode}'),
      ),
    );
  }
}

class _AutoplayDurationButton extends StatelessWidget {
  const _AutoplayDurationButton({
    required this.duration,
    required this.label,
  });

  final Duration duration;
  final String label;

  @override
  Widget build(BuildContext context) {
    final autoplayNotifier = context.flutterDeck.autoplayNotifier;

    return ListenableBuilder(
      listenable: autoplayNotifier,
      builder: (context, _) {
        final autoplayDuration = autoplayNotifier.autoplayDuration;

        return _MenuSelectionButton(
          selected: autoplayDuration == duration,
          label: label,
          onPressed: () => autoplayNotifier.updateAutoplayDuration(duration),
        );
      },
    );
  }
}

class _AutoplayLoopButton extends StatelessWidget {
  const _AutoplayLoopButton();

  @override
  Widget build(BuildContext context) {
    final autoplayNotifier = context.flutterDeck.autoplayNotifier;

    return ListenableBuilder(
      listenable: autoplayNotifier,
      builder: (context, _) {
        final isLooping = autoplayNotifier.isLooping;

        return _MenuSelectionButton(
          selected: isLooping,
          label: 'Loop',
          onPressed: autoplayNotifier.toggleLooping,
        );
      },
    );
  }
}

class _MenuSelectionButton extends StatelessWidget {
  const _MenuSelectionButton({
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      closeOnActivate: false,
      leadingIcon: selected
          ? const Icon(Icons.check_rounded)
          : const SizedBox(width: 24),
      trailingIcon: const SizedBox(width: 24),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class _MarkerButton extends StatelessWidget {
  const _MarkerButton();

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final controlsNotifier = flutterDeck.controlsNotifier;
    final shortcuts = flutterDeck.globalConfiguration.controls.shortcuts;
    final shortcut = LocalizedShortcutLabeler.instance.getShortcutLabel(
      shortcuts.toggleMarker,
      MaterialLocalizations.of(context),
    );

    return MenuItemButton(
      leadingIcon: const Icon(Icons.edit_rounded),
      trailingIcon: shortcuts.enabled ? Text('($shortcut)') : null,
      onPressed: controlsNotifier.toggleMarker,
      child: const Text('Toggle marker'),
    );
  }
}

class _FullscreenButton extends StatelessWidget {
  const _FullscreenButton();

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final controlsNotifier = flutterDeck.controlsNotifier;
    final markerNotifier = flutterDeck.markerNotifier;

    final isInFullscreen = controlsNotifier.isInFullscreen();
    final onPressed = isInFullscreen
        ? controlsNotifier.leaveFullscreen
        : controlsNotifier.enterFullscreen;

    return ListenableBuilder(
      listenable: markerNotifier,
      builder: (context, _) => MenuItemButton(
        leadingIcon: Icon(
          isInFullscreen
              ? Icons.fullscreen_exit_rounded
              : Icons.fullscreen_rounded,
        ),
        onPressed: !markerNotifier.enabled ? onPressed : null,
        child: Text(isInFullscreen ? 'Leave full screen' : 'Enter full screen'),
      ),
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
    final flutterDeck = context.flutterDeck;
    final controlsNotifier = flutterDeck.controlsNotifier;
    final canFullscreen = controlsNotifier.canFullscreen();
    final supportedLocales = flutterDeck.localizationNotifier.supportedLocales;

    return MenuButtonTheme(
      data: MenuButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            Theme.of(context).colorScheme.surface,
          ),
        ),
      ),
      child: MenuAnchor(
        builder: (context, controller, child) => IconButton(
          icon: const Icon(Icons.more_vert_rounded),
          tooltip: 'Open menu',
          onPressed: controller.isOpen ? controller.close : controller.open,
        ),
        menuChildren: [
          const _ThemeButton(),
          const _MarkerButton(),
          if (canFullscreen) const _FullscreenButton(),
          const _PopupMenuDivider(),
          const _AutoplayMenuButton(),
          if (supportedLocales.length > 1) const _LocalizationMenuButton(),
        ],
      ),
    );
  }
}

class _PopupMenuDivider extends StatelessWidget {
  const _PopupMenuDivider();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: const Divider(indent: 12),
    );
  }
}
