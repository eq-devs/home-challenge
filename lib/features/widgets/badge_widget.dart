import 'package:flutter/material.dart';

class NotificationIconWidget extends StatelessWidget {
  final double? marginTopLeft;
  final IconData? icons;
  final Color? badgeColor;
  final void Function()? onTap;

  const NotificationIconWidget(
      {Key? key,
      this.marginTopLeft,
      this.icons,
      this.badgeColor = Colors.blueAccent,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final margin = marginTopLeft ?? 17;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 24,
        height: 24,
        child: Stack(
          children: [
            icons != null ? Center(child: Icon(icons)) : const SizedBox(),
            Positioned(
              right: margin,
              top: margin,
              child: SizedBox(
                width: 8,
                height: 8,
                child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: badgeColor ?? Colors.transparent),
                    width: 8,
                    height: 8),
              ),
            )
          ],
        ),
      ),
    );
  }
}
