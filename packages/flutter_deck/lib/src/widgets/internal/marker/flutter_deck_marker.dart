import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/widgets/internal/marker/flutter_deck_marker_notifier.dart';
import 'package:flutter_deck/src/widgets/internal/marker/flutter_deck_marker_painter.dart';

/// A widget that allows the user to draw on the slide.
///
/// This widget is automatically added to the widget tree and should not be used
/// directly by the user.
class FlutterDeckMarker extends StatelessWidget {
  /// Creates a [FlutterDeckMarker].
  ///
  /// The [notifier] and [child] arguments must not be null.
  const FlutterDeckMarker({required this.notifier, required this.child, super.key});

  /// The notifier used to control the slide deck's marker.
  final FlutterDeckMarkerNotifier notifier;

  /// The widget below this widget in the tree.
  final Widget child;

  void _updatePath(BuildContext context, String route, Offset globalPosition, {bool startPath = false}) {
    final box = context.findRenderObject() as RenderBox?;
    final offset = box?.globalToLocal(globalPosition);

    if (offset == null) return;

    startPath ? notifier.startPath(route, offset) : notifier.addPoint(route, offset);
  }

  @override
  Widget build(BuildContext context) {
    final flutterDeck = context.flutterDeck;
    final configuration = flutterDeck.globalConfiguration.marker;
    final route = flutterDeck.configuration.route;

    return ListenableBuilder(
      listenable: notifier,
      builder: (context, child) {
        final paths = notifier.pathsForSlide(route);

        return Stack(
          children: [
            child!,
            if (notifier.enabled || paths.isNotEmpty)
              _MarkerOverlay(
                enabled: notifier.enabled,
                onPanStart: (details) => _updatePath(context, route, details.globalPosition, startPath: true),
                onPanUpdate: (details) => _updatePath(context, route, details.globalPosition),
                child: RepaintBoundary(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: CustomPaint(
                      painter: FlutterDeckMarkerPainter(
                        configuration: configuration,
                        paths: paths,
                        version: notifier.version,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
      child: child,
    );
  }
}

class _MarkerOverlay extends StatelessWidget {
  const _MarkerOverlay({
    required this.enabled,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.child,
  });

  final bool enabled;
  final GestureDragStartCallback onPanStart;
  final GestureDragUpdateCallback onPanUpdate;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!enabled) return child;

    return GestureDetector(onPanStart: onPanStart, onPanUpdate: onPanUpdate, child: child);
  }
}
