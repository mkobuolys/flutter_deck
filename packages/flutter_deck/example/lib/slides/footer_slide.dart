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
            header: FlutterDeckHeaderConfiguration(
              title: 'Custom footer slide',
            ),
          ),
        );

  @override
  FlutterDeckSlide build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          'This showcases the usage of a custom footer widget using a row '
          'of multiple widgets for the footer (this also overrides the social '
          'handle).',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
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
      children: [
        Icon(Icons.home),
        SizedBox(width: 8),
        Text('This is a custom footer with icon and text'),
      ],
    );
  }
}
