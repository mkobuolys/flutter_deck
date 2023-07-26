import 'package:flutter_deck/flutter_deck.dart';

class EndSlide extends FlutterDeckTitleSlide {
  const EndSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/end',
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
        );

  @override
  String get title => 'Thank you! 👋';

  @override
  String? get subtitle => 'Now it\'s your turn to use flutter_deck!';
}
