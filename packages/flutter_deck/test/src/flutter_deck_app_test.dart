import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('FlutterDeckApp', () {
    group('when slides list is empty', () {
      test('should throw [AssertionError]', () {
        expect(
          () => FlutterDeckApp(slides: const []),
          throwsA(isA<AssertionError>().having((e) => e.message, 'message', 'You must provide at least one slide')),
        );
      });
    });

    group('adding NavigatorObservers', () {
      testWidgets('adds nothing by default', (tester) async {
        await tester.pumpWidget(FlutterDeckApp(slides: [Container()]));

        final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
        final delegate = app.routerConfig!.routerDelegate as GoRouterDelegate;

        expect(delegate.builder.observers, isEmpty);
      });

      testWidgets('adds observer that registers slide changes', (tester) async {
        final myObserver = MyObserver();

        await tester.pumpWidget(FlutterDeckApp(slides: [Container(), Container()], navigatorObservers: [myObserver]));

        expect(myObserver.changes, hasLength(1));

        await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
        await tester.pumpAndSettle();

        expect(myObserver.changes, hasLength(2));
      });
    });
  });
}

class MyObserver extends NavigatorObserver {
  final changes = <Route>[];

  @override
  void didChangeTop(Route topRoute, Route? previousTopRoute) {
    changes.add(topRoute);
  }
}
