import 'dart:async';

import 'package:flutter/material.dart';

/// A timer widget that displays the elapsed presentation time.
///
/// The timer can be paused, resumed, or reset using the buttons displayed
/// next to the timer.
class FlutterDeckPresenterTimer extends StatefulWidget {
  /// Creates a [FlutterDeckPresenterTimer] widget.
  const FlutterDeckPresenterTimer({super.key});

  @override
  State<FlutterDeckPresenterTimer> createState() =>
      _FlutterDeckPresenterTimerState();
}

class _FlutterDeckPresenterTimerState extends State<FlutterDeckPresenterTimer> {
  late final Timer _timer;
  late final Stopwatch _stopwatch;

  @override
  void initState() {
    super.initState();

    _stopwatch = Stopwatch()..start();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer.cancel();

    super.dispose();
  }

  String _addLeadingZero(int value) => value.toString().padLeft(2, '0');

  String get _formattedTimer {
    final duration = _stopwatch.elapsed;
    final hours = _addLeadingZero(duration.inHours);
    final minutes = _addLeadingZero(duration.inMinutes.remainder(60).abs());
    final seconds = _addLeadingZero(duration.inSeconds.remainder(60).abs());

    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            _formattedTimer,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () => setState(
              _stopwatch.isRunning ? _stopwatch.stop : _stopwatch.start,
            ),
            icon: Icon(
              _stopwatch.isRunning
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
            ),
            tooltip: _stopwatch.isRunning ? 'Pause timer' : 'Resume timer',
          ),
          IconButton(
            onPressed: () => setState(_stopwatch.reset),
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Reset timer',
          ),
        ],
      ),
    );
  }
}
