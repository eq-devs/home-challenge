import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracking/features/boardview/view/provider/kanban_board_notifier.dart';

import '../../models/models.dart';
import 'card_column.dart';
import 'task_card_widget.dart';

@immutable
class KanbanColumn extends StatelessWidget {
  final KColumn column;
  final int index;
  final Function dragHandler;
  final Function reorderHandler;
  final Function addTaskHandler;
  final Function(DragUpdateDetails) dragListener;
  final Function deleteItemHandler;

  const KanbanColumn({
    super.key,
    required this.column,
    required this.index,
    required this.dragHandler,
    required this.reorderHandler,
    required this.addTaskHandler,
    required this.dragListener,
    required this.deleteItemHandler,
  });

  @override
  Widget build(BuildContext context) {
    var provider = context.read<KanbanBoardProvider>();
    var color = provider.kanbanModel.color ?? 4281714769;
    return Stack(
      children: <Widget>[
        CardColumn(
          width: 200,
          borderRadius: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTitleColumn(),
              _buildListItemsColumn(color),
              _buildButtonNewTask(index, color),
            ],
          ),
        ),
        Positioned.fill(
          child: DragTarget<KData>(
            onWillAccept: (data) {
              return true;
            },
            onLeave: (data) {},
            onAccept: (data) {
              if (data.from == index) {
                return;
              }
              dragHandler(data, index);
            },
            builder: (context, accept, reject) {
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTitleColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 4),
        Text(column.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20,
                // color: Colors.black,
                fontWeight: FontWeight.w700)),
        const Divider(),
      ],
    );
  }

  Widget _buildListItemsColumn(int c) {
    return Expanded(
        child: ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            shrinkWrap: true,
            onReorder: (oldIndex, newIndex) {
              if (newIndex < column.children.length) {
                reorderHandler(oldIndex, newIndex, index);
              }
            },
            children: column.children
                .map((e) => TaskCard(
                    color: Color(c),
                    key: ValueKey(e.title),
                    task: e,
                    columnIndex: index,
                    dragListener: dragListener,
                    deleteItemHandler: deleteItemHandler))
                .toList()));
  }

  Widget _buildButtonNewTask(int index, int c) {
    return Material(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      color: Color(c),
      child: ListTile(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        )),
        onTap: () {
          addTaskHandler(index);
        },
        leading: const Icon(
          Icons.add,
          size: 34.0,
        ),
        title: const Text(
          'Add Task',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
