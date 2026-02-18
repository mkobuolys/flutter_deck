import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class TitleSlideTemplate extends StatelessWidget {
  const TitleSlideTemplate({required this.title, required this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlideBase(
      contentBuilder: (context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 96, fontWeight: FontWeight.bold)),
            if (subtitle != null) Text(subtitle!, style: const TextStyle(fontSize: 80, height: 1)),
            const SizedBox(height: 64),
            FlutterDeckSpeakerInfoWidget(speakerInfo: context.flutterDeck.speakerInfo!),
          ],
        ),
      ),
    );
  }
}
