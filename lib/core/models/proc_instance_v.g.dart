// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proc_instance_v.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProcInstanceVAdapter extends TypeAdapter<ProcInstanceV> {
  @override
  final int typeId = 15;

  @override
  ProcInstanceV read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProcInstanceV(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      processKz: fields[3] as String,
      processEn: fields[4] as String,
      requestNumber: fields[5] as int,
      procInstanceVEntityName: fields[6] as String,
      requestDate: fields[7] as DateTime,
      startTime: fields[8] as DateTime,
      startUser: fields[9] as Person,
      active: fields[10] as bool,
      entityId: fields[11] as String,
      processRu: fields[12] as String,
      businessKey: fields[13] as String,
      status: fields[14] as AbstractDictionary,
    );
  }

  @override
  void write(BinaryWriter writer, ProcInstanceV obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.processKz)
      ..writeByte(4)
      ..write(obj.processEn)
      ..writeByte(5)
      ..write(obj.requestNumber)
      ..writeByte(6)
      ..write(obj.procInstanceVEntityName)
      ..writeByte(7)
      ..write(obj.requestDate)
      ..writeByte(8)
      ..write(obj.startTime)
      ..writeByte(9)
      ..write(obj.startUser)
      ..writeByte(10)
      ..write(obj.active)
      ..writeByte(11)
      ..write(obj.entityId)
      ..writeByte(12)
      ..write(obj.processRu)
      ..writeByte(13)
      ..write(obj.businessKey)
      ..writeByte(14)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProcInstanceVAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
