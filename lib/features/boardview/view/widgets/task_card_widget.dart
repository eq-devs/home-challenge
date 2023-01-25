import 'package:flutter/material.dart';
import 'package:timetracking/utils/util.dart';

import '../../models/models.dart';
import 'taks_menu.widget.dart';

class TaskCard extends StatelessWidget {
  final Color? color;
  final KTask task;
  final int columnIndex;
  final Function deleteItemHandler;
  final Function(DragUpdateDetails) dragListener;

  const TaskCard({
    super.key,
    this.color = Colors.green,
    required this.task,
    required this.columnIndex,
    required this.dragListener,
    required this.deleteItemHandler,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext _, BoxConstraints constraints) {
        return Container(
          height: 50,
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Draggable<KData>(
            onDragUpdate: dragListener,
            feedback: Material(
              color: color,
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                height: 50,
                width: constraints.maxWidth,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16),
                child: TaskText(title: task.title),
              ),
            ),
            childWhenDragging: Container(
              decoration: BoxDecoration(color: Theme.of(context).splashColor),
            ),
            data: KData(from: columnIndex, task: task),
            child: Container(
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                dense: true,
                title: TaskText(
                  title: task.title,
                ),
                trailing: GestureDetector(
                  onTap: () => showbtmSheet(
                    context,
                    TaskMenu(
                      deleteHandler: () => deleteItemHandler(columnIndex, task),
                    ),
                  ),
                  child: const Icon(
                    Icons.more_horiz,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TaskText extends StatelessWidget {
  const TaskText({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      // style: Theme.of(context).textTheme.bodyMedium?.copyWith(
      //       fontSize: 16,
      //       fontWeight: FontWeight.w400,
      //     ),
    );
  }
}
