// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaksModelAdapter extends TypeAdapter<TaksModel> {
  @override
  final int typeId = 1;

  @override
  TaksModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaksModel(
      title: fields[0] as String?,
      discrption: fields[1] as String?,
      id: fields[2] == null ? 0 : fields[2] as int?,
      hashtag: fields[3] as String?,
      color: fields[4] as int?,
      endTime: fields[5] as int?,
      status: fields[6] as String?,
      spendTime: fields[7] as int?,
      addtime: fields[8] as int?,
      updatetime: fields[9] as int?,
      mode: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TaksModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.discrption)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.hashtag)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.endTime)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.spendTime)
      ..writeByte(8)
      ..write(obj.addtime)
      ..writeByte(9)
      ..write(obj.updatetime)
      ..writeByte(10)
      ..write(obj.mode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaksModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
