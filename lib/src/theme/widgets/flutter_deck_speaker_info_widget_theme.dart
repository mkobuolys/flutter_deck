import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

///
class FlutterDeckSpeakerInfoWidgetThemeData {
  ///
  const FlutterDeckSpeakerInfoWidgetThemeData({
    this.descriptionTextStyle,
    this.nameTextStyle,
    this.socialHandleTextStyle,
  });

  ///
  final TextStyle? descriptionTextStyle;

  ///
  final TextStyle? nameTextStyle;

  ///
  final TextStyle? socialHandleTextStyle;

  ///
  FlutterDeckSpeakerInfoWidgetThemeData copyWith({
    TextStyle? descriptionTextStyle,
    TextStyle? nameTextStyle,
    TextStyle? socialHandleTextStyle,
  }) {
    return FlutterDeckSpeakerInfoWidgetThemeData(
      descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      nameTextStyle: nameTextStyle ?? this.nameTextStyle,
      socialHandleTextStyle:
          socialHandleTextStyle ?? this.socialHandleTextStyle,
    );
  }

  ///
  FlutterDeckSpeakerInfoWidgetThemeData merge(
    FlutterDeckSpeakerInfoWidgetThemeData? other,
  ) {
    if (other == null) return this;

    return copyWith(
      descriptionTextStyle:
          descriptionTextStyle?.merge(other.descriptionTextStyle) ??
              other.descriptionTextStyle,
      nameTextStyle:
          nameTextStyle?.merge(other.nameTextStyle) ?? other.nameTextStyle,
      socialHandleTextStyle:
          socialHandleTextStyle?.merge(other.socialHandleTextStyle) ??
              other.socialHandleTextStyle,
    );
  }
}

///
class FlutterDeckSpeakerInfoWidgetTheme extends InheritedTheme {
  ///
  const FlutterDeckSpeakerInfoWidgetTheme({
    required this.data,
    required super.child,
    super.key,
  });

  ///
  final FlutterDeckSpeakerInfoWidgetThemeData data;

  ///
  static FlutterDeckSpeakerInfoWidgetThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<
        FlutterDeckSpeakerInfoWidgetTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).speakerInfoWidgetTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckSpeakerInfoWidgetTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      FlutterDeckSpeakerInfoWidgetTheme(data: data, child: child);
}
