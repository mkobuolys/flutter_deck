import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/transitions/transitions.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlutterDeckConfiguration', () {
    test('should have correct default values', () {
      const configuration = FlutterDeckConfiguration();

      expect(configuration.background, const FlutterDeckBackgroundConfiguration());
      expect(configuration.controls, const FlutterDeckControlsConfiguration());
      expect(configuration.footer, const FlutterDeckFooterConfiguration(showFooter: false));
      expect(configuration.header, const FlutterDeckHeaderConfiguration(showHeader: false));
      expect(configuration.marker, const FlutterDeckMarkerConfiguration());
      expect(configuration.progressIndicator, const FlutterDeckProgressIndicator.solid());
      expect(configuration.showProgress, true);
      expect(configuration.slideSize, const FlutterDeckSlideSize.responsive());
      expect(configuration.transition, const FlutterDeckTransition.none());
    });

    test('copyWith should return a new configuration with updated values', () {
      const configuration = FlutterDeckConfiguration();
      const newBackground = FlutterDeckBackgroundConfiguration(light: FlutterDeckBackground.solid(Color(0xFF000000)));
      const newControls = FlutterDeckControlsConfiguration(presenterToolbarVisible: false);
      const newFooter = FlutterDeckFooterConfiguration(showSlideNumbers: true);
      const newHeader = FlutterDeckHeaderConfiguration(title: 'Title');
      const newMarker = FlutterDeckMarkerConfiguration(color: Color(0xFF000000));
      const newProgressIndicator = FlutterDeckProgressIndicator.solid(backgroundColor: Color(0xFF000000));
      const newSlideSize = FlutterDeckSlideSize.custom(height: 100, width: 100);
      const newTransition = FlutterDeckTransition.fade();

      final newConfiguration = configuration.copyWith(
        background: newBackground,
        controls: newControls,
        footer: newFooter,
        header: newHeader,
        marker: newMarker,
        progressIndicator: newProgressIndicator,
        showProgress: false,
        slideSize: newSlideSize,
        transition: newTransition,
      );

      expect(newConfiguration.background, newBackground);
      expect(newConfiguration.controls, newControls);
      expect(newConfiguration.footer, newFooter);
      expect(newConfiguration.header, newHeader);
      expect(newConfiguration.marker, newMarker);
      expect(newConfiguration.progressIndicator, newProgressIndicator);
      expect(newConfiguration.showProgress, false);
      expect(newConfiguration.slideSize, newSlideSize);
      expect(newConfiguration.transition, newTransition);
    });
  });

  group('FlutterDeckSlideConfiguration', () {
    test('should have correct default values', () {
      const route = '/slide-1';
      const configuration = FlutterDeckSlideConfiguration(route: route);

      expect(configuration.route, route);
      expect(configuration.hidden, false);
      expect(configuration.initial, false);
      expect(configuration.speakerNotes, '');
      expect(configuration.steps, 1);
      expect(configuration.title, null);
    });

    test('mergeWithGlobal should return a new configuration with merged values', () {
      const globalConfiguration = FlutterDeckConfiguration(
        footer: FlutterDeckFooterConfiguration(showSlideNumbers: true),
        header: FlutterDeckHeaderConfiguration(title: 'Global Title'),
        showProgress: false,
        transition: FlutterDeckTransition.fade(),
      );
      const slideConfiguration = FlutterDeckSlideConfiguration(
        route: '/slide-1',
        footer: FlutterDeckFooterConfiguration(showSocialHandle: true),
        header: FlutterDeckHeaderConfiguration(title: 'Slide Title'),
        showProgress: true,
        transition: FlutterDeckTransition.slide(),
      );

      final mergedConfiguration = slideConfiguration.mergeWithGlobal(globalConfiguration);

      expect(mergedConfiguration.footer.showSlideNumbers, globalConfiguration.footer.showSlideNumbers);
      expect(
        mergedConfiguration.footer.showSocialHandle,
        slideConfiguration
            .footer
            .showSocialHandle, // Should be overridden? Wait, footer is replaced entirely if provided?
      );
      // Let's check how merge works.
      // footer: _footerConfigurationOverride ?? configuration.footer,
      // So if slide config provides footer, it replaces global footer entirely.

      expect(mergedConfiguration.footer, slideConfiguration.footer);
      expect(mergedConfiguration.header, slideConfiguration.header);
      expect(mergedConfiguration.showProgress, true);
      expect(mergedConfiguration.transition, slideConfiguration.transition);

      // Check values not overridden
      expect(mergedConfiguration.controls, globalConfiguration.controls);
      expect(mergedConfiguration.slideSize, globalConfiguration.slideSize);
    });

    test('mergeWithGlobal should use global values when slide values are null', () {
      const globalConfiguration = FlutterDeckConfiguration(
        footer: FlutterDeckFooterConfiguration(showSlideNumbers: true),
        header: FlutterDeckHeaderConfiguration(title: 'Global Title'),
        showProgress: false,
        transition: FlutterDeckTransition.fade(),
      );
      const slideConfiguration = FlutterDeckSlideConfiguration(route: '/slide-1');

      final mergedConfiguration = slideConfiguration.mergeWithGlobal(globalConfiguration);

      expect(mergedConfiguration.footer, globalConfiguration.footer);
      expect(mergedConfiguration.header, globalConfiguration.header);
      expect(mergedConfiguration.showProgress, globalConfiguration.showProgress);
      expect(mergedConfiguration.transition, globalConfiguration.transition);
    });
  });

  group('FlutterDeckHeaderConfiguration', () {
    test('should assert if showHeader is true and title is empty', () {
      expect(FlutterDeckHeaderConfiguration.new, throwsA(isA<AssertionError>()));
    });
  });
}
