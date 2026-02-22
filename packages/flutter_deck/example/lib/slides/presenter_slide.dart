import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- If you're reading this, you're using Presenter View!
- It's a great feature to control the presentation while seeing notes and upcoming slides.
- It even tracks your time!
''';

class PresenterSlide extends FlutterDeckSlideWidget {
  const PresenterSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/presenter',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Presenter View'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          'Control the room with presenter view 🖥️\n\n'
          'Keep your speaker notes handy, track your time, and see what is '
          'coming next.\n\nOpen the deck controls and launch the presenter '
          'view in a new window to see the magic!',
          style: FlutterDeckTheme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
