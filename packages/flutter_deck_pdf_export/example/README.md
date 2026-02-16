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
      configuration: FlutterDeckConfiguration(
        transition: const FlutterDeckTransition.fade(),
      ),
      plugins: [
        FlutterDeckPdfExportPlugin(), // Use the PDF export plugin
      ],
      slides: const [
        TitleSlide(),
        ContentSlide(),
        EndSlide(),
      ],
    );
  }
}
```
