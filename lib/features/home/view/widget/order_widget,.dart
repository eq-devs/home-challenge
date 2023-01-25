import 'package:flutter/material.dart';

@immutable
class BorderBtnWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final bool selcted;
  const BorderBtnWidget(
      {super.key, this.onTap, required this.child, required this.selcted});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 33,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: themeData.unselectedWidgetColor),
            color:
                selcted ? themeData.textSelectionTheme.selectionColor : null),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: child,
      ),
    );
  }
}
