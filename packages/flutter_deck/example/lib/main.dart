import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file/memory.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_deck/flutter_deck.dart';
import 'package:flutter_deck_example/l10n/l10n.dart';
import 'package:flutter_deck_example/slides/slides.dart';
import 'package:flutter_deck_web_client/flutter_deck_web_client.dart';
import 'package:open_xml/open_xml.dart' as open_xml;

void main() {
  runApp(const FlutterDeckExample());
}

class FlutterDeckExample extends StatelessWidget {
  const FlutterDeckExample({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterDeckApp(
      client: FlutterDeckWebClient(),
      // You could use the default configuration or create your own.
      configuration: FlutterDeckConfiguration(
        // Define a global background for the light and dark themes separately.
        background: const FlutterDeckBackgroundConfiguration(
          light: FlutterDeckBackground.gradient(
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFDEE9), Color(0xFFB5FFFC)],
            ),
          ),
          dark: FlutterDeckBackground.gradient(
            LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF16222A), Color(0xFF3A6073)],
            ),
          ),
        ),
        // Set defaults for the footer.
        footer: const FlutterDeckFooterConfiguration(showSlideNumbers: true, showSocialHandle: true),
        // Set defaults for the header.
        header: const FlutterDeckHeaderConfiguration(showHeader: false),
        // Override the default marker configuration.
        marker: const FlutterDeckMarkerConfiguration(color: Colors.cyan, strokeWidth: 8),
        // Show progress indicator with specifc gradient and background color.
        progressIndicator: const FlutterDeckProgressIndicator.gradient(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink, Colors.purple],
          ),
          backgroundColor: Colors.black,
        ),
        // Use a custom slide size.
        slideSize: FlutterDeckSlideSize.fromAspectRatio(
          aspectRatio: const FlutterDeckAspectRatio.ratio16x9(),
          resolution: const FlutterDeckResolution.fhd(),
        ),
        // Use a custom transition between slides.
        transition: const FlutterDeckTransition.fade(),
      ),
      // You can also define your own light...
      lightTheme: FlutterDeckThemeData.fromTheme(
        ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB5FFFC)), useMaterial3: true),
      ),
      // ...and dark themes.
      darkTheme: FlutterDeckThemeData.fromTheme(
        ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF16222A), brightness: Brightness.dark),
          useMaterial3: true,
        ),
      ),
      // Add custom functionality using plugins.
      plugins: [FlutterDeckAutoplayPlugin(), FlutterDeckPptxExportPlugin()],
      // Presentation is build automatically from the list of slides.
      slides: [
        const TitleSlide(),
        const LayoutStructureSlide(),
        const BlankSlide(),
        const SplitSlide(),
        const ImageSlide(),
        const BigFactSlide(),
        const QuoteSlide(),
        const FooterSlide(),
        const HiddenSlide(),
        const DrawerSlide(),
        const MarkerSlide(),
        const ThemingSlide(),
        const BackgroundSlide(),
        const LocalizationSlide(),
        const TransitionsSlide(),
        const StepsSlide(),
        const CodeHighlightSlide(),
        // You can use any widget as a slide.
        Scaffold(
          backgroundColor: Colors.blue,
          body: Builder(
            builder: (context) => Center(
              child: Text('You can use any widget as a slide!', style: FlutterDeckTheme.of(context).textTheme.title),
            ),
          ),
        ),
        // You can use the FlutterDeckSlide widgets without subclassing them.
        FlutterDeckSlide.title(
          configuration: const FlutterDeckSlideConfiguration(
            route: '/end',
            title: 'Thank you!',
            speakerNotes: '- Use flutter_deck to create your own slides.',
            footer: FlutterDeckFooterConfiguration(showFooter: false),
          ),
          title: 'Thank you! 👋',
          subtitle: "Now it's your turn to use flutter_deck!",
        ),
      ],
      // Do not forget to introduce yourself!
      speakerInfo: const FlutterDeckSpeakerInfo(
        name: 'Flutter Deck',
        description: 'The power of Flutter, in your presentations.',
        socialHandle: 'flutter_deck',
        imagePath: 'assets/flutter_logo.png',
      ),
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

