import 'package:dart_frog/dart_frog.dart';
import 'package:flutter_deck_ws_server/flutter_deck_state/flutter_deck_state.dart';

Handler middleware(Handler handler) =>
    handler.use(flutterDeckStateCubitProvider);
