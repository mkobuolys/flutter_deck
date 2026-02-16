import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckSlideSize', () {
    test('responsive constructor should create a responsive slide size', () {
      const slideSize = FlutterDeckSlideSize.responsive();

      expect(slideSize.height, null);
      expect(slideSize.width, null);
      expect(slideSize.aspectRatio, null);
      expect(slideSize.isResponsive, true);
    });

    test('custom constructor should create a custom slide size', () {
      const height = 100.0;
      const width = 200.0;
      const slideSize = FlutterDeckSlideSize.custom(height: height, width: width);

      expect(slideSize.height, height);
      expect(slideSize.width, width);
      expect(slideSize.aspectRatio, width / height);
      expect(slideSize.isResponsive, false);
    });

    test('should assert if height or width is not greater than 0', () {
      expect(() => FlutterDeckSlideSize.custom(height: 0, width: 100), throwsA(isA<AssertionError>()));
      expect(() => FlutterDeckSlideSize.custom(height: 100, width: 0), throwsA(isA<AssertionError>()));
    });

    test('fromAspectRatio constructor should create a slide size from aspect ratio and resolution', () {
      const aspectRatio = FlutterDeckAspectRatio.ratio16x9();
      const resolution = FlutterDeckResolution.fhd();
      final slideSize = FlutterDeckSlideSize.fromAspectRatio(aspectRatio: aspectRatio);

      expect(slideSize.width, resolution.width);
      expect(slideSize.height, resolution.width / aspectRatio.value);
      expect(slideSize.aspectRatio, aspectRatio.value);
      expect(slideSize.isResponsive, false);
    });
  });

  group('FlutterDeckAspectRatio', () {
    test('custom constructor should create a custom aspect ratio', () {
      const ratio = 2.0;
      const aspectRatio = FlutterDeckAspectRatio.custom(ratio);

      expect(aspectRatio.value, ratio);
    });

    test('ratio1x1 should create a 1:1 aspect ratio', () {
      const aspectRatio = FlutterDeckAspectRatio.ratio1x1();

      expect(aspectRatio.value, 1);
    });

    test('ratio4x3 should create a 4:3 aspect ratio', () {
      const aspectRatio = FlutterDeckAspectRatio.ratio4x3();

      expect(aspectRatio.value, 4 / 3);
    });

    test('ratio16x9 should create a 16:9 aspect ratio', () {
      const aspectRatio = FlutterDeckAspectRatio.ratio16x9();

      expect(aspectRatio.value, 16 / 9);
    });

    test('ratio16x10 should create a 16:10 aspect ratio', () {
      const aspectRatio = FlutterDeckAspectRatio.ratio16x10();

      expect(aspectRatio.value, 16 / 10);
    });
  });

  group('FlutterDeckResolution', () {
    test('fromWidth constructor should create a resolution from width', () {
      const width = 100.0;
      const resolution = FlutterDeckResolution.fromWidth(width);

      expect(resolution.width, width);
    });

    test('should assert if width is not greater than 0', () {
      expect(() => FlutterDeckResolution.fromWidth(0), throwsA(isA<AssertionError>()));
    });

    test('hd should create a 720p resolution', () {
      const resolution = FlutterDeckResolution.hd();

      expect(resolution.width, 1280);
    });

    test('fhd should create a 1080p resolution', () {
      const resolution = FlutterDeckResolution.fhd();

      expect(resolution.width, 1920);
    });

    test('qhd should create a 1440p resolution', () {
      const resolution = FlutterDeckResolution.qhd();

      expect(resolution.width, 2560);
    });

    test('uhd should create a 2160p resolution', () {
      const resolution = FlutterDeckResolution.uhd();

      expect(resolution.width, 3840);
    });
  });
}
