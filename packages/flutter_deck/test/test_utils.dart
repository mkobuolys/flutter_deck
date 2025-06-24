import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_test/flutter_test.dart';

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
