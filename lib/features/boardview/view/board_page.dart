 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timetracking/features/boardview/models/models.dart';

import 'package:timetracking/features/widgets/widgets.dart';
import 'package:timetracking/utils/util.dart';

import 'kanban_board_page.dart';

@immutable
class BoardPage<T> extends StatelessWidget {
  final ValueListenable<T> boardlistener;
  const BoardPage({super.key, required this.boardlistener});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: boardlistener,
      builder: (context, t, child) {
        t as Box<dynamic>;
        return ListviewBuilderWidget(
            itemCount: t.values.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 8)
                .copyWith(bottom: 20, top: 20),
            itemBuilder: (context, index) {
              var list = _sort(t.values.toList());
              int reversedIndex = list.length - 1 - index;
              var model = list[index] as KanbanModel;
              return BoardItemWidget(
                kanbanModel: model,
                index: reversedIndex,
              );
            });
      },
    );
  }

  List _sort(List l) {
    return l.reversed.toList();
  }
}

class BoardItemWidget extends StatelessWidget {
  final KanbanModel kanbanModel;
  final int index;
  const BoardItemWidget(
      {super.key, required this.kanbanModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitchWidget(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) =>
                  KanbanBoardPage(kanbanModel: kanbanModel, index: index),
            ),
          );
        },
        key: ValueKey(kanbanModel.hashCode),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
              color: Color(kanbanModel.color ?? 000),
              borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            trailing: CircleAvatar(child: Text(kanbanModel.mode ?? '😄')),
            contentPadding: const EdgeInsets.symmetric(vertical: 2),
            title: Text(kanbanModel.title ?? ''),
            subtitle: Text(convertT2DT(kanbanModel.addTime ?? 0)),
            minLeadingWidth: 0,
          ),
        ),
      ),
    );
  }
}
