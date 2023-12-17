/// The aspect ratio of the deck.
///
/// The aspect ratio is expressed as a ratio of width to height. For example,
/// an aspect ratio of 16:9 means the deck's width is 16/9 times its height.
///
/// If you do not want to constrain the deck's aspect ratio and leave it
/// responsive, use [FlutterDeckAspectRatio.responsive].
///
/// See also:
///
/// * [FlutterDeckAspectRatio.custom], which creates a custom aspect ratio.
/// * [FlutterDeckAspectRatio.ratio4x3], which creates a 4:3 aspect ratio.
/// * [FlutterDeckAspectRatio.ratio16x9], which creates a 16:9 aspect ratio.
/// * [FlutterDeckAspectRatio.ratio16x10], which creates a 16:10 aspect ratio.
/// * [FlutterDeckAspectRatio.responsive], which does not constrain the aspect
/// ratio of the deck and leaves it responsive to the size of the screen.
class FlutterDeckAspectRatio {
  /// Creates an aspect ratio for the deck.
  ///
  /// This constructor is private and should not be used directly. Instead, use
  /// one of the named constructors to define an aspect ratio.
  const FlutterDeckAspectRatio._([this._aspectRatio]);

  /// Creates a custom aspect ratio for the deck.
  ///
  /// [aspectRatio] is the ratio of width to height. For example, if you want
  /// the deck to have an aspect ratio of 16:9, pass in 16/9.
  const FlutterDeckAspectRatio.custom(double aspectRatio) : this._(aspectRatio);

  /// Creates a 4:3 aspect ratio for the deck.
  const FlutterDeckAspectRatio.ratio4x3() : this._(4 / 3);

  /// Creates a 16:9 aspect ratio for the deck.
  const FlutterDeckAspectRatio.ratio16x9() : this._(16 / 9);

  /// Creates a 16:10 aspect ratio for the deck.
  const FlutterDeckAspectRatio.ratio16x10() : this._(16 / 10);

  /// Creates a responsive aspect ratio for the deck. This means the aspect
  /// ratio is not constrained and will be responsive to the size of the screen.
  ///
  /// This is the default aspect ratio for the deck.
  const FlutterDeckAspectRatio.responsive() : this._();

  /// The aspect ratio of the deck.
  final double? _aspectRatio;

  /// Returns the aspect ratio value of the deck.
  double? get value => _aspectRatio;
}
