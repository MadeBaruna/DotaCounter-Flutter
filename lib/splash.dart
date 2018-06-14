import 'package:flutter/material.dart';

// for disabling splash effect on TextField
// from https://github.com/flutter/flutter/pull/16336#issuecomment-380915096

class NoSplashFactory extends InteractiveInkFeatureFactory {
  const NoSplashFactory();

  @override
  InteractiveInkFeature create({
    @required MaterialInkController controller,
    @required RenderBox referenceBox,
    @required Offset position,
    @required Color color,
    bool containedInkWell: false,
    RectCallback rectCallback,
    BorderRadius borderRadius,
    double radius,
    VoidCallback onRemoved,
  }) {
    return new NoSplash(
      controller: controller,
      referenceBox: referenceBox,
    );
  }
}

class NoSplash extends InteractiveInkFeature {
  NoSplash({
    @required MaterialInkController controller,
    @required RenderBox referenceBox,
  })  : assert(controller != null),
        assert(referenceBox != null),
        super(
        controller: controller,
        referenceBox: referenceBox,
      );

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}
