import 'package:flutter/material.dart';
import 'package:flutter_deck/src/flutter_deck.dart';

/// Renders the speaker notes for the current slide.
///
/// The speaker notes are displayed in a scrollable view. The font size of the
/// notes can be increased or decreased using the buttons at the top right
/// corner of the view.
class FlutterDeckSpeakerNotes extends StatefulWidget {
  /// Creates [FlutterDeckSpeakerNotes] widget.
  const FlutterDeckSpeakerNotes({super.key});

  @override
  State<FlutterDeckSpeakerNotes> createState() => _FlutterDeckSpeakerNotesState();
}

class _FlutterDeckSpeakerNotesState extends State<FlutterDeckSpeakerNotes> {
  var _fontSize = 24.0;

  void _increaseFontSize() {
    setState(() => _fontSize += 4);
  }

  void _decreaseFontSize() {
    setState(() => _fontSize = _fontSize > 4 ? _fontSize - 4 : _fontSize);
  }

  @override
  Widget build(BuildContext context) {
    final router = context.flutterDeck.router;

    return ListenableBuilder(
      listenable: router,
      builder: (context, child) {
        final currentSlideIndex = router.currentSlideIndex;
        final speakerNotes = router.currentSlideConfiguration.speakerNotes;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Text('Notes: Slide ${currentSlideIndex + 1}'),
                  const Spacer(),
                  IconButton(onPressed: _decreaseFontSize, icon: const Icon(Icons.remove_rounded)),
                  IconButton(onPressed: _increaseFontSize, icon: const Icon(Icons.add_rounded)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  speakerNotes,
                  style: TextStyle(fontSize: _fontSize),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
