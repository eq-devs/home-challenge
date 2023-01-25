import 'package:flutter/material.dart';

class AnimatedSwitchWidget extends StatelessWidget {
  final Widget child;
  final int? duration;

  const AnimatedSwitchWidget({Key? key, required this.child, this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: duration ?? 400),
      switchInCurve: Curves.easeInQuad,
      transitionBuilder: (child, animation) =>
          FadeTransition(opacity: animation, child: child),
      child: child,
    );
  }
}
