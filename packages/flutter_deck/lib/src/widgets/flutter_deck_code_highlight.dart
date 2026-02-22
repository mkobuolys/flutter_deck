import 'dart:math' show min;

import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

const _dimmedCodeOpacity = 0.3;
const _dimCodeDuration = Duration(milliseconds: 500);

/// This widget provides syntax highlighting for many languages and animated code
/// transitions.
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
  ///
  /// When [code] changes from one frame to another, the widget will animate
  /// the transition as if the user were typing the changes.
  const FlutterDeckCodeHighlight({
    required this.code,
    this.language = 'dart',
    this.fileName,
    this.textStyle,
    this.highlightedLines = const [],
    this.maxAnimationDuration = const Duration(milliseconds: 2000),
    this.keystrokeDuration = const Duration(milliseconds: 50),
    this.animateHighlightedLines = true,
    super.key,
  });

  /// The code to display. When this changes, it triggers an animation from the
  /// old code snippet.
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

  /// Maximum duration of the typing animation. Defaults to 2 seconds.
  final Duration maxAnimationDuration;

  /// Duration of each keystroke animation. Defaults to 50 milliseconds.
  final Duration keystrokeDuration;

  /// Whether to animate the dimming of non-highlighted lines. Defaults to true.
  final bool animateHighlightedLines;

  @override
  State<FlutterDeckCodeHighlight> createState() => _FlutterDeckCodeHighlightState();
}

class _FlutterDeckCodeHighlightState extends State<FlutterDeckCodeHighlight> with TickerProviderStateMixin {
  late AnimationController _typingController;
  late AnimationController _highlightController;

  Highlighter? _highlighter;
  String? _animateFromCode;
  List<Diff>? _diff;
  int _numOperations = 0;

  @override
  void initState() {
    super.initState();
    _initHighlighter();

    _typingController = AnimationController(vsync: this, value: 0);
    _typingController.addListener(() {
      setState(() {});
      if (_typingController.isCompleted && widget.animateHighlightedLines && widget.highlightedLines.isNotEmpty) {
        _highlightController.animateTo(_dimmedCodeOpacity, duration: const Duration(milliseconds: 500));
      }
    });

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

    if (oldWidget.code != widget.code) {
      _animateFromCode = oldWidget.code;
      _startAnimations();
    } else if (oldWidget.highlightedLines != widget.highlightedLines) {
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

  void _startAnimations() {
    // If we're inside a slide step, we might want to check the SlideConfig
    // But since `didUpdateWidget` triggered this, the slide is active.
    if (_animateFromCode != null) {
      var numOperations = 0;
      _diff = DiffMatchPatch().diff(_animateFromCode!, widget.code);
      for (final d in _diff!) {
        if (d.operation == DIFF_DELETE) {
          numOperations += 1;
        } else if (d.operation == DIFF_INSERT) {
          numOperations += d.text.length;
        }
      }
      _numOperations = numOperations;
      var totalMs = numOperations * widget.keystrokeDuration.inMilliseconds;
      totalMs = min(totalMs, widget.maxAnimationDuration.inMilliseconds);

      final duration = Duration(milliseconds: totalMs);
      _typingController.value = 0.0;
      _highlightController.value = 1.0;
      _typingController.animateTo(1, duration: duration);
    }
  }

  @override
  void dispose() {
    _typingController.dispose();
    _highlightController.dispose();
    super.dispose();
  }

  String _getAnimatedCode(int frame) {
    if (_diff == null) return widget.code;

    final clampedFrame = frame.clamp(0, _numOperations - 1);

    var operationCount = 0;
    var diffIdx = 0;
    var characterIdx = 0;
    var animatedCode = '';
    var containsNewline = false;

    while (operationCount < clampedFrame) {
      final diff = _diff![diffIdx];

      if (diff.operation == DIFF_EQUAL) {
        animatedCode += diff.text;
        diffIdx += 1;
      } else if (diff.operation == DIFF_DELETE) {
        diffIdx += 1;
        operationCount += 1;
      } else {
        animatedCode += diff.text.substring(characterIdx, characterIdx + 1);
        if (diff.text.contains(r'\n')) {
          containsNewline = true;
        }

        characterIdx += 1;
        operationCount += 1;
        if (characterIdx == diff.text.length) {
          diffIdx += 1;
          characterIdx = 0;
          containsNewline = false;
        }
      }
    }

    if (containsNewline) {
      animatedCode += r'\n';
    }

    // Add remaining old code.
    while (diffIdx < _diff!.length) {
      final diff = _diff![diffIdx];
      if (diff.operation == DIFF_EQUAL) {
        animatedCode += diff.text;
      } else if (diff.operation == DIFF_DELETE) {
        animatedCode += diff.text;
      }
      diffIdx += 1;
    }

    return animatedCode;
  }

  @override
  Widget build(BuildContext context) {
    final codeTheme = FlutterDeckCodeHighlightTheme.of(context);
    final textStyle = widget.textStyle == null || widget.textStyle!.inherit
        ? codeTheme.textStyle?.merge(widget.textStyle) ?? widget.textStyle
        : widget.textStyle;

    // Default text style for measuring layout and line heights
    final defaultTextStyle = textStyle ?? FlutterDeckTheme.of(context).textTheme.bodyMedium;

    String animatedCode;
    if (_typingController.isAnimating && _animateFromCode != null && _diff != null) {
      animatedCode = _getAnimatedCode((_typingController.value * _numOperations).floor());
    } else if (_animateFromCode != null && _typingController.value == 0.0) {
      animatedCode = _animateFromCode!;
    } else {
      animatedCode = widget.code;
    }

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
        final numLines = animatedCode.split(r'\n').length;
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
