import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_deck/src/widgets/flutter_deck_bullet_list.dart';

/// Defines the visual properties of [FlutterDeckBulletList].
///
/// Used by [FlutterDeckBulletListTheme] to control the visual properties of
/// bullet lists in a deck.
///
/// To obtain the current [FlutterDeckBulletListThemeData], use
/// [FlutterDeckBulletListTheme.of] to access the closest ancestor
/// [FlutterDeckBulletListTheme] of the current [BuildContext].
///
/// See also:
///
/// * [FlutterDeckBulletListTheme], an [InheritedWidget] that propagates the
/// theme down its subtree.
/// * [FlutterDeckTheme], which describes the overall theme information for the
/// slide deck.
class FlutterDeckBulletListThemeData {
  /// Creates a theme to style [FlutterDeckBulletList].
  const FlutterDeckBulletListThemeData({
    this.color,
    this.textStyle,
  });

  /// Text color of the bullet list.
  final Color? color;

  /// Text style of the bullet list.
  final TextStyle? textStyle;

  /// Creates a copy of this object with the given fields replaced with the new
  /// values.
  FlutterDeckBulletListThemeData copyWith({
    Color? color,
    TextStyle? textStyle,
  }) {
    return FlutterDeckBulletListThemeData(
      color: color ?? this.color,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  /// Merge the given [FlutterDeckBulletListThemeData] with this one.
  FlutterDeckBulletListThemeData merge(FlutterDeckBulletListThemeData? other) {
    if (other == null) return this;

    return copyWith(
      color: other.color,
      textStyle: textStyle?.merge(other.textStyle) ?? other.textStyle,
    );
  }
}

/// An inherited widget that defines the visual properties of
/// [FlutterDeckBulletList].
///
/// Used by [FlutterDeckBulletList] to control the visual properties of
/// bullet lists in a deck.
class FlutterDeckBulletListTheme extends InheritedTheme {
  /// Creates a theme to style [FlutterDeckBulletList].
  ///
  /// The [data] argument must not be null.
  const FlutterDeckBulletListTheme({
    required this.data,
    required super.child,
    super.key,
  });

  /// The visual properties of [FlutterDeckBulletList].
  final FlutterDeckBulletListThemeData data;

  /// Returns the [data] from the closest [FlutterDeckBulletListTheme] ancestor.
  /// If there is no ancestor, it returns
  /// [FlutterDeckThemeData.bulletListTheme].
  ///
  /// The returned theme data will never be null.
  static FlutterDeckBulletListThemeData of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<FlutterDeckBulletListTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).bulletListTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckBulletListTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      FlutterDeckBulletListTheme(data: data, child: child);
}
