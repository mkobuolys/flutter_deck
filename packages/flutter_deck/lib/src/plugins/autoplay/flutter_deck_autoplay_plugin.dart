import 'package:flutter/material.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/plugins/autoplay/flutter_deck_autoplay_notifier.dart';
import 'package:flutter_deck/src/plugins/autoplay/flutter_deck_autoplay_provider.dart';
import 'package:flutter_deck/src/plugins/flutter_deck_plugin.dart';

/// A plugin that adds autoplay functionality to the slide deck.
class FlutterDeckAutoplayPlugin extends FlutterDeckPlugin {
  /// Creates a [FlutterDeckAutoplayPlugin].
  FlutterDeckAutoplayPlugin();

  late final FlutterDeckAutoplayNotifier _autoplayNotifier;

  late FlutterDeckControlsNotifier _controlsNotifier;
  var _controlsWasVisible = false;

  @override
  void init(FlutterDeck flutterDeck) {
    _autoplayNotifier = FlutterDeckAutoplayNotifier(router: flutterDeck.router);

    _controlsNotifier = flutterDeck.controlsNotifier;
    _controlsNotifier.addListener(_onControlsChanged);

    _controlsWasVisible = _controlsNotifier.controlsVisible;
  }

  @override
  void dispose() {
    _controlsNotifier.removeListener(_onControlsChanged);
    _autoplayNotifier.dispose();
  }

  void _onControlsChanged() {
    final controlsVisible = _controlsNotifier.controlsVisible;

    // Not a controls visibility change, pause the autoplay.
    if (_controlsWasVisible == controlsVisible) {
      _autoplayNotifier.pause();
    }

    _controlsWasVisible = controlsVisible;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FlutterDeckAutoplayProvider(notifier: _autoplayNotifier, child: child);
  }

  @override
  List<Widget> buildControls(BuildContext context, FlutterDeckPluginMenuItemBuilder menuItemBuilder) {
    return [
      ListenableBuilder(
        listenable: _autoplayNotifier,
        builder: (context, _) => SubmenuButton(
          leadingIcon: const Icon(Icons.play_arrow_rounded),
          menuChildren: [
            menuItemBuilder(
              context,
              icon: _autoplayNotifier.isPlaying
                  ? const Icon(Icons.pause_rounded)
                  : const Icon(Icons.play_arrow_rounded),
              label: _autoplayNotifier.isPlaying ? 'Pause' : 'Play',
              onPressed: _autoplayNotifier.isPlaying ? _autoplayNotifier.pause : _autoplayNotifier.play,
            ),
            const _PopupMenuDivider(),
            _AutoplayDurationButton(
              duration: const Duration(seconds: 1),
              label: 'Every second',
              autoplayNotifier: _autoplayNotifier,
              menuItemBuilder: menuItemBuilder,
            ),
            _AutoplayDurationButton(
              duration: const Duration(seconds: 2),
              label: 'Every 2 seconds',
              autoplayNotifier: _autoplayNotifier,
              menuItemBuilder: menuItemBuilder,
            ),
            _AutoplayDurationButton(
              duration: const Duration(seconds: 3),
              label: 'Every 3 seconds',
              autoplayNotifier: _autoplayNotifier,
              menuItemBuilder: menuItemBuilder,
            ),
            _AutoplayDurationButton(
              duration: const Duration(seconds: 5),
              label: 'Every 5 seconds',
              autoplayNotifier: _autoplayNotifier,
              menuItemBuilder: menuItemBuilder,
            ),
            _AutoplayDurationButton(
              duration: const Duration(seconds: 10),
              label: 'Every 10 seconds',
              autoplayNotifier: _autoplayNotifier,
              menuItemBuilder: menuItemBuilder,
            ),
            _AutoplayDurationButton(
              duration: const Duration(seconds: 15),
              label: 'Every 15 seconds',
              autoplayNotifier: _autoplayNotifier,
              menuItemBuilder: menuItemBuilder,
            ),
            _AutoplayDurationButton(
              duration: const Duration(seconds: 30),
              label: 'Every 30 seconds',
              autoplayNotifier: _autoplayNotifier,
              menuItemBuilder: menuItemBuilder,
            ),
            _AutoplayDurationButton(
              duration: const Duration(seconds: 60),
              label: 'Every minute',
              autoplayNotifier: _autoplayNotifier,
              menuItemBuilder: menuItemBuilder,
            ),
            const _PopupMenuDivider(),
            _AutoplayLoopButton(autoplayNotifier: _autoplayNotifier, menuItemBuilder: menuItemBuilder),
          ],
          child: const Text('Auto-play'),
        ),
      ),
    ];
  }
}

class _PopupMenuDivider extends StatelessWidget {
  const _PopupMenuDivider();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: Theme.of(context).colorScheme.surface, child: const Divider(indent: 12));
  }
}

class _AutoplayDurationButton extends StatelessWidget {
  const _AutoplayDurationButton({
    required this.duration,
    required this.label,
    required this.autoplayNotifier,
    required this.menuItemBuilder,
  });

  final Duration duration;
  final String label;
  final FlutterDeckAutoplayNotifier autoplayNotifier;
  final FlutterDeckPluginMenuItemBuilder menuItemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: autoplayNotifier,
      builder: (context, _) {
        final autoplayDuration = autoplayNotifier.autoplayDuration;
        final selected = autoplayDuration == duration;

        return menuItemBuilder(
          context,
          icon: selected ? const Icon(Icons.check_rounded) : const SizedBox(width: 24),
          label: label,
          onPressed: () => autoplayNotifier.updateAutoplayDuration(duration),
          closeOnActivate: false,
        );
      },
    );
  }
}

class _AutoplayLoopButton extends StatelessWidget {
  const _AutoplayLoopButton({required this.autoplayNotifier, required this.menuItemBuilder});

  final FlutterDeckAutoplayNotifier autoplayNotifier;
  final FlutterDeckPluginMenuItemBuilder menuItemBuilder;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: autoplayNotifier,
      builder: (context, _) {
        final isLooping = autoplayNotifier.isLooping;

        return menuItemBuilder(
          context,
          icon: isLooping ? const Icon(Icons.check_rounded) : const SizedBox(width: 24),
          label: 'Loop',
          onPressed: autoplayNotifier.toggleLooping,
          closeOnActivate: false,
        );
      },
    );
  }
}
