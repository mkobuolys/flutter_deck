import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/widgets/internal/marker/flutter_deck_marker_notifier.dart';
import 'package:flutter_deck/src/widgets/internal/marker/flutter_deck_marker_painter.dart';

///
class FlutterDeckMarker extends StatelessWidget {
  ///
  const FlutterDeckMarker({
    required this.notifier,
    required this.child,
    super.key,
  });

  ///
  final FlutterDeckMarkerNotifier notifier;

  ///
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
        var widget = child!;

        if (notifier.enabled) {
          final paths = notifier.paths;

          widget = Stack(
            children: [
              widget,
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
              // TODO(mkobuolys): actions to clear and close
            ],
          );
        }

        return widget;
      },
      child: child,
    );
  }
}
