import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- The image slide template renders an image with a small label.
- You can customize the label text style.
''';
const _imageName = 'assets/header.png';

class ImageSlide extends FlutterDeckSlideWidget {
  const ImageSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/image-slide',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Image slide template'),
          preloadImages: {_imageName},
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.image(
      imageBuilder: (context) => Image.asset(_imageName),
      label: 'You can also add a small label here (if you want) 👀',
    );
  }
}
