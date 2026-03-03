import 'package:flutter/material.dart';
import 'package:flutter_deck/src/transitions/transitions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckTransition', () {
    testWidgets('custom constructor should use custom transition builder', (tester) async {
      const transition = FlutterDeckTransition.custom(transitionBuilder: _CustomTransitionBuilder());

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              return transition.build(
                context,
                const AlwaysStoppedAnimation(1),
                const AlwaysStoppedAnimation(0),
                const SizedBox(),
              );
            },
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('fade constructor should use fade transition builder', (tester) async {
      const transition = FlutterDeckTransition.fade();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              return transition.build(
                context,
                const AlwaysStoppedAnimation(0.5),
                const AlwaysStoppedAnimation(0),
                const SizedBox(),
              );
            },
          ),
        ),
      );

      final fadeTransition = tester.widget<FadeTransition>(find.byType(FadeTransition));
      expect(fadeTransition.opacity.value, 0.5);
    });

    testWidgets('scale constructor should use scale transition builder', (tester) async {
      const transition = FlutterDeckTransition.scale();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              return transition.build(
                context,
                const AlwaysStoppedAnimation(0.5),
                const AlwaysStoppedAnimation(0),
                const SizedBox(),
              );
            },
          ),
        ),
      );

      final scaleTransition = tester.widget<ScaleTransition>(find.byType(ScaleTransition));
      expect(scaleTransition.scale.value, 0.5);
    });

    testWidgets('slide constructor should use slide transition builder', (tester) async {
      const transition = FlutterDeckTransition.slide();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              return transition.build(
                context,
                const AlwaysStoppedAnimation(0.5),
                const AlwaysStoppedAnimation(0),
                const SizedBox(),
              );
            },
          ),
        ),
      );

      expect(find.byType(SlideTransition), findsOneWidget);
    });

    testWidgets('rotation constructor should use rotation transition builder', (tester) async {
      const transition = FlutterDeckTransition.rotation();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              return transition.build(
                context,
                const AlwaysStoppedAnimation(0.5),
                const AlwaysStoppedAnimation(0),
                const SizedBox(),
              );
            },
          ),
        ),
      );

      final rotationTransition = tester.widget<RotationTransition>(find.byType(RotationTransition));
      expect(rotationTransition.turns.value, 0.5);
    });

    testWidgets('none constructor should use no transition builder', (tester) async {
      const transition = FlutterDeckTransition.none();

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: Builder(
            builder: (context) {
              return transition.build(
                context,
                const AlwaysStoppedAnimation(0.5),
                const AlwaysStoppedAnimation(0),
                const SizedBox(),
              );
            },
          ),
        ),
      );

      expect(find.byType(FadeTransition), findsNothing);
      expect(find.byType(ScaleTransition), findsNothing);
      expect(find.byType(SlideTransition), findsNothing);
      expect(find.byType(RotationTransition), findsNothing);
      expect(find.byType(SizedBox), findsOneWidget);
    });
  });
}

class _CustomTransitionBuilder extends FlutterDeckTransitionBuilder {
  const _CustomTransitionBuilder();

  @override
  Widget build(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}
