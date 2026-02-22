import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class _Token {
  const _Token(this.char, this.style);
  final String char;
  final TextStyle? style;
}

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

class _FlutterDeckCodeHighlightState extends State<FlutterDeckCodeHighlight> with TickerProviderStateMixin {
  late AnimationController _highlightController;
  late AnimationController _transitionController;

  Highlighter? _highlighter;
  String? _animateFromCode;
  List<Diff>? _diff;
  List<_Token> _oldTokens = [];
  List<_Token> _newTokens = [];

  @override
  void initState() {
    super.initState();
    _initHighlighter();

    _transitionController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _highlightController = AnimationController(vsync: this, value: 1);

    _transitionController.addListener(() {
      setState(() {});
    });

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

    if (oldWidget.code != widget.code) {
      _animateFromCode = oldWidget.code;
      _diff = DiffMatchPatch().diff(_animateFromCode!, widget.code);
      DiffMatchPatch().diffCleanupSemantic(_diff!);

      _updateTokens();
      _transitionController.forward(from: 0);
    }

    if (oldWidget.highlightedLines != widget.highlightedLines) {
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
      _updateTokens();
    });
  }

  void _updateTokens() {
    if (_highlighter == null) return;

    if (_animateFromCode != null) {
      final oldSpan = _highlighter!.highlight(_animateFromCode!);
      _oldTokens = _getTokens(oldSpan);
    }

    final newSpan = _highlighter!.highlight(widget.code);
    _newTokens = _getTokens(newSpan);
  }

  List<_Token> _getTokens(TextSpan span) {
    final tokens = <_Token>[];
    void visit(InlineSpan s, TextStyle? parentStyle) {
      final style = s.style == null
          ? parentStyle
          : s.style!.inherit
          ? parentStyle?.merge(s.style) ?? s.style
          : s.style;
      if (s is TextSpan) {
        if (s.text != null) {
          for (var i = 0; i < s.text!.length; i++) {
            tokens.add(_Token(s.text![i], style));
          }
        }
        if (s.children != null) {
          for (final child in s.children!) {
            visit(child, style);
          }
        }
      }
    }

    visit(span, null);
    return tokens;
  }

  @override
  void dispose() {
    _highlightController.dispose();
    _transitionController.dispose();
    super.dispose();
  }

  List<InlineSpan> _buildAnimatedSpans(TextStyle defaultTextStyle) {
    if (_diff == null || _transitionController.value == 1.0) {
      return _buildStaticSpans(_newTokens, defaultTextStyle);
    }

    final spans = <InlineSpan>[];
    var oldIdx = 0;
    var newIdx = 0;
    final t = _transitionController.value;

    InlineSpan buildTransitionSpan(List<_Token> tokens, double factor) {
      return WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: factor,
            child: Opacity(
              opacity: factor,
              child: Text.rich(TextSpan(children: _buildStaticSpans(tokens, defaultTextStyle))),
            ),
          ),
        ),
      );
    }

    for (final diff in _diff!) {
      if (diff.operation == DIFF_EQUAL) {
        final length = diff.text.length;
        final chunk = _newTokens.sublist(newIdx, newIdx + length);
        spans.addAll(_buildStaticSpans(chunk, defaultTextStyle));
        oldIdx += length;
        newIdx += length;
      } else if (diff.operation == DIFF_INSERT) {
        final length = diff.text.length;
        final chunk = _newTokens.sublist(newIdx, newIdx + length);

        final currentLineTokens = <_Token>[];
        for (final token in chunk) {
          if (token.char == '\n') {
            if (currentLineTokens.isNotEmpty) {
              spans.add(buildTransitionSpan(currentLineTokens, t));
              currentLineTokens.clear();
            }
            spans.add(const TextSpan(text: '\n'));
          } else {
            currentLineTokens.add(token);
          }
        }
        if (currentLineTokens.isNotEmpty) {
          spans.add(buildTransitionSpan(currentLineTokens, t));
        }
        newIdx += length;
      } else if (diff.operation == DIFF_DELETE) {
        final length = diff.text.length;
        final chunk = _oldTokens.sublist(oldIdx, oldIdx + length);

        final currentLineTokens = <_Token>[];
        for (final token in chunk) {
          if (token.char == '\n') {
            if (currentLineTokens.isNotEmpty) {
              spans.add(buildTransitionSpan(currentLineTokens, 1.0 - t));
              currentLineTokens.clear();
            }
            spans.add(const TextSpan(text: '\n'));
          } else {
            currentLineTokens.add(token);
          }
        }
        if (currentLineTokens.isNotEmpty) {
          spans.add(buildTransitionSpan(currentLineTokens, 1.0 - t));
        }
        oldIdx += length;
      }
    }
    return spans;
  }

  List<InlineSpan> _buildStaticSpans(List<_Token> tokens, TextStyle defaultTextStyle) {
    if (tokens.isEmpty) return [];
    final spans = <InlineSpan>[];
    var currentStyle = tokens.first.style;
    var currentBuffer = StringBuffer()..write(tokens.first.char);

    for (var i = 1; i < tokens.length; i++) {
      if (tokens[i].style == currentStyle) {
        currentBuffer.write(tokens[i].char);
      } else {
        spans.add(TextSpan(text: currentBuffer.toString(), style: currentStyle ?? defaultTextStyle));
        currentStyle = tokens[i].style;
        currentBuffer = StringBuffer()..write(tokens[i].char);
      }
    }
    spans.add(TextSpan(text: currentBuffer.toString(), style: currentStyle ?? defaultTextStyle));
    return spans;
  }

  int _countLinesInSpans(List<InlineSpan> spans) {
    var count = 1;
    for (final span in spans) {
      if (span is TextSpan && span.text != null) {
        count += '\n'.allMatches(span.text!).length;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final codeTheme = FlutterDeckCodeHighlightTheme.of(context);
    final textStyle = widget.textStyle == null || widget.textStyle!.inherit
        ? codeTheme.textStyle?.merge(widget.textStyle) ?? widget.textStyle
        : widget.textStyle;

    // Default text style for measuring layout and line heights
    final defaultTextStyle = textStyle ?? FlutterDeckTheme.of(context).textTheme.bodyMedium;

    Widget content;
    if (_highlighter == null) {
      // Still loading the highlighter/theme
      content = Text(widget.code, style: defaultTextStyle);
    } else {
      final animatedSpans = _buildAnimatedSpans(defaultTextStyle);
      final coloredCode = Text.rich(TextSpan(children: animatedSpans), style: defaultTextStyle);

      if (widget.highlightedLines.isEmpty) {
        content = coloredCode;
      } else {
        final numLines = _countLinesInSpans(animatedSpans);
        final fadedColoredCode = Text.rich(TextSpan(children: animatedSpans), style: defaultTextStyle);

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
