import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/default.dart';
import 'package:flutter_highlight/themes/vs2015.dart';

/// This widget provides syntax highlighting for many languages.
class FlutterDeckCodeHighlight extends StatelessWidget {
  /// Creates a syntax highlighting widget for displaying code.
  const FlutterDeckCodeHighlight({
    required String code,
    super.key,
    String? fileName,
    String language = 'dart',
  })  : _code = code,
        _fileName = fileName,
        _language = language;
  final String _code;
  final String? _fileName;
  final String _language;

  @override
  Widget build(BuildContext context) => DecoratedBox(
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
              if (_fileName != null) Text(_fileName!),
              HighlightView(
                _code,
                language: _language,
                padding: const EdgeInsets.all(16),
                theme: Theme.of(context).brightness == Brightness.dark
                    ? vs2015Theme
                    : defaultTheme,
              ),
            ],
          ),
        ),
      );
}
