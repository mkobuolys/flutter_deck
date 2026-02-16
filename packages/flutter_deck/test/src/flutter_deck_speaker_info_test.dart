import 'package:flutter_deck/src/flutter_deck_speaker_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckSpeakerInfo', () {
    test('should have correct values', () {
      const name = 'John Doe';
      const description = 'Software Engineer';
      const socialHandle = '@johndoe';
      const imagePath = 'assets/me.png';

      const speakerInfo = FlutterDeckSpeakerInfo(
        name: name,
        description: description,
        socialHandle: socialHandle,
        imagePath: imagePath,
      );

      expect(speakerInfo.name, name);
      expect(speakerInfo.description, description);
      expect(speakerInfo.socialHandle, socialHandle);
      expect(speakerInfo.imagePath, imagePath);
    });
  });
}
