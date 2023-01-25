import 'package:flutter/material.dart';
import 'package:timetracking/features/widgets/widgets.dart';

class TaskMenu extends StatelessWidget {
  final Function deleteHandler;
  const TaskMenu({
    super.key,
    required this.deleteHandler,
  });

  @override
  Widget build(BuildContext context) {
    final double paddingBottom = MediaQuery.of(context).padding.bottom;
    return IntrinsicHeight(
      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 30, bottom: paddingBottom + 10),
          child: ButtonGeneric(
            label: 'Delete Task',
            labelStyle: const TextStyle(color: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
              deleteHandler();
            },
          )

          // InkWell(
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     deleteHandler();
          //   },
          //   child: const SizedBox(
          //     height: 40,
          //     child: Text(
          //       'Delete Task',
          //       style: TextStyle(
          //         fontSize: 18,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.red,
          //       ),
          //     ),
          //   ),
          // ),
          ),
    );
  }
}
