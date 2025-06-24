import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_deck/src/widgets/flutter_deck_speaker_info_widget.dart';

/// Defines the visual properties of [FlutterDeckSpeakerInfoWidget].
///
/// Used by [FlutterDeckSpeakerInfoWidgetTheme] to control the visual properties
/// of the speaker info widget in a slide deck.
///
/// To obtain the current [FlutterDeckSpeakerInfoWidgetThemeData], use
/// [FlutterDeckSpeakerInfoWidgetTheme.of] to access the closest ancestor
/// [FlutterDeckSpeakerInfoWidgetTheme] of the current [BuildContext].
///
/// See also:
///
/// * [FlutterDeckSpeakerInfoWidgetTheme], an [InheritedWidget] that propagates
/// the theme down its subtree.
/// * [FlutterDeckTheme], which describes the overall theme information for the
/// slide deck.
class FlutterDeckSpeakerInfoWidgetThemeData {
  /// Creates a theme to style [FlutterDeckSpeakerInfoWidget].
  const FlutterDeckSpeakerInfoWidgetThemeData({
    this.descriptionTextStyle,
    this.nameTextStyle,
    this.socialHandleTextStyle,
  });

  /// Text style of the speaker description (title).
  final TextStyle? descriptionTextStyle;

  /// Text style of the speaker name.
  final TextStyle? nameTextStyle;

  /// Text style of the speaker social handle.
  final TextStyle? socialHandleTextStyle;

  /// Creates a copy of this object with the given fields replaced with the new
  /// values.
  FlutterDeckSpeakerInfoWidgetThemeData copyWith({
    TextStyle? descriptionTextStyle,
    TextStyle? nameTextStyle,
    TextStyle? socialHandleTextStyle,
  }) {
    return FlutterDeckSpeakerInfoWidgetThemeData(
      descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      nameTextStyle: nameTextStyle ?? this.nameTextStyle,
      socialHandleTextStyle: socialHandleTextStyle ?? this.socialHandleTextStyle,
    );
  }

  /// Merge the given [FlutterDeckSpeakerInfoWidgetThemeData] with this one.
  FlutterDeckSpeakerInfoWidgetThemeData merge(FlutterDeckSpeakerInfoWidgetThemeData? other) {
    if (other == null) return this;

    return copyWith(
      descriptionTextStyle: descriptionTextStyle?.merge(other.descriptionTextStyle) ?? other.descriptionTextStyle,
      nameTextStyle: nameTextStyle?.merge(other.nameTextStyle) ?? other.nameTextStyle,
      socialHandleTextStyle: socialHandleTextStyle?.merge(other.socialHandleTextStyle) ?? other.socialHandleTextStyle,
    );
  }
}

/// An inherited widget that defines the visual properties of
/// [FlutterDeckSpeakerInfoWidget].
///
/// Used by [FlutterDeckSpeakerInfoWidget] to control the visual properties of
/// the speaker info widget in a slide deck.
class FlutterDeckSpeakerInfoWidgetTheme extends InheritedTheme {
  /// Creates a theme to style [FlutterDeckSpeakerInfoWidget].
  ///
  /// The [data] argument must not be null.
  const FlutterDeckSpeakerInfoWidgetTheme({required this.data, required super.child, super.key});

  /// The visual properties of [FlutterDeckSpeakerInfoWidget].
  final FlutterDeckSpeakerInfoWidgetThemeData data;

  /// Returns the [data] from the closest [FlutterDeckSpeakerInfoWidgetTheme]
  /// ancestor. If there is no ancestor, it returns
  /// [FlutterDeckThemeData.speakerInfoWidgetTheme].
  ///
  /// The returned theme data will never be null.
  static FlutterDeckSpeakerInfoWidgetThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<FlutterDeckSpeakerInfoWidgetTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).speakerInfoWidgetTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckSpeakerInfoWidgetTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) => FlutterDeckSpeakerInfoWidgetTheme(data: data, child: child);
}
