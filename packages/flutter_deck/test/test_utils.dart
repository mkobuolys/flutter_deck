import 'dart:typed_data';

import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';

final kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);

class SlideTester {
  const SlideTester({required this.tester, required this.showHeader, required this.showFooter, required this.slide});

  final WidgetTester tester;
  final bool showHeader;
  final bool showFooter;
  final FlutterDeckSlideWidget slide;

  Future<void> pumpSlide() async {
    final headerConfig = showHeader
        ? const FlutterDeckHeaderConfiguration(title: 'Slide')
        : const FlutterDeckHeaderConfiguration(showHeader: false);

    final footerConfig = showFooter
        ? const FlutterDeckFooterConfiguration(showSlideNumbers: true, showSocialHandle: true)
        : const FlutterDeckFooterConfiguration();

    await tester.pumpWidget(
      FlutterDeckApp(
        configuration: FlutterDeckConfiguration(footer: footerConfig, header: headerConfig),
        speakerInfo: const FlutterDeckSpeakerInfo(
          description: 'Flutter',
          imagePath: 'assets/header.png',
          name: 'Joe',
          socialHandle: '@flutter_deck',
        ),
        slides: [slide],
      ),
    );
  }
}
