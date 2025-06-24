import 'package:meta/meta.dart';

/// Represents the state of a flutter_deck presentation.
///
/// This class is a single source of truth for the state of a flutter_deck
/// presentation. It is used by both the presentation and the presenter view to
/// keep the state in sync.
@immutable
class FlutterDeckState {
  /// Creates a new [FlutterDeckState] with the given parameters.
  ///
  /// The [locale] and [themeMode] parameters are required.
  ///
  /// The [markerEnabled], [slideIndex], and [slideStep] parameters are
  /// optional.
  const FlutterDeckState({
    required this.locale,
    required this.themeMode,
    this.markerEnabled = false,
    this.slideIndex = 0,
    this.slideStep = 1,
  });

  /// Creates a new [FlutterDeckState] from a JSON object.
  FlutterDeckState.fromJson(Map<String, dynamic> json)
    : locale = json['locale'] as String,
      markerEnabled = json['markerEnabled'] as bool,
      slideIndex = json['slideIndex'] as int,
      slideStep = json['slideStep'] as int,
      themeMode = json['themeMode'] as String;

  /// Converts this [FlutterDeckState] to a JSON object.
  Map<String, dynamic> toJson() => {
    'locale': locale,
    'markerEnabled': markerEnabled,
    'slideIndex': slideIndex,
    'slideStep': slideStep,
    'themeMode': themeMode,
  };

  /// The locale of the presentation.
  final String locale;

  /// Whether the marker is enabled.
  final bool markerEnabled;

  /// The index of the current slide.
  final int slideIndex;

  /// The step of the current slide.
  final int slideStep;

  /// The theme mode of the presentation.
  final String themeMode;

  /// Creates a copy of this [FlutterDeckState] with the given parameters
  FlutterDeckState copyWith({String? locale, bool? markerEnabled, int? slideIndex, int? slideStep, String? themeMode}) {
    return FlutterDeckState(
      locale: locale ?? this.locale,
      markerEnabled: markerEnabled ?? this.markerEnabled,
      slideIndex: slideIndex ?? this.slideIndex,
      slideStep: slideStep ?? this.slideStep,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  /// Overrides the equality operator to compare two [FlutterDeckState] objects.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlutterDeckState &&
        other.locale == locale &&
        other.markerEnabled == markerEnabled &&
        other.slideIndex == slideIndex &&
        other.slideStep == slideStep &&
        other.themeMode == themeMode;
  }

  /// Overrides the hash code getter to return the hash code of this object.
  @override
  int get hashCode =>
      locale.hashCode ^ markerEnabled.hashCode ^ slideIndex.hashCode ^ slideStep.hashCode ^ themeMode.hashCode;
}
