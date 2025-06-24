import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';
import 'package:flutter_deck/src/widgets/flutter_deck_footer.dart';

/// Defines the visual properties of [FlutterDeckFooter].
///
/// Used by [FlutterDeckFooterTheme] to control the visual properties of
/// the footer in a slide deck.
///
/// To obtain the current [FlutterDeckFooterThemeData], use
/// [FlutterDeckFooterTheme.of] to access the closest ancestor
/// [FlutterDeckFooterTheme] of the current [BuildContext].
///
/// See also:
///
/// * [FlutterDeckFooterTheme], an [InheritedWidget] that propagates the
/// theme down its subtree.
/// * [FlutterDeckTheme], which describes the overall theme information for the
/// slide deck.
class FlutterDeckFooterThemeData {
  /// Creates a theme to style [FlutterDeckFooter].
  const FlutterDeckFooterThemeData({
    this.slideNumberColor,
    this.slideNumberTextStyle,
    this.socialHandleColor,
    this.socialHandleTextStyle,
  });

  /// Color of the slide number.
  final Color? slideNumberColor;

  /// Text style of the slide number.
  final TextStyle? slideNumberTextStyle;

  /// Color of the social handle.
  final Color? socialHandleColor;

  /// Text style of the social handle.
  final TextStyle? socialHandleTextStyle;

  /// Creates a copy of this object with the given fields replaced with the new
  /// values.
  FlutterDeckFooterThemeData copyWith({
    Color? slideNumberColor,
    TextStyle? slideNumberTextStyle,
    Color? socialHandleColor,
    TextStyle? socialHandleTextStyle,
  }) {
    return FlutterDeckFooterThemeData(
      slideNumberColor: slideNumberColor ?? this.slideNumberColor,
      slideNumberTextStyle: slideNumberTextStyle ?? this.slideNumberTextStyle,
      socialHandleColor: socialHandleColor ?? this.socialHandleColor,
      socialHandleTextStyle: socialHandleTextStyle ?? this.socialHandleTextStyle,
    );
  }

  /// Merge the given [FlutterDeckFooterThemeData] with this one.
  FlutterDeckFooterThemeData merge(FlutterDeckFooterThemeData? other) {
    if (other == null) return this;

    return copyWith(
      slideNumberColor: other.slideNumberColor,
      slideNumberTextStyle: slideNumberTextStyle?.merge(other.slideNumberTextStyle) ?? other.slideNumberTextStyle,
      socialHandleColor: other.socialHandleColor,
      socialHandleTextStyle: socialHandleTextStyle?.merge(other.socialHandleTextStyle) ?? other.socialHandleTextStyle,
    );
  }
}

/// An inherited widget that defines the visual properties of
/// [FlutterDeckFooter].
///
/// Used by [FlutterDeckFooter] to control the visual properties of the footer
/// in a slide deck.
class FlutterDeckFooterTheme extends InheritedTheme {
  /// Creates a theme to style [FlutterDeckFooter].
  ///
  /// The [data] argument must not be null.
  const FlutterDeckFooterTheme({required this.data, required super.child, super.key});

  /// The visual properties of [FlutterDeckFooter].
  final FlutterDeckFooterThemeData data;

  /// Returns the [data] from the closest [FlutterDeckFooterTheme] ancestor.
  /// If there is no ancestor, it returns [FlutterDeckThemeData.footerTheme].
  ///
  /// The returned theme data will never be null.
  static FlutterDeckFooterThemeData of(BuildContext context) {
    final theme = context.dependOnInheritedWidgetOfExactType<FlutterDeckFooterTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).footerTheme;
  }

  @override
  bool updateShouldNotify(FlutterDeckFooterTheme oldWidget) => data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) => FlutterDeckFooterTheme(data: data, child: child);
}
