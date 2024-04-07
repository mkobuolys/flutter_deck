import 'package:broadcast_bloc/broadcast_bloc.dart';

/// Cubit for the state of the flutter_deck presentation.
class FlutterDeckStateCubit extends BroadcastCubit<String?> {
  /// Create a new instance.
  FlutterDeckStateCubit() : super(null);

  /// Update the state.
  void update(String state) => emit(state);
}
