import 'package:flutter/material.dart';
import 'package:timetracking/features/boardview/models/models.dart';
import 'package:timetracking/services/base/kanban_board_controller.dart';
import 'package:timetracking/utils/scroll_behavior.dart';
import 'package:timetracking/utils/util.dart';
import 'package:timetracking/features/widgets/edit_task_widget.dart';

import 'add_column_button_widget.dart';
import 'add_column_widget.dart';
import 'column_widget.dart';

class KanbanBoard extends StatefulWidget {
  final KanbanBoardBase controller;
  final List<KColumn> columns;
  const KanbanBoard({
    super.key,
    required this.controller,
    required this.columns,
  });

  @override
  State<KanbanBoard> createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoScrollGlowBehavior(),
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding:
            const EdgeInsets.only(top: 20, bottom: 40, left: 40, right: 40),
        itemCount: widget.columns.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          if (index == widget.columns.length) {
            return AddColumnButton(
              addColumnAction: _showAddColumn,
            );
          } else {
            return KanbanColumn(
              column: widget.columns[index],
              index: index,
              dragHandler: widget.controller.dragHandler,
              reorderHandler: widget.controller.handleReOrder,
              addTaskHandler: _showAddTask,
              dragListener: _dragListener,
              deleteItemHandler: widget.controller.deleteItem,
            );
          }
        },
      ),
    );
  }

  void _showAddColumn() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // backgroundColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) => AddColumnForm(
        addColumnHandler: widget.controller.addColumn,
      ),
    );
  }

  void _showAddTask(int index) {
    showbtmSheet(
        context,
        EditTaskForm(
          editTaskHandler: (s) {
        
            widget.controller.addTask(s, index);
          },
          title: 'Add',
        ));
  }

  void _dragListener(DragUpdateDetails details) {
    if (details.localPosition.dx > MediaQuery.of(context).size.width - 40) {
      _scrollController.jumpTo(_scrollController.offset + 10);
    } else if (details.localPosition.dx < 20) {
      _scrollController.jumpTo(_scrollController.offset - 10);
    }
  }
}
