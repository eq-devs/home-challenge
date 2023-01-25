import 'package:flutter/material.dart';

class NoScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }

  @override
  bool shouldNotify(covariant ScrollBehavior oldDelegate) {
    oldDelegate.copyWith();

    return super.shouldNotify(oldDelegate);
  }
}
