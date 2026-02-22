import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

class TitleSlideTemplate extends StatelessWidget {
  const TitleSlideTemplate({required this.title, required this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final titleSlideTheme = FlutterDeckTitleSlideTheme.of(context);
    final titleTextStyle = titleSlideTheme.titleTextStyle?.copyWith(fontSize: 96, fontWeight: FontWeight.bold);
    final subtitleTextStyle = titleSlideTheme.subtitleTextStyle?.copyWith(fontSize: 80, height: 1);

    return FlutterDeckSlideBase(
      contentBuilder: (context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: titleTextStyle),
              if (subtitle != null) Text(subtitle!, style: subtitleTextStyle),
              const SizedBox(height: 64),
              FlutterDeckSpeakerInfoWidget(speakerInfo: context.flutterDeck.speakerInfo!),
            ],
          ),
        ),
      ),
    );
  }
}
