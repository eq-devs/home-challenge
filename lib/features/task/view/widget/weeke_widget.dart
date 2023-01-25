import 'package:flutter/material.dart';
import 'package:timetracking/features/task/model/weeke_model.dart';

class WeekeWidget extends StatelessWidget {
  final WeekeModel weeke;
  const WeekeWidget({super.key, required this.weeke});

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weeke.getWeeke().map((e) {
            return Text(
              e.weeke,
              style: TextStyle(
                  color: e.today
                      ? themeData.colorScheme.primary
                      : themeData.unselectedWidgetColor),
            );
          }).toList()),
    );
  }
}
