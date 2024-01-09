// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_group.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobGroupAdapter extends TypeAdapter<JobGroup> {
  @override
  final int typeId = 9;

  @override
  JobGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobGroup(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      jobNameLang1: fields[3] as String,
      job: fields[4] as JobGroup,
    );
  }

  @override
  void write(BinaryWriter writer, JobGroup obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.jobNameLang1)
      ..writeByte(4)
      ..write(obj.job);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
