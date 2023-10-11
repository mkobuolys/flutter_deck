import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';

class FooterSlide extends FlutterDeckSlideWidget {
  const FooterSlide()
      : super(
          configuration: const FlutterDeckSlideConfiguration(
            footer: FlutterDeckFooterConfiguration(
              showSlideNumbers: true,
              showSocialHandle: true,
              text: 'This is a custom footer text',
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
          'Based on the configuration, this template renders a header and a '
          'footer.\nThe remaining space is free for your imagination.',
          style: FlutterDeckTheme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
