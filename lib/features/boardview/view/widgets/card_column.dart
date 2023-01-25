import 'package:flutter/material.dart';

class CardColumn extends StatelessWidget {
  const CardColumn({
    super.key,
    this.child,
    this.width = 300,
    this.borderRadius = 10,
    this.backgroundColor = Colors.white,
  });

  final Widget? child;
  final double? width;
  final double borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 7,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius)),
      child: Container(
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Theme.of(context).inputDecorationTheme.fillColor!),
        child: child,
      ),
    );
  }
}
