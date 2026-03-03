import 'package:flutter/material.dart';
import 'package:flutter_deck/src/plugins/flutter_deck_plugin.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestPlugin extends FlutterDeckPlugin {
  const _TestPlugin();
}

void main() {
  group('FlutterDeckPlugin', () {
    test('default methods do nothing or return default values', () {
      const plugin = _TestPlugin();

      final mockContext = _MockBuildContext();

      plugin.dispose(); // Should not throw

      final controls = plugin.buildControls(mockContext, (
        context, {
        required String label,
        required VoidCallback? onPressed,
        Widget? icon,
        bool? closeOnActivate,
      }) {
        return const SizedBox();
      });
      expect(controls, isEmpty);

      final wrappedChild = plugin.wrap(mockContext, const Text('Child'));
      expect(wrappedChild, isA<Text>());
    });
  });
}

class _MockBuildContext extends BuildContext {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
