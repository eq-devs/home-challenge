import 'package:flutter/material.dart';
import 'package:timetracking/constants/app_const.dart';
import 'package:timetracking/utils/util.dart';

class WeekeModel {
  late List<_WeekeModel> _w = [];
  final _t = getTimeNow().weekday;
  WeekeModel() {
    _w = List.generate(7, (index) {
      index = index + 1;
      return _WeekeModel(AppConst.weeke[index]!, index == _t);
    });
  }
  List<_WeekeModel> getWeeke() {
    return _w;
  }
}

@immutable
class _WeekeModel {
  final String weeke;
  final bool today;
  const _WeekeModel(this.weeke, this.today);
}
