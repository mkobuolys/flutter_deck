import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class ImageSlide extends FlutterDeckImageSlide {
  const ImageSlide({super.key})
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/image-slide',
            header: FlutterDeckHeaderConfiguration(
              title: 'Image slide template',
            ),
          ),
        );

  @override
  Image get image => Image.asset('assets/header.png');

  @override
  String? get label => 'You can also add a small label here (if you want) 👀';
}
