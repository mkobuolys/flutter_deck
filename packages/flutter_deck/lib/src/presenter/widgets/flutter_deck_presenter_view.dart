import 'package:flutter/material.dart';
import 'package:flutter_deck/src/controls/controls.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/presenter/flutter_deck_presenter_controller.dart';
import 'package:flutter_deck/src/presenter/widgets/flutter_deck_presenter_slide_preview.dart';
import 'package:flutter_deck/src/presenter/widgets/flutter_deck_presenter_timer.dart';
import 'package:flutter_deck/src/presenter/widgets/flutter_deck_speaker_notes.dart';
import 'package:flutter_deck/src/widgets/internal/internal.dart';

/// The presenter view page.
class PresenterView extends StatefulWidget {
  /// Creates the presenter view page.
  const PresenterView({super.key});

  @override
  State<PresenterView> createState() => _PresenterViewState();
}

class _PresenterViewState extends State<PresenterView> {
  late final FlutterDeckPresenterController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller = context.flutterDeck.presenterController..init();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const FlutterDeckDrawer(),
      body: Builder(
        builder: (context) {
          final scaffoldState = Scaffold.of(context);

          return FlutterDeckDrawerListener(
            onDrawerToggle: () => scaffoldState.isDrawerOpen ? scaffoldState.closeDrawer() : scaffoldState.openDrawer(),
            child: FlutterDeckControls(
              child: Column(
                children: [
                  const FlutterDeckPresenterTimer(),
                  Expanded(child: FlutterDeckPresenterSlidePreview()),
                  const Divider(),
                  const Expanded(flex: 2, child: FlutterDeckSpeakerNotes()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
