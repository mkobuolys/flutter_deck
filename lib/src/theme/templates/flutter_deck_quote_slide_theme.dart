import 'package:flutter/widgets.dart';
import 'package:flutter_deck/src/templates/quote_slide.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

/// Defines the visual properties of [FlutterDeckQuoteSlide].
///
/// Used by [FlutterDeckQuoteSlideTheme] to control the visual properties of
/// slides in a deck.
///
/// To obtain the current [FlutterDeckQuoteSlideThemeData], use
/// [FlutterDeckQuoteSlideTheme.of] to access the closest ancestor
/// [FlutterDeckQuoteSlideTheme] of the current [BuildContext].
///
/// See also:
///
/// * [FlutterDeckQuoteSlideTheme], an [InheritedWidget] that propagates the
/// theme down its subtree.
/// * [FlutterDeckTheme], which describes the overall theme information for the
/// slide deck.
class FlutterDeckQuoteSlideThemeData {
  /// Creates a theme to style [FlutterDeckQuoteSlide].
  const FlutterDeckQuoteSlideThemeData({
    this.attributionTextStyle,
    this.quoteTextStyle,
  });

  /// Text style for the attribution of the quote.
  final TextStyle? attributionTextStyle;

  /// Text style for the quote.
  final TextStyle? quoteTextStyle;

  /// Creates a copy of this object with the given fields replaced with the new
  /// values.
  FlutterDeckQuoteSlideThemeData copyWith({
    TextStyle? attributionTextStyle,
    TextStyle? quoteTextStyle,
  }) {
    return FlutterDeckQuoteSlideThemeData(
      attributionTextStyle: attributionTextStyle ?? this.attributionTextStyle,
      quoteTextStyle: quoteTextStyle ?? this.quoteTextStyle,
    );
  }

  /// Merge the given [FlutterDeckQuoteSlideThemeData] with this one.
  FlutterDeckQuoteSlideThemeData merge(FlutterDeckQuoteSlideThemeData? other) {
    if (other == null) return this;

    return copyWith(
      attributionTextStyle:
          attributionTextStyle?.merge(other.attributionTextStyle) ??
              other.attributionTextStyle,
      quoteTextStyle:
          quoteTextStyle?.merge(other.quoteTextStyle) ?? other.quoteTextStyle,
    );
  }
}

/// An inherited widget that defines the visual properties of
/// [FlutterDeckQuoteSlide].
///
/// Used by [FlutterDeckQuoteSlide] to control the visual properties of slides
/// in the slide deck.
class FlutterDeckQuoteSlideTheme extends InheritedTheme {
  /// Creates a theme to style [FlutterDeckQuoteSlide].
  ///
  /// The [data] argument must not be null.
  const FlutterDeckQuoteSlideTheme({
    required this.data,
    required super.child,
    super.key,
  });

  /// The visual properties of [FlutterDeckQuoteSlide].
  final FlutterDeckQuoteSlideThemeData data;

  /// Returns the [data] from the closest [FlutterDeckQuoteSlideTheme]
  /// ancestor.
  ///
  /// If there is no ancestor, it returns
  /// [FlutterDeckThemeData.quoteSlideTheme].
  ///
  /// The returned theme data will never be null.
  static FlutterDeckQuoteSlideThemeData of(BuildContext context) {
    final theme = context
        .dependOnInheritedWidgetOfExactType<FlutterDeckQuoteSlideTheme>();

    return theme?.data ?? FlutterDeckTheme.of(context).quoteSlideTheme;
  }

  @override
  bool updateShouldNotify(covariant FlutterDeckQuoteSlideTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) =>
      FlutterDeckQuoteSlideTheme(data: data, child: child);
}
