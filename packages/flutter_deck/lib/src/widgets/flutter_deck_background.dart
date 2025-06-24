import 'package:flutter/material.dart';

/// A widget that renders a background for a flutter deck slide.
///
/// * [FlutterDeckBackground.custom] uses any [Widget] as a background.
/// * [FlutterDeckBackground.gradient] uses a [Gradient] as a
/// background.
/// * [FlutterDeckBackground.image] uses an [Image] as a background.
/// * [FlutterDeckBackground.solid] uses a solid [Color] as a background.
/// * [FlutterDeckBackground.transparent] is a dummy background that does not
/// render anything (transparent), thus the [Scaffold.backgroundColor] will be
/// used as a background for flutter deck slide.
class FlutterDeckBackground extends StatelessWidget {
  /// Creates a custom background.
  const FlutterDeckBackground.custom({required Widget child}) : this._(child: child);

  /// Creates a background with a gradient.
  const FlutterDeckBackground.gradient(Gradient gradient) : this._(gradient: gradient);

  /// Creates a background with an image.
  const FlutterDeckBackground.image(Image image) : this._(image: image);

  /// Creates a solid color background.
  const FlutterDeckBackground.solid(Color color) : this._(color: color);

  /// Creates a transparent background.
  const FlutterDeckBackground.transparent() : this._();

  /// A private constructor for the [FlutterDeckBackground] widget.
  ///
  /// This constructor is private because it should not be used directly.
  /// Instead, use one of the public constructors.
  const FlutterDeckBackground._({this.child, this.color, this.gradient, this.image});

  /// The background widget.
  ///
  /// This value is only provided via the [FlutterDeckBackground.custom]
  /// constructor.
  final Widget? child;

  /// The background color.
  ///
  /// This value is only provided via the [FlutterDeckBackground.solid]
  /// constructor.
  final Color? color;

  /// The background gradient.
  ///
  /// This value is only provided via the [FlutterDeckBackground.gradient]
  /// constructor.
  final Gradient? gradient;

  /// The background image.
  ///
  /// This value is only provided via the [FlutterDeckBackground.image]
  /// constructor.
  final Image? image;

  @override
  Widget build(BuildContext context) {
    if (child != null) return child!;
    if (color != null) return ColoredBox(color: color!);
    if (image != null) return image!;
    if (gradient != null) {
      return DecoratedBox(decoration: BoxDecoration(gradient: gradient));
    }

    return const SizedBox.shrink();
  }
}
