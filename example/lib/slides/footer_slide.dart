import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

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
          'handle. showSocialHandle is true but since widget is not '
          'null, widget is displayed.).',
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
