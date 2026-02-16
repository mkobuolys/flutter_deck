import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_deck/flutter_deck.dart';

/// A renderer that captures [FlutterDeckSlide]s as images.
class FlutterDeckSlideImageRenderer {
  /// Creates a [FlutterDeckSlideImageRenderer].
  const FlutterDeckSlideImageRenderer({required FlutterDeck flutterDeck}) : _flutterDeck = flutterDeck;

  final FlutterDeck _flutterDeck;

  /// Renders a [FlutterDeckSlide] as an image.
  ///
  /// The [scale] parameter can be used to adjust the quality of the image.
  /// Defaults to 1.0.
  ///
  /// The [loadingDelay] parameter can be used to wait for assets to load
  /// before capturing the slide. Defaults to [Duration.zero].
  Future<Uint8List> render(
    BuildContext context,
    Widget slide, {
    required int stepNumber,
    double scale = 1.0,
    Duration loadingDelay = Duration.zero,
  }) async {
    var configuration = _flutterDeck.globalConfiguration.copyWith(
      controls: const FlutterDeckControlsConfiguration.disabled(),
      slideSize: FlutterDeckSlideSize.fromAspectRatio(aspectRatio: const FlutterDeckAspectRatio.ratio16x9()),
      showProgress: false,
    );

    if (slide is FlutterDeckSlideWidget && slide.configuration != null) {
      configuration = slide.configuration!.mergeWithGlobal(configuration);
    } else if (slide is FlutterDeckSlide && slide.configuration != null) {
      configuration = slide.configuration!.mergeWithGlobal(configuration);
    }

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
              debugShowCheckedModeBanner: false,
              theme: Theme.of(context),
              localizationsDelegates: _flutterDeck.localizationsDelegates,
              supportedLocales: _flutterDeck.supportedLocales,
              home: FlutterDeckTheme(data: deckTheme, child: slide),
            ),
          ),
    );

    final image = await _captureSlide(
      slideWidget,
      view,
      logicalSize,
      physicalSize,
      devicePixelRatio * scale,
      loadingDelay,
    );

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
    Duration loadingDelay,
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
      await Future<void>.delayed(loadingDelay, () {
        buildOwner
          ..buildScope(element)
          ..finalizeTree();

        pipelineOwner
          ..flushLayout()
          ..flushCompositingBits()
          ..flushPaint();
      });

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
