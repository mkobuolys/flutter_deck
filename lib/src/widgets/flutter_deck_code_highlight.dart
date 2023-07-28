import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/default.dart';
import 'package:flutter_highlight/themes/vs2015.dart';

/// This widget provides syntax highlighting for many languages.
class FlutterDeckCodeHighlight extends StatelessWidget {
  /// Creates a syntax highlighting widget for displaying code.
  ///
  /// Will use [vs2015Theme] for dark theme and [defaultTheme] for light theme.
  ///
  /// For a list of all available [language] values, see:
  /// https://github.com/git-touch/highlight.dart/tree/master/highlight/lib/languages
  ///
  /// For a list of all available [darkTextStyles] and [lightTextStyles]
  /// values, see:
  /// https://github.com/git-touch/highlight.dart/tree/master/flutter_highlight/lib/themes
  ///
  /// [textStyle] will be merged with all theme text styles.
  ///
  /// Use [darkTextStyles] and [lightTextStyles] to provide or override the
  /// whole theme.
  const FlutterDeckCodeHighlight({
    required String code,
    super.key,
    Map<String, TextStyle>? darkTextStyles,
    String? fileName,
    String language = 'dart',
    Map<String, TextStyle>? lightTextStyles,
    TextStyle? textStyle,
  })  : _code = code,
        _darkTextStyles = darkTextStyles,
        _fileName = fileName,
        _language = language,
        _lightTextStyles = lightTextStyles,
        _textStyle = textStyle;

  final String _code;
  final Map<String, TextStyle>? _darkTextStyles;
  final String? _fileName;
  final String _language;
  final Map<String, TextStyle>? _lightTextStyles;
  final TextStyle? _textStyle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_fileName != null) ...[
              Text(_fileName!),
              const SizedBox(height: 4),
            ],
            HighlightView(
              _code,
              language: _language,
              padding: const EdgeInsets.all(16),
              theme: (Theme.of(context).brightness == Brightness.dark
                      ? _darkTextStyles ?? vs2015Theme
                      : _lightTextStyles ?? defaultTheme)
                  .map(
                (key, value) => MapEntry(
                  key,
                  value.merge(_textStyle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
