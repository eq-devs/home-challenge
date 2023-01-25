import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:timetracking/services/model.dart';

part 'models.g.dart';

@immutable
@HiveType(typeId: 2)
class KColumn implements Model {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<KTask> children;
  const KColumn({required this.title, required this.children});

  @override
  KColumn copyWith({
    String? title,
    List<KTask>? children,
  }) {
    return KColumn(
      children: children ?? this.children,
      title: title ?? this.title,
    );
  }

  @override
  fromJson() {
    throw UnimplementedError();
  }

  @override
  Map toJson() {
    throw UnimplementedError();
  }
}

@immutable
@HiveType(typeId: 3)
class KData implements Model {
  @HiveField(0)
  final int from;
  @HiveField(1)
  final KTask task;
  const KData({required this.from, required this.task});

  @override
  copyWith() {
    throw UnimplementedError();
  }

  @override
  fromJson() {
    throw UnimplementedError();
  }

  @override
  Map toJson() {
    throw UnimplementedError();
  }
}

@immutable
@HiveType(typeId: 4)
class KTask implements Model {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String subtitle;
  const KTask({required this.title, required this.subtitle});

  @override
  copyWith() {
    throw UnimplementedError();
  }

  @override
  fromJson() {
    throw UnimplementedError();
  }

  @override
  Map toJson() {
    throw UnimplementedError();
  }
}

@immutable
@HiveType(typeId: 5)
class KanbanModel implements Model {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final int? addTime;
  @HiveField(2)
  final int? id;
  @HiveField(3)
  final List<KColumn>? children;
  @HiveField(4)
  final int? color;
  @HiveField(5)
  final String? mode;
  const KanbanModel(
      {this.title,
      this.addTime,
      this.id,
      this.children,
      this.color,
      this.mode});
  @override
  KanbanModel copyWith(
      {String? title,
      int? addTime,
      int? id,
      List<KColumn>? children,
      int? color,
      String? mode}) {
    return KanbanModel(
      addTime: addTime ?? this.addTime,
      children: children ?? this.children,
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      mode: mode ?? this.mode,
    );
  }

  @override
  fromJson() {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'addTime': addTime,
      'id': id,
      'children': children?.length.toString(),
      'mode': mode
    };
  }
}
