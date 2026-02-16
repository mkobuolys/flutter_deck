import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckControlsConfiguration', () {
    test('should have correct default values', () {
      const configuration = FlutterDeckControlsConfiguration();

      expect(configuration.presenterToolbarVisible, true);
      expect(configuration.gestures, const FlutterDeckGesturesConfiguration.mobileOnly());
      expect(configuration.shortcuts, const FlutterDeckShortcutsConfiguration());
    });

    test('disabled factory should create disabled configuration', () {
      const configuration = FlutterDeckControlsConfiguration.disabled();

      expect(configuration.presenterToolbarVisible, false);
      expect(configuration.gestures, const FlutterDeckGesturesConfiguration.disabled());
      expect(configuration.shortcuts, const FlutterDeckShortcutsConfiguration.disabled());
    });
  });

  group('FlutterDeckGesturesConfiguration', () {
    test('should have correct default values', () {
      const configuration = FlutterDeckGesturesConfiguration();

      expect(configuration.supportedPlatforms.length, TargetPlatform.values.length);
      expect(configuration.enabled, true);
      // This expectation assumes the test runs on a supported platform.
      // Unit tests usually run on the host platform.
    });

    test('disabled factory should create disabled configuration', () {
      const configuration = FlutterDeckGesturesConfiguration.disabled();

      expect(configuration.supportedPlatforms, isEmpty);
      expect(configuration.enabled, false);
    });

    test('mobileOnly factory should create configuration for mobile platforms', () {
      const configuration = FlutterDeckGesturesConfiguration.mobileOnly();

      expect(configuration.supportedPlatforms, {TargetPlatform.android, TargetPlatform.iOS});
    });

    test('enabled should be true if current platform is supported', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      const configuration = FlutterDeckGesturesConfiguration(supportedPlatforms: {TargetPlatform.iOS});
      expect(configuration.enabled, true);
      debugDefaultTargetPlatformOverride = null;
    });

    test('enabled should be false if current platform is not supported', () {
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      const configuration = FlutterDeckGesturesConfiguration(supportedPlatforms: {TargetPlatform.iOS});
      expect(configuration.enabled, false);
      debugDefaultTargetPlatformOverride = null;
    });
  });

  group('FlutterDeckShortcutsConfiguration', () {
    test('should have correct default values', () {
      const configuration = FlutterDeckShortcutsConfiguration();

      expect(configuration.enabled, true);
      expect(configuration.nextSlide, const SingleActivator(LogicalKeyboardKey.arrowRight));
      expect(configuration.previousSlide, const SingleActivator(LogicalKeyboardKey.arrowLeft));
      expect(configuration.toggleMarker, const SingleActivator(LogicalKeyboardKey.keyM));
      expect(configuration.toggleNavigationDrawer, const SingleActivator(LogicalKeyboardKey.period));
    });

    test('disabled factory should create disabled configuration', () {
      const configuration = FlutterDeckShortcutsConfiguration.disabled();

      expect(configuration.enabled, false);
    });
  });
}
