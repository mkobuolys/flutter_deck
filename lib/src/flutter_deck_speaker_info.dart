import 'package:flutter/widgets.dart';

/// Stores information about the speaker.
class FlutterDeckSpeakerInfo {
  /// Creates a new [FlutterDeckSpeakerInfo] instance.
  ///
  /// [name], [description], [socialHandle], and [imagePath] must not be null.
  const FlutterDeckSpeakerInfo({
    required this.name,
    required this.description,
    required this.socialHandle,
    required this.imagePath,
  });

  /// Full name of the speaker.
  final String name;

  /// Short description of the speaker (e.g. job title, company, etc.)
  final String description;

  /// Social media handle of the speaker (e.g. GitHub username, blog URL, etc.)
  final String socialHandle;

  /// Path to the speaker's image.
  ///
  /// This should be a path to an image asset in the app's assets directory.
  final String imagePath;
}

/// A function to build [FlutterDeckSpeakerInfo] instance using [BuildContext].
typedef FlutterDeckSpeakerInfoBuilder = FlutterDeckSpeakerInfo Function(
  BuildContext context,
);
