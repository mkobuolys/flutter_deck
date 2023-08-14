import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class ImageSlide extends FlutterDeckSlideWidget {
  const ImageSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/image-slide',
            header: FlutterDeckHeaderConfiguration(
              title: 'Image slide template',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.image(
      image: Image.asset('assets/header.png'),
      label: 'You can also add a small label here (if you want) 👀',
    );
  }
}
