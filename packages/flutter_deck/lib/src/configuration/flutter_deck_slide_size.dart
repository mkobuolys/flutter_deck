/// The slide size of the deck.
///
/// The slide size is expressed as a height and width in pixels.
///
/// By default, the slide size is [FlutterDeckSlideSize.responsive], meaning
/// that the slides will automatically resize to fit the available space. You
/// can also specify a custom slide size, or create a slide size from an aspect
/// ratio and a resolution.
///
/// See also:
///
/// * [FlutterDeckSlideSize.custom], which creates a custom slide size.
/// * [FlutterDeckSlideSize.fromAspectRatio], which creates a slide size from
///  an aspect ratio and a resolution (Full HD by default).
/// * [FlutterDeckSlideSize.responsive], which does not constrain the size of
/// the slides.
class FlutterDeckSlideSize {
  /// Creates a slide size for the deck.
  ///
  /// This constructor is private and should not be used directly. Instead, use
  /// one of the named constructors to define a slide size.
  const FlutterDeckSlideSize._({required this.height, required this.width})
    : assert(height == null || height > 0, 'height must be greater than 0'),
      assert(width == null || width > 0, 'width must be greater than 0');

  /// Creates a custom slide size for the deck.
  ///
  /// [height] and [width] are the height and width of the slide and must be
  /// greater than 0.
  const FlutterDeckSlideSize.custom({required double height, required double width})
    : this._(height: height, width: width);

  /// Creates a slide size from an aspect ratio and a resolution.
  ///
  /// [aspectRatio] is the aspect ratio of the slide. For example, if you want
  /// the slide to have an aspect ratio of 16:9, pass in
  /// [FlutterDeckAspectRatio.ratio16x9].
  ///
  /// [resolution] is the resolution of the slide. For example, if you want the
  /// slide to have a 4K resolution, pass in [FlutterDeckResolution.uhd]. By
  /// default, the resolution is Full HD (1920x1080).
  factory FlutterDeckSlideSize.fromAspectRatio({
    required FlutterDeckAspectRatio aspectRatio,
    FlutterDeckResolution resolution = const FlutterDeckResolution.fhd(),
  }) {
    final width = resolution.width;
    final height = width / aspectRatio.value;

    return FlutterDeckSlideSize._(height: height, width: width);
  }

  /// Creates a slide size that does not constrain the size of the slides.
  ///
  /// This is useful if you want to use the deck in a responsive layout. This
  /// is the default slide size of the deck.
  const FlutterDeckSlideSize.responsive() : height = null, width = null;

  /// The height of the slide.
  final double? height;

  /// The width of the slide.
  final double? width;

  /// Returns the aspect ratio of the slide.
  double? get aspectRatio => !isResponsive ? width! / height! : null;

  /// Returns whether the slide size is responsive.
  bool get isResponsive => height == null && width == null;
}

/// The aspect ratio of the deck.
///
/// The aspect ratio is expressed as a ratio of width to height. For example,
/// an aspect ratio of 16:9 means the deck's width is 16/9 times its height.
///
/// See also:
///
/// * [FlutterDeckAspectRatio.custom], which creates a custom aspect ratio.
/// * [FlutterDeckAspectRatio.ratio1x1], which creates a 1:1 aspect ratio.
/// * [FlutterDeckAspectRatio.ratio4x3], which creates a 4:3 aspect ratio.
/// * [FlutterDeckAspectRatio.ratio16x9], which creates a 16:9 aspect ratio.
/// * [FlutterDeckAspectRatio.ratio16x10], which creates a 16:10 aspect ratio.
class FlutterDeckAspectRatio {
  /// Creates an aspect ratio for the deck.
  ///
  /// This constructor is private and should not be used directly. Instead, use
  /// one of the named constructors to define an aspect ratio.
  const FlutterDeckAspectRatio._(this._aspectRatio);

  /// Creates a custom aspect ratio for the deck.
  ///
  /// [aspectRatio] is the ratio of width to height. For example, if you want
  /// the deck to have an aspect ratio of 16:9, pass in 16/9.
  const FlutterDeckAspectRatio.custom(double aspectRatio) : this._(aspectRatio);

  /// Creates a 1:1 aspect ratio for the deck.
  const FlutterDeckAspectRatio.ratio1x1() : this._(1);

  /// Creates a 4:3 aspect ratio for the deck.
  const FlutterDeckAspectRatio.ratio4x3() : this._(4 / 3);

  /// Creates a 16:9 aspect ratio for the deck.
  const FlutterDeckAspectRatio.ratio16x9() : this._(16 / 9);

  /// Creates a 16:10 aspect ratio for the deck.
  const FlutterDeckAspectRatio.ratio16x10() : this._(16 / 10);

  /// The aspect ratio of the deck.
  final double _aspectRatio;

  /// Returns the aspect ratio value of the deck.
  double get value => _aspectRatio;
}

/// The resolution of the deck.
///
/// The resolution is expressed as a width in pixels and later used to calculate
/// the height of the slide when aspect ratio is provided.
///
/// See also:
///
/// * [FlutterDeckResolution.fromWidth], which creates a resolution from a
/// custom width.
/// * [FlutterDeckResolution.hd], which creates a 720p (HD) resolution with a
/// width of 1280 pixels.
/// * [FlutterDeckResolution.fhd], which creates a 1080p (Full HD) resolution
/// with a width of 1920 pixels.
/// * [FlutterDeckResolution.qhd], which creates a 1440p (2K) resolution with a
/// width of 2560 pixels.
/// * [FlutterDeckResolution.uhd], which creates a 2160p (4K) resolution with a
/// width of 3840 pixels.
class FlutterDeckResolution {
  /// Creates a resolution for the deck.
  ///
  /// This constructor is private and should not be used directly. Instead, use
  /// one of the named constructors to define a resolution.
  const FlutterDeckResolution._(this._width) : assert(_width > 0, 'width must be greater than 0');

  /// Creates a resolution from a custom width.
  ///
  /// [width] is the width of the slide and must be greater than 0.
  const FlutterDeckResolution.fromWidth(double width) : this._(width);

  /// Creates a 720p (HD) resolution for the deck.
  const FlutterDeckResolution.hd() : this._(1280);

  /// Creates a 1080p (Full HD) resolution for the deck.
  const FlutterDeckResolution.fhd() : this._(1920);

  /// Creates a 1440p (2K) resolution for the deck.
  const FlutterDeckResolution.qhd() : this._(2560);

  /// Creates a 2160p (4K) resolution for the deck.
  const FlutterDeckResolution.uhd() : this._(3840);

  /// The width of the deck.
  final double _width;

  /// Returns the width of the deck.
  double get width => _width;
}
