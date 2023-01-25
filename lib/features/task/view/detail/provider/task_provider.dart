import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timetracking/features/task/model/task_model.dart';
import 'package:timetracking/features/task/view/detail/provider/baseprovider.dart';
import 'package:timetracking/main.dart';
import 'package:timetracking/utils/util.dart';

class TaskProvider with ChangeNotifier implements BaseTaskProvider {
  late TaksModel _taksModel;
  final bool isUpdate;
  late ValueNotifier<bool> _play;
  late ValueNotifier<int> _time;
  Timer? _timer;
  ValueNotifier<int> get time => _time;
  ValueNotifier<bool> get play => _play;

  TaksModel get taksModel => _taksModel;

  TaskProvider(TaksModel? taksModel, {required this.isUpdate}) {
    _taksModel = taksModel ?? const TaksModel();
    if (isUpdate) {
      _time = ValueNotifier(_taksModel.spendTime ?? 0);
      _play = ValueNotifier(false);
    } else {
      taksModel = TaksModel.empty();
    }
  }

  bool _changed = false;
  @override
  void dispose() {
    if (isUpdate) {
      onUpdate();
      _time.dispose();
      _play.dispose();
      if (_timer != null) {
        _timer!.cancel();
      }
    }
    super.dispose();
  }

  @override
  void onPlay(bool b) {
    if (!b) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        _time.value++;
      });
    } else {
      if (_timer != null) {
        if (_timer!.isActive) _timer?.cancel();
      }
    }
    _play.value = !b;
    _changed = true;
  }

  @override
  Future<void> onDone() async {
    _taksModel = _taksModel.copyWith(status: 'Done');
    await taskService.update<TaksModel>(taksModel.id!, _taksModel);
    if (_timer != null) _timer!.cancel();
    if (_play.value) {
      _play.value = false;
    }

    notifyListeners();
  }

  @override
  void onUpdate() {
    if (_changed) {
      taskService.update<TaksModel>(
          taksModel.id!, _taksModel.copyWith(spendTime: _time.value));
      toast('Updated');
    }
  }

  @override
  Future<bool> onDelet() async {
    bool b = false;
    await taskService.delete(_taksModel.id!).catchError((e) {
      b = false;
      toast(e.toString());
    });
    toast('Deleted successfully');

    return !b;
  }

  @override
  Future<bool> onAdd() async {
    if (_taksModel.title == null) {
      _toast('title');
    } else if (_taksModel.discrption == null) {
      _toast('discrption');
    } else if (_taksModel.endTime == null) {
      _toast('endTime');
    } else if (_taksModel.color == null) {
      _toast('color');
    } else {
      // var id = _getId();
      var id = _getId();
      var time = getUnixT();
      _taksModel = _taksModel.copyWith(
        addtime: time,
        updatetime: time,
        hashtag: 'New',
        id: id,
        status: 'Active',
        spendTime: 0,
        mode: shared.emoji.value,
      );
      taskService.add<TaksModel>(_taksModel);
      toast('Saved successfully');
      return true;
    }

    return false;
  }

  void _toast(String s) {
    toast('Fill $s !');
  }

  @override
  void onModelChange(
      {String? title, String? discrption, int? color, int? endTime}) {
    _taksModel = _taksModel.copyWith(
        title: title, discrption: discrption, color: color, endTime: endTime);
     
    _changed = true;
    notifyListeners();
  }

  void deleteAll() {
    taskService.deleteAll();
  }

  int _getId() {
    var timestamp = getTimeNow().millisecondsSinceEpoch;
    int id = timestamp % 1000000000;

    return id;
  }
}
