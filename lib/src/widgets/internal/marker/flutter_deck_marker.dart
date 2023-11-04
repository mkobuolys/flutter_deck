import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_layout.dart';
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
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Container(
                  margin: FlutterDeckLayout.slidePadding,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.cleaning_services_rounded),
                        onPressed:
                            notifier.paths.isNotEmpty ? notifier.clear : null,
                        tooltip: 'Clear',
                      ),
                      const SizedBox(height: 4),
                      IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed:
                            context.flutterDeck.controlsNotifier.toggleMarker,
                        tooltip: 'Close',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return widget;
      },
      child: child,
    );
  }
}
