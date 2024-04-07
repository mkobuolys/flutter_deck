// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/widgets.dart';

/// The [ValueNotifier] used to toggle the localization of the slide deck.
///
/// This is used internally only.
class FlutterDeckLocalizationNotifier extends ValueNotifier<Locale> {
  /// Creates a [FlutterDeckLocalizationNotifier] with the given [locale] and
  /// [supportedLocales].
  FlutterDeckLocalizationNotifier({
    required Locale locale,
    required this.supportedLocales,
  }) : super(locale);

  /// The list of supported locales.
  final Iterable<Locale> supportedLocales;

  /// Changes the value of the [FlutterDeckLocalizationNotifier] to the given
  /// [locale].
  void update(Locale locale) => value = locale;
}
