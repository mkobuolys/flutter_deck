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
  /// Use [textStyle] to set custom font size and other text style properties
  /// for the root theme.
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
              Text(
                _fileName!,
                style: _textStyle,
              ),
              const SizedBox(height: 4),
            ],
            HighlightView(
              _code,
              language: _language,
              padding: const EdgeInsets.all(16),
              textStyle: _textStyle,
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
