// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KColumnAdapter extends TypeAdapter<KColumn> {
  @override
  final int typeId = 2;

  @override
  KColumn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KColumn(
      title: fields[0] as String,
      children: (fields[1] as List).cast<KTask>(),
    );
  }

  @override
  void write(BinaryWriter writer, KColumn obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.children);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KColumnAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class KDataAdapter extends TypeAdapter<KData> {
  @override
  final int typeId = 3;

  @override
  KData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KData(
      from: fields[0] as int,
      task: fields[1] as KTask,
    );
  }

  @override
  void write(BinaryWriter writer, KData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.from)
      ..writeByte(1)
      ..write(obj.task);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class KTaskAdapter extends TypeAdapter<KTask> {
  @override
  final int typeId = 4;

  @override
  KTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KTask(
      title: fields[0] as String,
      subtitle: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, KTask obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subtitle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class KanbanModelAdapter extends TypeAdapter<KanbanModel> {
  @override
  final int typeId = 5;

  @override
  KanbanModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KanbanModel(
      title: fields[0] as String?,
      addTime: fields[1] as int?,
      id: fields[2] as int?,
      children: (fields[3] as List?)?.cast<KColumn>(),
      color: fields[4] as int?,
      mode: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, KanbanModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.addTime)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.children)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.mode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KanbanModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
