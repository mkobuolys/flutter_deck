import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_deck/src/configuration/configuration.dart';
import 'package:flutter_deck/src/flutter_deck.dart';
import 'package:flutter_deck/src/flutter_deck_app.dart';
import 'package:flutter_deck/src/renderers/flutter_slide_renderer.dart';
import 'package:flutter_deck/src/theme/flutter_deck_theme.dart';

/// A renderer that renders a slide as an image.
class FlutterSlideImageRenderer extends FlutterSlideRenderer {
  /// Creates a [FlutterSlideImageRenderer].
  const FlutterSlideImageRenderer();

  @override
  Future<Uint8List> render(
    BuildContext context,
    Widget slide,
    FlutterDeck deck, {
    FlutterDeckConfiguration? configuration,
  }) async {
    final view = View.of(context);
    final config = (configuration ?? deck.globalConfiguration).copyWith(
      controls: const FlutterDeckControlsConfiguration.disabled(),
    );
    final slideSize = config.slideSize;
    final devicePixelRatio = view.devicePixelRatio;
    final deckTheme = FlutterDeckTheme.of(context);
    final app = FlutterDeckApp.maybeOf(context);

    final Size logicalSize;
    if (slideSize.isResponsive) {
      logicalSize = view.physicalSize / devicePixelRatio;
    } else {
      logicalSize = Size(slideSize.width!, slideSize.height!);
    }

    final physicalSize = logicalSize * devicePixelRatio;

    final slideWidget = MediaQuery(
      data: MediaQueryData(size: logicalSize, devicePixelRatio: devicePixelRatio),
      child: deck.copyWith(
        configuration: config,
        child: MaterialApp(
          useInheritedMediaQuery: true,
          debugShowCheckedModeBanner: false,
          theme: Theme.of(context),
          localizationsDelegates: app?.localizationsDelegates,
          supportedLocales: app?.supportedLocales ?? const <Locale>[Locale('en', 'US')],
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
