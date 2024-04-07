import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/flutter_deck_slide.dart';
import 'package:flutter_deck/src/flutter_deck_speaker_info.dart';
import 'package:flutter_deck/src/theme/widgets/flutter_deck_speaker_info_widget_theme.dart';

const _imageHeight = 160.0;

/// A widget that displays the provided speaker info.
///
/// This widget is used by default to render speaker information in the
/// [FlutterDeckSlide.title] slide.
class FlutterDeckSpeakerInfoWidget extends StatelessWidget {
  /// Creates a new speaker info widget.
  ///
  /// The [speakerInfo] argument must not be null.
  const FlutterDeckSpeakerInfoWidget({
    required this.speakerInfo,
    super.key,
  });

  /// The speaker info to display.
  final FlutterDeckSpeakerInfo speakerInfo;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckSpeakerInfoWidgetTheme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          speakerInfo.imagePath,
          height: _imageHeight,
          width: _imageHeight,
        ),
        const SizedBox(width: 32),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              speakerInfo.name,
              style: theme.nameTextStyle,
              maxLines: 1,
            ),
            AutoSizeText(
              speakerInfo.description,
              style: theme.descriptionTextStyle,
              maxLines: 1,
            ),
            AutoSizeText(
              speakerInfo.socialHandle,
              style: theme.socialHandleTextStyle,
              maxLines: 1,
            ),
          ],
        ),
      ],
    );
  }
}
