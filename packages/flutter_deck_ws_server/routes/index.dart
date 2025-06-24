import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:flutter_deck_ws_server/flutter_deck_state/flutter_deck_state.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler((channel, protocol) {
    final cubit = context.read<FlutterDeckStateCubit>()..subscribe(channel);

    if (cubit.state != null) channel.sink.add(cubit.state);

    channel.stream.listen((state) => cubit.update(state as String), onDone: () => cubit.unsubscribe(channel));
  });

  return handler(context);
}
