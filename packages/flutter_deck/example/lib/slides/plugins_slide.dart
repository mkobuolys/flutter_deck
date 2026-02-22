import 'package:flutter/widgets.dart';
import 'package:flutter_deck/flutter_deck.dart';

const _speakerNotes = '''
- The plugin system makes flutter_deck super extensible.
- Currently, PPTX export, PDF export, and Auto-play are provided out-of-the-box.
''';

class PluginsSlide extends FlutterDeckSlideWidget {
  const PluginsSlide()
    : super(
        configuration: const FlutterDeckSlideConfiguration(
          route: '/plugins',
          speakerNotes: _speakerNotes,
          header: FlutterDeckHeaderConfiguration(title: 'Plugin System'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return FlutterDeckSlide.blank(
      builder: (context) => Center(
        child: Text(
          'Pluggable & Exportable 🔌\n\n'
          'Need to export your slides to PDF or PowerPoint? Or maybe you '
          'want them to auto-play? Or maybe you want to extend the deck '
          'with your own custom features?\n\n'
          'With the flutter_deck plugin system, it is just one line of code.',
          style: FlutterDeckTheme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
