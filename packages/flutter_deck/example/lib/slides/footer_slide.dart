import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- You can use a custom footer widget in your slides.
- This example showcases a custom footer with an icon and text.
''';

class FooterSlide extends FlutterDeckSlideWidget {
  const FooterSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          footer: FlutterDeckFooterConfiguration(
            showSlideNumbers: true,
            showSocialHandle: true,
            widget: _CustomFooter(),
          ),
          route: '/footer-slide',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Custom footer slide'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          'A polished footer makes everything look professional.\n\n'
          'Slide numbers, social handles, or fully custom widgets? Easy.',
          style: FlutterDeckTheme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _CustomFooter extends StatelessWidget {
  const _CustomFooter();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [Icon(Icons.home), SizedBox(width: 8), Text('This is a custom footer with icon and text')],
    );
  }
}
