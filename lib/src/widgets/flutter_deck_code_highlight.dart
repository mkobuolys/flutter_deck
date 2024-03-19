import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck/src/theme/widgets/flutter_deck_code_highlight_theme.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/default.dart';
import 'package:flutter_highlight/themes/vs2015.dart';

/// This widget provides syntax highlighting for many languages.
///
/// To customize the style of the widget, use [FlutterDeckCodeHighlightTheme].
///
/// Example:
///
/// ```dart
/// FlutterDeckCodeHighlightTheme(
///   data: FlutterDeckCodeHighlightThemeData(
///     backgroundColor: Colors.black87,
///     textStyle: FlutterDeckTheme.of(context).textTheme.bodyMedium,
///   ),
///   child: const FlutterDeckCodeHighlight(
///     code: '<...>',
///     fileName: 'example.dart',
///     language: 'dart',
///   ),
/// );
/// ```
class FlutterDeckCodeHighlight extends StatelessWidget {
  /// Creates a syntax highlighting widget for displaying code.
  ///
  /// Will use [vs2015Theme] for dark theme and [defaultTheme] for light theme.
  ///
  /// For a list of all available [language] values, see:
  /// https://github.com/git-touch/highlight.dart/tree/master/highlight/lib/languages
  const FlutterDeckCodeHighlight({
    required String code,
    super.key,
    String? fileName,
    String language = 'dart',
    TextStyle? textStyle,
  })  : _code = code,
        _fileName = fileName,
        _language = language,
        _textStyle = textStyle;

  final String _code;
  final String? _fileName;
  final String _language;
  final TextStyle? _textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = FlutterDeckCodeHighlightTheme.of(context);

    var effectiveTextStyle = _textStyle;
    if (_textStyle == null || (_textStyle?.inherit ?? false)) {
      effectiveTextStyle = theme.textStyle?.merge(_textStyle) ?? _textStyle;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_fileName != null) ...[
              Text(
                _fileName!,
                style: effectiveTextStyle,
              ),
              const SizedBox(height: 4),
            ],
            HighlightView(
              _code,
              language: _language,
              padding: const EdgeInsets.all(16),
              textStyle: effectiveTextStyle,
              theme: Theme.of(context).brightness == Brightness.dark
                  ? vs2015Theme
                  : defaultTheme,
            ),
          ],
        ),
      ),
    );
  }
}
