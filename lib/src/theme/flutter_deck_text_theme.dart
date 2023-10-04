import 'package:flutter/widgets.dart';

/// Defines the global text styles for a slide deck.
class FlutterDeckTextTheme {
  /// Creates a theme to style text in a slide deck.
  const FlutterDeckTextTheme({
    this.display = const TextStyle(
      fontSize: 91,
      fontWeight: FontWeight.bold,
    ),
    this.header = const TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
    ),
    this.title = const TextStyle(
      fontSize: 54,
      fontWeight: FontWeight.w400,
    ),
    this.subtitle = const TextStyle(
      fontSize: 42,
      fontWeight: FontWeight.w400,
    ),
    this.bodyLarge = const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
    ),
    this.bodyMedium = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
    ),
    this.bodySmall = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  });

  /// Text style of the header.
  ///
  /// By default, the text size is 112, and the font weight is 400.
  final TextStyle display;

  /// Text style of the header.
  ///
  /// By default, the text size is 57, and the font weight is 400.
  final TextStyle header;

  /// Text style of the title.
  ///
  /// By default, the text size is 54, and the font weight is 400.
  final TextStyle title;

  /// Text style of the subtitle.
  ///
  /// By default, the text size is 42, and the font weight is 400.
  final TextStyle subtitle;

  /// Text style of the body (large).
  ///
  /// By default, the text size is 28, and the font weight is 400.
  final TextStyle bodyLarge;

  /// Text style of the body (medium).
  ///
  /// By default, the text size is 22, and the font weight is 400.
  final TextStyle bodyMedium;

  /// Text style of the body (small).
  ///
  /// By default, the text size is 16, and the font weight is 400.
  final TextStyle bodySmall;

  /// Creates a copy of this object with the given fields replaced with the new
  /// values.
  FlutterDeckTextTheme copyWith({
    TextStyle? display,
    TextStyle? header,
    TextStyle? title,
    TextStyle? subtitle,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? footnote,
  }) =>
      FlutterDeckTextTheme(
        display: display ?? this.display,
        header: header ?? this.header,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        bodyLarge: bodyLarge ?? this.bodyLarge,
        bodyMedium: bodyMedium ?? this.bodyMedium,
        bodySmall: bodySmall ?? this.bodySmall,
      );

  /// Merge the given [FlutterDeckTextTheme] with this one.
  FlutterDeckTextTheme merge(FlutterDeckTextTheme? other) {
    if (other == null) return this;

    return copyWith(
      display: display.merge(other.display),
      header: header.merge(other.header),
      title: title.merge(other.title),
      subtitle: subtitle.merge(other.subtitle),
      bodyLarge: bodyLarge.merge(other.bodyLarge),
      bodyMedium: bodyMedium.merge(other.bodyMedium),
      bodySmall: bodySmall.merge(other.bodySmall),
    );
  }

  /// Creates a copy of this object replacing or altering the specified
  /// properties.
  FlutterDeckTextTheme apply({Color? color}) {
    return copyWith(
      display: display.apply(color: color),
      header: header.apply(color: color),
      title: title.apply(color: color),
      subtitle: subtitle.apply(color: color),
      bodyLarge: bodyLarge.apply(color: color),
      bodyMedium: bodyMedium.apply(color: color),
      bodySmall: bodySmall.apply(color: color),
    );
  }
}