class FlutterDeckPptxExportPlugin extends FlutterDeckPlugin {
  late final FlutterSlideImageRenderer _slideImageRenderer;

  @override
  void init(FlutterDeck flutterDeck) {
    _slideImageRenderer = FlutterSlideImageRenderer(flutterDeck: flutterDeck);
  }

  @override
  List<Widget> buildControls(BuildContext context, FlutterDeckPluginMenuItemBuilder menuItemBuilder) => [
    menuItemBuilder(
      context,
      icon: const Icon(Icons.slideshow_rounded),
      label: 'Export PPTX',
      onPressed: () => _onPressed(context),
    ),
  ];

  Future<void> _onPressed(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final progressNotifier = ValueNotifier<double>(0);

    messenger.showSnackBar(
      SnackBar(
        duration: const Duration(minutes: 5),
        content: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: ValueListenableBuilder<double>(
                valueListenable: progressNotifier,
                builder: (context, value, _) => CircularProgressIndicator(
                  value: value,
                  color: Theme.of(context).colorScheme.onInverseSurface,
                  strokeWidth: 2,
                ),
              ),
            ),
            const SizedBox(width: 16),
            const Text('Exporting PPTX...'),
          ],
        ),
      ),
    );

    try {
      await _exportPptx(navigator.overlay!.context, onProgress: (progress) => progressNotifier.value = progress);

      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Exported presentation as PPTX!')));
    } catch (e, t) {
      debugPrint('Failed to export presentation: $e\n$t');
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Failed to export presentation: $e')));
    }
  }

  Future<void> _exportPptx(BuildContext context, {required ValueChanged<double> onProgress}) async {
    final flutterDeck = context.flutterDeck;
    final slides = flutterDeck.router.slides;

    final fs = MemoryFileSystem();
    final pres = await open_xml.Presentation.create(fs);

    if (context.mounted) {
      await precacheImage(const AssetImage('assets/header.png'), context);
      // ignore: use_build_context_synchronously
      await precacheImage(const AssetImage('assets/flutter_logo.png'), context);
      // ignore: use_build_context_synchronously
      await precacheImage(const AssetImage('assets/dog_complete_drawing.jpeg'), context);
    }

    pres.setAspectRatio(open_xml.PresentationAspectRatio.widescreen_16_9);

    var slideIndex = 0;

    for (var i = 0; i < slides.length; i++) {
      final slide = slides[i];
      final steps = slide.configuration.steps;
      final speakerNotes = slide.configuration.speakerNotes;

      for (var step = 1; step <= steps; step++) {
        onProgress((i + 1) / slides.length);
        debugPrint('Exporting Slide $i, Step $step');

        final bytes = await _exportSlide(
          // ignore: use_build_context_synchronously
          context,
          slide: slide.widget,
          stepNumber: step,
        );

        final fileName = 'slide_${(slideIndex++).toString().padLeft(5, '0')}.png';

        // Write image to memory fs
        final imageFile = fs.file(fileName);
        await imageFile.writeAsBytes(bytes);

        final pptxSlide = pres.addSlide()
          // Add image as background
          ..setBackground(open_xml.ImageBackground(fileName, mode: open_xml.ImageStretchMode()))
          // Set transition
          ..setTransition(open_xml.FadeTransition());

        if (speakerNotes.isNotEmpty) {
          pptxSlide.addNote(speakerNotes);
        }
      }
    }

    // Save PPTX to memory fs
    const pptxPath = 'presentation.pptx';
    await pres.save(fs.file(pptxPath));

    // Read bytes and save to user device
    final pptxFile = fs.file(pptxPath);
    final pptxBytes = await pptxFile.readAsBytes();
    await pres.close(); // Clean up resources

    await FileSaver.instance.saveFile(
      name: 'flutter_deck_presentation.pptx',
      bytes: pptxBytes,
      mimeType: MimeType.microsoftPresentation,
    );

    debugPrint('Presentation exported as PPTX');
  }

  Future<Uint8List> _exportSlide(BuildContext context, {required Widget slide, required int stepNumber}) {
    var configuration = context.flutterDeck.globalConfiguration.copyWith(
      controls: const FlutterDeckControlsConfiguration.disabled(),
      slideSize: FlutterDeckSlideSize.fromAspectRatio(
        aspectRatio: const FlutterDeckAspectRatio.ratio16x9(),
        resolution: const FlutterDeckResolution.fhd(),
      ),
      showProgress: false,
    );

    if (slide is FlutterDeckSlideWidget && slide.configuration != null) {
      configuration = slide.configuration!.mergeWithGlobal(configuration);
    } else if (slide is FlutterDeckSlide && slide.configuration != null) {
      configuration = slide.configuration!.mergeWithGlobal(configuration);
    }

    return _slideImageRenderer.render(context, slide, configuration: configuration, stepNumber: stepNumber);
  }
}

