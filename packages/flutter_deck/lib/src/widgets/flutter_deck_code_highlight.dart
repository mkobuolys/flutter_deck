import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

const _dimmedCodeOpacity = 0.3;
const _dimCodeDuration = Duration(milliseconds: 500);

/// This widget provides syntax highlighting for many languages and line
/// highlighting transitions.
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
///     highlightedLines: [1, 2],
///   ),
/// );
/// ```
class FlutterDeckCodeHighlight extends StatefulWidget {
  /// Creates a syntax highlighting widget for displaying code.
  ///
  /// Will use the dark or light theme from `syntax_highlight` based on the
  /// current [ThemeData.brightness].
  ///
  /// For a list of all available [language] values, see the `syntax_highlight`
  /// package.
  ///
  /// Provide [highlightedLines] via 0-indexed line numbers to emphasize certain
  /// lines while dimming the rest.
  const FlutterDeckCodeHighlight({
    required this.code,
    this.language = 'dart',
    this.fileName,
    this.textStyle,
    this.highlightedLines = const [],
    this.animateHighlightedLines = true,
    super.key,
  });

  /// The code to display.
  final String code;

  /// The language to use for syntax highlighting. Defaults to 'dart'.
  final String language;

  /// Optional file name to display above the code snippet.
  final String? fileName;

  /// The text style to use for the code. Defaults to the default style of the
  /// build context.
  final TextStyle? textStyle;

  /// The zero-indexed lines to highlight. Remaining lines will be dimmed.
  final List<int> highlightedLines;

  /// Whether to animate the dimming of non-highlighted lines. Defaults to true.
  final bool animateHighlightedLines;

  @override
  State<FlutterDeckCodeHighlight> createState() => _FlutterDeckCodeHighlightState();
}

class _FlutterDeckCodeHighlightState extends State<FlutterDeckCodeHighlight> with SingleTickerProviderStateMixin {
  late AnimationController _highlightController;

  Highlighter? _highlighter;

  @override
  void initState() {
    super.initState();
    _initHighlighter();

    _highlightController = AnimationController(vsync: this, value: 1);
    _highlightController.addListener(() {
      setState(() {});
    });

    if (widget.highlightedLines.isNotEmpty) {
      if (widget.animateHighlightedLines) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _highlightController.animateTo(_dimmedCodeOpacity, duration: _dimCodeDuration);
        });
      } else {
        _highlightController.value = _dimmedCodeOpacity;
      }
    }
  }

  @override
  void didUpdateWidget(covariant FlutterDeckCodeHighlight oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.language != widget.language) {
      _initHighlighter();
    }

    if (oldWidget.highlightedLines != widget.highlightedLines || oldWidget.code != widget.code) {
      _highlightController.value = 1.0;
      if (widget.highlightedLines.isNotEmpty) {
        if (widget.animateHighlightedLines) {
          _highlightController.animateTo(_dimmedCodeOpacity, duration: _dimCodeDuration);
        } else {
          _highlightController.value = _dimmedCodeOpacity;
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Re-initialize theme if brightness changes
    _initHighlighter();
  }

  Future<void> _initHighlighter() async {
    await Highlighter.initialize([widget.language]);
    if (!mounted) return;

    final brightness = Theme.of(context).brightness;
    final theme = brightness == Brightness.dark
        ? await HighlighterTheme.loadDarkTheme()
        : await HighlighterTheme.loadLightTheme();

    if (!mounted) return;

    setState(() {
      _highlighter = Highlighter(language: widget.language, theme: theme);
    });
  }

  @override
  void dispose() {
    _highlightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final codeTheme = FlutterDeckCodeHighlightTheme.of(context);
    final textStyle = widget.textStyle == null || widget.textStyle!.inherit
        ? codeTheme.textStyle?.merge(widget.textStyle) ?? widget.textStyle
        : widget.textStyle;

    // Default text style for measuring layout and line heights
    final defaultTextStyle = textStyle ?? FlutterDeckTheme.of(context).textTheme.bodyMedium;

    final animatedCode = widget.code;

    Widget content;
    if (_highlighter == null) {
      // Still loading the highlighter/theme
      content = Text(animatedCode, style: defaultTextStyle);
    } else {
      final highlightedText = _highlighter!.highlight(animatedCode);
      final coloredCode = Text.rich(highlightedText, style: defaultTextStyle);

      if (widget.highlightedLines.isEmpty) {
        content = coloredCode;
      } else {
        final numLines = animatedCode.split('\n').length;
        final fadedColoredCode = Text.rich(highlightedText, style: defaultTextStyle);

        content = Stack(
          children: [
            ClipPath(
              clipper: _HighlightedLinesClipper(
                numLines: numLines,
                highlightedLines: widget.highlightedLines,
                invert: false,
              ),
              child: coloredCode,
            ),
            Opacity(
              opacity: _highlightController.value,
              child: ClipPath(
                clipper: _HighlightedLinesClipper(
                  numLines: numLines,
                  highlightedLines: widget.highlightedLines,
                  invert: true,
                ),
                child: fadedColoredCode,
              ),
            ),
          ],
        );
      }
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: codeTheme.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.fileName != null) ...[Text(widget.fileName!, style: textStyle), const SizedBox(height: 8)],
            content,
          ],
        ),
      ),
    );
  }
}

class _HighlightedLinesClipper extends CustomClipper<Path> {
  _HighlightedLinesClipper({required this.numLines, required this.highlightedLines, required this.invert});

  final int numLines;
  final List<int> highlightedLines;
  final bool invert;

  @override
  Path getClip(Size size) {
    final path = Path();
    final lineHeight = size.height / numLines;
    for (var i = 0; i < numLines; i++) {
      if (highlightedLines.contains(i) != invert) {
        final y = i * lineHeight;
        path.addRect(Rect.fromLTWH(0, y, size.width, lineHeight));
      }
    }
    return path;
  }

  @override
  bool shouldReclip(_HighlightedLinesClipper oldClipper) {
    return oldClipper.highlightedLines != highlightedLines ||
        oldClipper.numLines != numLines ||
        oldClipper.invert != invert;
  }
}
