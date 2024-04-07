import 'package:dart_frog/dart_frog.dart';
import 'package:flutter_deck_ws_server/flutter_deck_state/flutter_deck_state.dart';

final _cubit = FlutterDeckStateCubit();

/// Provider for the [FlutterDeckStateCubit].
final flutterDeckStateCubitProvider = provider<FlutterDeckStateCubit>(
  (_) => _cubit,
);
