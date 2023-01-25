import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timetracking/features/task/model/task_model.dart';
import 'package:timetracking/features/home/view/widget/widget.dart';
import 'package:timetracking/features/task/model/weeke_model.dart';
import 'package:timetracking/features/widgets/widgets.dart';
import 'widget/task_item_widget.dart';
import 'widget/to_csv_widget.dart';
import 'widget/weeke_widget.dart';

@immutable
class TaskPage<T> extends StatefulWidget {
  final ValueListenable<T> tasklistener;
  final WeekeModel weekeModel;
  const TaskPage(
      {super.key, required this.weekeModel, required this.tasklistener});

  @override
  State<TaskPage<T>> createState() => _TaskPageState<T>();
}

class _TaskPageState<T> extends State<TaskPage<T>> {
  late final Random _random = Random();
  late final ValueNotifier<List<String>> _state;
  late List<dynamic> list = [];

  @override
  void initState() {
    super.initState();
    _state = ValueNotifier(['Active', _random.nextInt(10).toString()]);
    _random.nextBool();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addListener();
    });
  }

  void refresh() {
    _state.value = [_state.value[0], _random.nextInt(10).toString()];
  }

  void addListener() {
    _state.addListener(typeChangeListener);
    widget.tasklistener.addListener(refresh);
    typeChangeListener();

    refresh();
  }

  int _getIndex(int i) {
    int reversedIndex = list.length - 1 - i;
    return reversedIndex;
  }

  void typeChangeListener() {
    var t = widget.tasklistener.value;
    t as Box<dynamic>;
    list = _sort(t.values.toList(), _state.value[0]);
  }

  @override
  void dispose() {
    _state.removeListener(typeChangeListener);
    widget.tasklistener.removeListener(refresh);
    _state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ValueListenableBuilder<List<String>>(
              valueListenable: _state,
              builder: (context, s, child) => Row(children: [
                    ToCsvBtnWidget(tasks: list),
                    const Spacer(),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _state.value = ['Active', 'a'];
                          },
                          child: BorderBtnWidget(
                              selcted: s[0] == 'Active',
                              child: const Text('Active')),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                            onTap: () {
                              _state.value = ['Done', 'd'];
                            },
                            child: BorderBtnWidget(
                                selcted: s[0] == 'Done',
                                child: const Text('Done'))),
                      ],
                    ),
                  ])),
        ),
        WeekeWidget(weeke: widget.weekeModel),
        Expanded(
            child: ValueListenableBuilder<List<String>>(
          key: const ValueKey('ValueListenableBuilder'),
          valueListenable: _state,
          builder: (context, s, child) {
            return ListviewBuilderWidget(
                itemCount: list.length,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 8)
                    .copyWith(bottom: 20),
                itemBuilder: (context, index) {
                  var data = list[index] as TaksModel;
                  return TaskItemWidget(data);
                });
          },
        )),
      ],
    );
  }
}

List _sort(List l, String s) {
  List list = [];
  for (var e in l) {
    e as TaksModel;
    if (e.status == s) {
      list.add(e);
    }
  }
  return list.reversed.toList();
}
