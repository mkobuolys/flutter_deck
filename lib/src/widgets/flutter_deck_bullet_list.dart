import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/src/theme/widgets/flutter_deck_bullet_list_theme.dart';
import 'package:flutter_deck/src/widgets/widgets.dart';

/// A widget that renders a list of bullet points.
///
/// Bullet point [items] are rendered as a row with a bullet point and the text.
/// The bullet point is rendered as a dot by default, but can be customized by
/// providing a [bulletPointWidget]. The text is rendered as an [AutoSizeText]
/// widget and is automatically resized to fit the available space.
///
/// If [useSteps] is true, the bullet points will be rendered one by one as the
/// user steps through the slide. To use this feature, define the number of
/// steps in the slide configuration.
///
/// Example:
///
/// ```dart
/// import 'package:flutter/material.dart';
/// import 'package:flutter_deck/flutter_deck.dart';
///
/// class BulletListSlide extends FlutterDeckSlideWidget {
///   const BulletListSlide()
///       : super(
///           configuration: const FlutterDeckSlideConfiguration(
///             route: '/bullet-list',
///             steps: 3,
///           ),
///         );
///
///   @override
///   FlutterDeckSlide build(BuildContext context) {
///     return FlutterDeckSlide.custom(
///       builder: (context) => FlutterDeckBulletList(
///         useSteps: true,
///         items: const [
///           'Bullet point 1',
///           'Bullet point 2',
///           'Bullet point 3',
///         ],
///       ),
///     );
///   }
/// }
/// ```
class FlutterDeckBulletList extends StatefulWidget {
  /// Creates a widget that renders a list of bullet points.
  ///
  /// Bullet point [items] are rendered as a row with a bullet point and the
  /// text. The bullet point is rendered as a dot by default, but can be
  /// customized by providing a [bulletPointWidget].
  ///
  /// If [useSteps] is true, the bullet points will be rendered one by one as
  /// the user steps through the slide. By default, it is false.
  ///
  /// At least one bullet point must be provided.
  FlutterDeckBulletList({
    this.items = const [],
    this.useSteps = false,
    this.bulletPointWidget,
    super.key,
  }) : assert(items.isNotEmpty, 'You must provide at least one bullet point.');

  /// A list of bullet points.
  final List<String> items;

  /// Whether to render the bullet points one by one as the user steps through
  /// the slide.
  final bool useSteps;

  /// A widget to use as the bullet point. If not provided, a dot will be used.
  final Widget? bulletPointWidget;

  @override
  State<FlutterDeckBulletList> createState() => _FlutterDeckBulletListState();
}

class _FlutterDeckBulletListState extends State<FlutterDeckBulletList> {
  final _autoSizeGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    if (!widget.useSteps) {
      return _BulletList(
        items: widget.items,
        autoSizeGroup: _autoSizeGroup,
        bulletPointWidget: widget.bulletPointWidget,
      );
    }

    return FlutterDeckSlideStepsBuilder(
      builder: (context, stepNumber) => _BulletList(
        items: widget.items,
        autoSizeGroup: _autoSizeGroup,
        bulletPointWidget: widget.bulletPointWidget,
        stepNumber: stepNumber,
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({
    required this.items,
    required this.autoSizeGroup,
    this.bulletPointWidget,
    this.stepNumber,
  });

  final List<String> items;
  final AutoSizeGroup autoSizeGroup;
  final Widget? bulletPointWidget;
  final int? stepNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < items.length; i++)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _BulletListItem(
                group: autoSizeGroup,
                text: items[i],
                visible: stepNumber == null ||
                    stepNumber != null && i + 1 <= stepNumber!,
                bulletPointWidget: bulletPointWidget,
              ),
            ),
          ),
      ],
    );
  }
}

class _BulletListItem extends StatelessWidget {
  const _BulletListItem({
    required this.group,
    required this.text,
    required this.visible,
    this.bulletPointWidget,
  });

  final AutoSizeGroup group;
  final String text;
  final bool visible;
  final Widget? bulletPointWidget;

  @override
  Widget build(BuildContext context) {
    return Visibility.maintain(
      visible: visible,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bulletPointWidget ?? _AutoSizeText('\u2022', group: group),
          const SizedBox(width: 8),
          Expanded(
            child: _AutoSizeText(text, group: group),
          ),
        ],
      ),
    );
  }
}

class _AutoSizeText extends StatelessWidget {
  const _AutoSizeText(
    this.text, {
    required this.group,
  });

  final AutoSizeGroup group;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckBulletListTheme.of(context);
    final textStyle = theme.textStyle;

    return AutoSizeText(
      text,
      group: group,
      style: textStyle?.copyWith(color: theme.color),
      maxFontSize: textStyle?.fontSize ?? double.infinity,
    );
  }
}
