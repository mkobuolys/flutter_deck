import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class SkipSlideIntent extends Intent {
  const SkipSlideIntent();
}

class SkipSlideAction extends ContextAction<SkipSlideIntent> {
  @override
  Object? invoke(SkipSlideIntent intent, [BuildContext? context]) {
    if (context == null) return null;

    final currentSlide = context.flutterDeck.router.currentSlideIndex + 1;

    context.flutterDeck.router.goToSlide(currentSlide + 1);

    return null;
  }
}

class SkipSlideShortcut extends FlutterDeckShortcut<SkipSlideIntent> {
  const SkipSlideShortcut();

  @override
  ShortcutActivator get activator => const SingleActivator(LogicalKeyboardKey.keyS, control: true);

  @override
  SkipSlideIntent get intent => const SkipSlideIntent();

  @override
  Action<SkipSlideIntent> get action => SkipSlideAction();
}
