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
  const FlutterDeckMarker({
    required this.notifier,
    required this.child,
    super.key,
  });

  /// The notifier used to control the slide deck's marker.
  final FlutterDeckMarkerNotifier notifier;

  /// The widget below this widget in the tree.
  final Widget child;

  void _updatePath(BuildContext context, Offset globalPosition, int index) {
    final box = context.findRenderObject() as RenderBox?;
    final offset = box?.globalToLocal(globalPosition);

    if (offset != null) notifier.update(index, offset);
  }

  @override
  Widget build(BuildContext context) {
    final configuration = context.flutterDeck.globalConfiguration.marker;

    return ListenableBuilder(
      listenable: notifier,
      builder: (context, child) {
        final paths = notifier.paths;

        return Stack(
          children: [
            child!,
            if (notifier.enabled)
              GestureDetector(
                onPanStart: (details) => _updatePath(
                  context,
                  details.globalPosition,
                  paths.length,
                ),
                onPanUpdate: (details) => _updatePath(
                  context,
                  details.globalPosition,
                  paths.length - 1,
                ),
                child: RepaintBoundary(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: CustomPaint(
                      painter: FlutterDeckMarkerPainter(
                        configuration: configuration,
                        paths: paths,
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
