import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck_configuration.dart';

///
class FlutterDeckMarkerPainter extends CustomPainter {
  ///
  const FlutterDeckMarkerPainter({
    required this.configuration,
    required this.paths,
  });

  ///
  final FlutterDeckMarkerConfiguration configuration;

  ///
  final List<List<Offset>> paths;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = configuration.color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = configuration.strokeWidth;

    for (final path in paths) {
      for (var i = 0; i < path.length - 1; i++) {
        canvas.drawLine(path[i], path[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(FlutterDeckMarkerPainter oldDelegate) =>
      configuration != oldDelegate.configuration ||
      !listEquals(paths, oldDelegate.paths);
}
