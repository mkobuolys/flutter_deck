import 'package:flutter/widgets.dart';

///
class FlutterDeckTextTheme {
  ///
  const FlutterDeckTextTheme({
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

  ///
  final TextStyle header;

  ///
  final TextStyle title;

  ///
  final TextStyle subtitle;

  ///
  final TextStyle bodyLarge;

  ///
  final TextStyle bodyMedium;

  ///
  final TextStyle bodySmall;

  ///
  FlutterDeckTextTheme copyWith({
    TextStyle? header,
    TextStyle? title,
    TextStyle? subtitle,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? footnote,
  }) =>
      FlutterDeckTextTheme(
        header: header ?? this.header,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        bodyLarge: bodyLarge ?? this.bodyLarge,
        bodyMedium: bodyMedium ?? this.bodyMedium,
        bodySmall: bodySmall ?? this.bodySmall,
      );

  ///
  FlutterDeckTextTheme merge(FlutterDeckTextTheme? other) {
    if (other == null) return this;

    return copyWith(
      header: header.merge(other.header),
      title: title.merge(other.title),
      subtitle: subtitle.merge(other.subtitle),
      bodyLarge: bodyLarge.merge(other.bodyLarge),
      bodyMedium: bodyMedium.merge(other.bodyMedium),
      bodySmall: bodySmall.merge(other.bodySmall),
    );
  }

  ///
  FlutterDeckTextTheme apply({Color? color}) {
    return copyWith(
      header: header.apply(color: color),
      title: title.apply(color: color),
      subtitle: subtitle.apply(color: color),
      bodyLarge: bodyLarge.apply(color: color),
      bodyMedium: bodyMedium.apply(color: color),
      bodySmall: bodySmall.apply(color: color),
    );
  }
}
