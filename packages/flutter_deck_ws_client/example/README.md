# Example usage in flutter_deck presentation

```dart
void main() {
  runApp(const FlutterDeckPresentation());
}

class FlutterDeckPresentation extends StatelessWidget {
  const FlutterDeckPresentation({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterDeckApp(
      client: FlutterDeckWsClient(uri: Uri.parse('ws://localhost:8080')),
      isPresenterView: true,
      configuration: FlutterDeckConfiguration(
        transition: const FlutterDeckTransition.fade(),
      ),
      slides: const [
        TitleSlide(),
        ContentSlide(),
        EndSlide(),
      ],
    );
  }
}
```
