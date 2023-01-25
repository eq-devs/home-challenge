import 'package:flutter/material.dart';

import 'package:timetracking/services/model.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@immutable
@HiveType(typeId: 1)
class TaksModel implements Model {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? discrption;
  @HiveField(2, defaultValue: 0)
  final int? id;
  @HiveField(3)
  final String? hashtag;
  @HiveField(4)
  final int? color;
  @HiveField(5)
  final int? endTime;
  @HiveField(6)
  final String? status;
  @HiveField(7)
  final int? spendTime;
  @HiveField(8)
  final int? addtime;
  @HiveField(9)
  final int? updatetime;
  @HiveField(10)
  final String? mode;

  const TaksModel({
    this.title,
    this.discrption,
    this.id,
    this.hashtag,
    this.color,
    this.endTime,
    this.status,
    this.spendTime,
    this.addtime,
    this.updatetime,
    this.mode,
  });
  factory TaksModel.empty() => const TaksModel();

  @override
  TaksModel copyWith(
          {String? title,
          String? discrption,
          int? id,
          String? hashtag,
          int? color,
          int? endTime,
          int? spendTime,
          int? addtime,
          int? updatetime,
          String? status,
          String? mode}) =>
      TaksModel(
        updatetime: updatetime ?? this.updatetime,
        addtime: addtime ?? this.addtime,
        title: title ?? this.title,
        discrption: discrption ?? this.discrption,
        id: id ?? this.id,
        hashtag: hashtag ?? this.hashtag,
        color: color ?? this.color,
        endTime: endTime ?? this.endTime,
        spendTime: spendTime ?? this.spendTime,
        status: status ?? this.status,
        mode: mode ?? this.mode,
      );

  @override
  fromJson() {}

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'discrption': discrption,
      'hashtag': hashtag,
      'color': color,
      'endTime': endTime,
      'status': status,
      'spendTime': spendTime,
      'addtime': addtime,
      'updatetime': updatetime,
    };
  }
}
