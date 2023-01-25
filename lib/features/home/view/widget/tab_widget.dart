import 'package:flutter/material.dart';

Tab tab(BuildContext context, String title, String count) {
  return Tab(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        coutWidget(
          count,
          Theme.of(context).splashColor,
        ),
        const SizedBox(width: 8),
        Text(title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontSize: 28)),
      ],
    ),
  );
}

Widget coutWidget(String count, Color color) {
  bool i = count.length >= 2;
  bool y = count.length >= 4;
  return Container(
    padding: EdgeInsets.all(i ? 4 : 8),
    decoration: BoxDecoration(
      color: color,
      // color: Theme.of(context).backgroundColor,
      shape: i ? BoxShape.rectangle : BoxShape.circle,
      borderRadius: i ? BorderRadius.circular(30) : null,
    ),
    child: Text(
      y ? '99+' : count.toString(),
      style: const TextStyle(fontSize: 14),
    ),
  );
}
