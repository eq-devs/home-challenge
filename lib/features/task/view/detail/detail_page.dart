import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracking/features/home/view/widget/order_widget,.dart';
import 'package:timetracking/features/task/model/task_model.dart';
import 'package:timetracking/features/task/view/widget/widget.dart';
import 'package:timetracking/utils/util.dart';
import 'package:timetracking/features/widgets/widgets.dart';

import 'package:timetracking/features/widgets/edit_task_widget.dart';
import 'package:timetracking/features/task/view/detail/provider/task_provider.dart';
import 'widget/btm_controll_widget.dart';

const _sizedBox = SizedBox(height: 8);

class _Injection extends StatelessWidget {
  final TaksModel? item;
  const _Injection({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    bool isUpdate = item != null;
    var themeData = Theme.of(context);
    var provider = context.read<TaskProvider>();

    return ScaffoldWidget(
        key: key,
        action: [
          CircleBtnWidget(
              onTap: () {
                if (!isUpdate) {
                  provider.onAdd().then((b) {
                    if (b) Navigator.pop(context);
                  });
                } else {
                  _delteTask(context);
                }
              },
              icon: isUpdate ? Icons.delete_forever : Icons.done),
        ],
        body: Consumer<TaskProvider>(
          key: const ValueKey('Consumer'),
          builder: (_, value, child) => ListviewWidget(
            shrinkWrap: true,
            children: [
              _sizedBox,
              InputWidget(
                labelText: 'Title',
                onTap: () {
                  showbtmSheet(
                      context,
                      EditTaskForm(
                        editTaskHandler: (s) {
                          provider.onModelChange(title: s);
                        },
                        text: provider.taksModel.title,
                      ));
                },
                str: provider.taksModel.title,
              ),
              _sizedBox,
              _sizedBox,
              InputWidget(
                maxHeight: 200,
                style:
                    themeData.textTheme.headlineSmall?.copyWith(fontSize: 16),
                labelText: 'Discrption',
                str: provider.taksModel.discrption,
                onTap: () {
                  showbtmSheet(
                      context,
                      EditTaskForm(
                        title: 'Edit Discrption',
                        editTaskHandler: (s) {
                          provider.onModelChange(discrption: s);
                        },
                        text: provider.taksModel.discrption,
                      ));
                },
              ),
              _sizedBox,
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BorderBtnWidget(
                      selcted: false,
                      child: Text(provider.taksModel.status ?? 'Active')),
                  const SizedBox(width: 8),
                  ColorSelectWidget(
                      selected: provider.taksModel.color,
                      onColorsChange: (c) {
                        provider.onModelChange(color: c.value);
                      }),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4)
                        .copyWith(left: 4),
                    child: Row(
                      children: [
                        TextButton(
                          autofocus: false,
                          key: const ValueKey('TextButton'),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30)))),
                          onPressed: () {
                            showDTpicker(context, t: provider.taksModel.endTime)
                                .then((t) {
                              if (t != null) {
                                provider.onModelChange(
                                  endTime: t.millisecondsSinceEpoch,
                                );
                              }
                            });
                          },
                          child: Text(
                              provider.taksModel.endTime != null
                                  ? convertT2DT(
                                      provider.taksModel.endTime!.toInt())
                                  : 'Select end time⏳',
                              overflow: TextOverflow.ellipsis,
                              style: themeData.textTheme.titleMedium?.copyWith(
                                  fontSize: 12,
                                  color: themeData.textTheme.titleMedium?.color
                                      ?.withOpacity(.7))),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: !isUpdate
            ? null
            : MediaQuery.of(context).viewInsets.bottom != 0
                ? null
                : const BtmControllWidget());
  }

  void _delteTask(BuildContext context) {
    dialogBuilder(context, nlabel: 'No', ylabel: 'Yes', title: 'Delete ?',
        nonTap: () {
      Navigator.pop(context);
    }, yonTap: () {
      context.read<TaskProvider>().onDelet().then((b) {
        if (b) {
          Navigator.of(context)
            ..pop()
            ..pop();
        }
      });
    });
  }
}

@immutable
class TaskDetailPage extends StatelessWidget {
  final TaksModel? item;

  const TaskDetailPage({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(
        item,
        isUpdate: item != null,
      ),
      child: _Injection(
        item: item,
        key: key,
      ),
    );
  }
}