class FlutterSlideImageRenderer {
  /// Creates a [FlutterSlideImageRenderer].
  const FlutterSlideImageRenderer({required FlutterDeck flutterDeck}) : _flutterDeck = flutterDeck;

  final FlutterDeck _flutterDeck;

  Future<Uint8List> render(
    BuildContext context,
    Widget slide, {
    required FlutterDeckConfiguration configuration,
    required int stepNumber,
  }) async {
    final view = View.of(context);
    final slideSize = configuration.slideSize;
    final devicePixelRatio = view.devicePixelRatio;
    final deckTheme = FlutterDeckTheme.of(context);

    final Size logicalSize;
    if (slideSize.isResponsive) {
      logicalSize = view.physicalSize / devicePixelRatio;
    } else {
      logicalSize = Size(slideSize.width!, slideSize.height!);
    }

    final physicalSize = logicalSize * devicePixelRatio;

    final slideWidget = MediaQuery(
      data: MediaQueryData(size: logicalSize, devicePixelRatio: devicePixelRatio),
      child: _flutterDeck
          .copyWith(configuration: configuration, stepNumber: stepNumber)
          .wrap(
            context,
            child: MaterialApp(
              // ignore: deprecated_member_use
              useInheritedMediaQuery: true,
              debugShowCheckedModeBanner: false,
              theme: Theme.of(context),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: FlutterDeckTheme(data: deckTheme, child: slide),
            ),
          ),
    );

    final image = await _captureSlide(slideWidget, view, logicalSize, physicalSize, devicePixelRatio);

    if (image != null) {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);

      if (data != null) {
        return data.buffer.asUint8List();
      }
    }

    throw Exception('Failed to render slide');
  }

  Future<ui.Image?> _captureSlide(
    Widget slide,
    ui.FlutterView view,
    Size logicalSize,
    Size physicalSize,
    double devicePixelRatio,
  ) async {
    final renderView = RenderView(
      view: view,
      configuration: ViewConfiguration(
        logicalConstraints: BoxConstraints.tight(logicalSize),
        physicalConstraints: BoxConstraints.tight(physicalSize),
        devicePixelRatio: devicePixelRatio,
      ),
    );

    final pipelineOwner = PipelineOwner()..rootNode = renderView;
    final buildOwner = BuildOwner(focusManager: FocusManager());

    final renderRepaintBoundary = RenderRepaintBoundary();
    renderView
      ..child = renderRepaintBoundary
      ..prepareInitialFrame();

    final renderViewWithBoundary = RenderObjectToWidgetAdapter<RenderBox>(
      container: renderRepaintBoundary,
      child: slide,
    );

    final element = renderViewWithBoundary.attachToRenderTree(buildOwner);

    try {
      buildOwner
        ..buildScope(element)
        ..finalizeTree();

      pipelineOwner
        ..flushLayout()
        ..flushCompositingBits()
        ..flushPaint();

      renderView.compositeFrame();

      final image = await renderRepaintBoundary.toImage(pixelRatio: devicePixelRatio);

      return image;
    } finally {
      RenderObjectToWidgetAdapter<RenderBox>(
        container: renderRepaintBoundary,
        debugShortDescription: '[root]',
      ).attachToRenderTree(buildOwner, element);
    }
  }
}
