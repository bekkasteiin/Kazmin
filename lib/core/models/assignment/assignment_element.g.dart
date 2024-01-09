// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_element.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssignmentElementAdapter extends TypeAdapter<AssignmentElement> {
  @override
  final int typeId = 4;

  @override
  AssignmentElement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssignmentElement(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      endDate: fields[3] as DateTime,
      primaryFlag: fields[4] as bool,
      fte: fields[5] as num,
      organizationGroup: fields[6] as GroupElement,
      personGroup: fields[7] as GroupElement,
      jobGroup: fields[8] as JobGroup,
      positionGroup: fields[9] as PositionGroup,
      startDate: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AssignmentElement obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.primaryFlag)
      ..writeByte(5)
      ..write(obj.fte)
      ..writeByte(6)
      ..write(obj.organizationGroup)
      ..writeByte(7)
      ..write(obj.personGroup)
      ..writeByte(8)
      ..write(obj.jobGroup)
      ..writeByte(9)
      ..write(obj.positionGroup)
      ..writeByte(10)
      ..write(obj.startDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssignmentElementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
