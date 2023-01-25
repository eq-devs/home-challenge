import 'package:flutter/material.dart';

class CircleBtnWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color? color;
  final String? str;
  const CircleBtnWidget({
    super.key,
    required this.onTap,
    required this.icon,
    this.color,
    this.str,
  });

  @override
  Widget build(BuildContext context) {
    var t = Theme.of(context);
    return InkWell(
      onTap: onTap,
      autofocus: false,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 50.0,
        width: 50.0,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: color ?? t.primaryColorLight),
        child: str != null
            ? Text(str!)
            : Icon(
                icon,
                color: t.primaryTextTheme.subtitle1?.color,
              ),
      ),
    );
  }
}
