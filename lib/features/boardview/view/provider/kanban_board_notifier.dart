import 'package:flutter/material.dart';
import 'package:timetracking/features/boardview/view/provider/baseprovider.dart';

import 'package:timetracking/features/boardview/models/models.dart';
import 'package:timetracking/main.dart';
import 'package:timetracking/utils/util.dart';

class KanbanBoardProvider extends ChangeNotifier
    implements BaseKanbanBoardProvider {
  late KanbanModel _kanbanModel;
  late List<KColumn> _columns;
  late bool _isUpdate = false;
  bool _changed = false;
  bool get isUpdate => _isUpdate;
  List<KColumn> get columns => _columns;
  KanbanModel get kanbanModel => _kanbanModel;
  final int? _index;
  KanbanBoardProvider(KanbanModel? kanbanModel, this._index) {
    _kanbanModel = kanbanModel ?? const KanbanModel();
    _columns = kanbanModel?.children ?? [];
    _isUpdate = _columns.isNotEmpty;
  }

  void deleteItem(int columnIndex, KTask task) async {
    _columns[columnIndex].children.remove(task);
    _refresh();
  }

  void handleReOrder(int oldIndex, int newIndex, int index) {
    if (oldIndex != newIndex) {
      final task = _columns[index].children[oldIndex];
      _columns[index].children.remove(task);
      _columns[index].children.insert(newIndex, task);
    }

    _refresh();
  }

  void addColumn(String title) {
    _columns.add(KColumn(
      title: title,
      children: List.of([]),
    ));

    _refresh();
  }

  void addTask(String title, int column) {
    _columns[column].children.add(KTask(title: title, subtitle: ''));

    _refresh();
  }

  void dragHandler(KData data, int index) {
    _columns[data.from].children.remove(data.task);
    _columns[index].children.add(data.task);

    _refresh();
  }

  void _refresh() {
    _changed = true;
    _kanbanModel = _kanbanModel.copyWith(children: _columns);
    notifyListeners();
  }

  @override
  void dispose() {
    if (_changed && _isUpdate) {
      onUpdate();
    }
    super.dispose();
  }

  @override
  Future<bool> onAdd() async {
    if (_columns.isNotEmpty) {
      if (_kanbanModel.title == null) {
        _toast('Title');
        return false;
      } else {
        var id = _getId();
        _kanbanModel = _kanbanModel.copyWith(
          addTime: getUnixT(),
          children: _columns,
          id: id,
          title: _kanbanModel.title,
          mode: shared.emoji.value,
        );
        await boardService.add<KanbanModel>(_kanbanModel);
        toast('Saved successfully');
        _changed = false;
        return true;
      }
    } else {
      return false;
    }
  }

  void _toast(String s) {
    toast('Fill $s !');
  }

  @override
  Future<bool> onDelet() async {
    bool b = false;
    await boardService.delete(_index!).catchError((e) {
      b = true;
    });
    return !b;
  }

  @override
  void onModelChange({int? c, String? title}) {
    _kanbanModel = _kanbanModel.copyWith(
      color: c,
      title: title,
    );
    _refresh();
  }

  @override
  void onUpdate() async {
    await boardService.update(_index!, kanbanModel).whenComplete(() {
      toast('updated successfully');
    });
  }

  int _getId() {
    var timestamp = getTimeNow().millisecondsSinceEpoch;
    int id = timestamp % 1000000000;

    return id;
  }
}
