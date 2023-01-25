import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:timetracking/features/boardview/models/models.dart';
import 'package:timetracking/features/boardview/view/widgets/kanban_board.dart';
import 'package:timetracking/features/widgets/edit_task_widget.dart';
import 'package:timetracking/features/widgets/widgets.dart';
import 'package:timetracking/utils/util.dart';

import 'package:timetracking/services/base/kanban_board_controller.dart';
import 'provider/kanban_board_notifier.dart';

class KanbanBoardPage extends StatelessWidget {
  final KanbanModel? kanbanModel;
  final int? index;
  const KanbanBoardPage({super.key, this.kanbanModel, this.index});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      key: const ValueKey('KanbanBoardPage'),
      lazy: true,
      create: (context) => KanbanBoardProvider(kanbanModel, index),
      child: const _Injection(),
    );
  }
}

class _Injection extends StatefulWidget {
  const _Injection();
  @override
  State<_Injection> createState() => _IinjectionState();
}

class _IinjectionState extends State<_Injection> implements KanbanBoardBase {
  late KanbanBoardProvider _notifier;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _notifier = context.read<KanbanBoardProvider>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KanbanBoardProvider>(
      key: widget.key,
      builder: (_, provider, __) => ScaffoldWidget(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showColorPicker(context,
                    pickerColor:
                        Color(provider.kanbanModel.color ?? 4281714769))
                .then((c) {
              provider.onModelChange(c: c.value);
            });
          },
          child: Icon(
            Icons.colorize_outlined,
            color: Color(provider.kanbanModel.color ?? 4281714769),
          ),
        ),
        action: [
          CircleBtnWidget(
            icon: !provider.isUpdate ? Icons.done : Icons.delete_forever,
            onTap: provider.isUpdate
                ? () {
                    _delteBoard(context);
                  }
                : () {
                    provider.onAdd().then((b) {
                      if (b) {
                        Navigator.pop(context);
                      }
                    });
                  },
          )
        ],
        body: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: InputWidget(
                labelText: 'Title',
                onTap: () {
                  showbtmSheet(
                      context,
                      EditTaskForm(
                        title: 'Edit Title',
                        editTaskHandler: (s) {
                          provider.onModelChange(title: s);
                        },
                        text: provider.kanbanModel.title,
                      ));
                },
                str: provider.kanbanModel.title,
              ),
            ),
            Expanded(
              child: KanbanBoard(
                columns: provider.columns,
                controller: this,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _delteBoard(BuildContext context) {
    dialogBuilder(context, nlabel: 'No', ylabel: 'Yes', title: 'Delete ?',
        nonTap: () {
      Navigator.of(context).pop();
    }, yonTap: () {
      context.read<KanbanBoardProvider>().onDelet().then((b) {
        if (b) {
          Navigator.of(context)
            ..pop()
            ..pop();
        }
      });
    });
  }

  @override
  void deleteItem(int columnIndex, KTask task) {
    _notifier.deleteItem(columnIndex, task);
  }

  @override
  void handleReOrder(int oldIndex, int newIndex, int index) {
    _notifier.handleReOrder(oldIndex, newIndex, index);
  }

  @override
  void addColumn(String title) {
    _notifier.addColumn(title);
  }

  @override
  void addTask(String title, int column) {
    _notifier.addTask(title, column);
  }

  @override
  void dragHandler(KData data, int index) {
    _notifier.dragHandler(data, index);
  }

  Future<Color> _showColorPicker(BuildContext context,
      {Color? pickerColor}) async {
    Color c = Colors.green;
    await showbtmSheet(
      context,
      ColorPicker(
        pickerColor: pickerColor ?? c,
        onColorChanged: (color) {
          c = color;
        },
      ),
    );

    return c;
  }
}
