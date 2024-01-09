// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_group_element.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PositionGroupElementAdapter extends TypeAdapter<PositionGroupElement> {
  @override
  final int typeId = 11;

  @override
  PositionGroupElement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionGroupElement(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      endDate: fields[3] as DateTime,
      updatedBy: fields[4] as String,
      jobGroup: fields[5] as JobGroup,
      maxPersons: fields[6] as int,
      startDate: fields[7] as DateTime,
      organizationGroupExt: fields[8] as OrganizationGroupExt,
      fte: fields[9] as num,
      positionFullNameLang1: fields[10] as String,
      positionFullNameLang2: fields[11] as String,
      positionFullNameLang3: fields[12] as String,
      managerFlag: fields[13] as bool,
      positionStatus: fields[14] as EmployeeCategory,
      positionNameLang1: fields[15] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PositionGroupElement obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.updatedBy)
      ..writeByte(5)
      ..write(obj.jobGroup)
      ..writeByte(6)
      ..write(obj.maxPersons)
      ..writeByte(7)
      ..write(obj.startDate)
      ..writeByte(8)
      ..write(obj.organizationGroupExt)
      ..writeByte(9)
      ..write(obj.fte)
      ..writeByte(10)
      ..write(obj.positionFullNameLang1)
      ..writeByte(11)
      ..write(obj.positionFullNameLang2)
      ..writeByte(12)
      ..write(obj.positionFullNameLang3)
      ..writeByte(13)
      ..write(obj.managerFlag)
      ..writeByte(14)
      ..write(obj.positionStatus)
      ..writeByte(15)
      ..write(obj.positionNameLang1);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionGroupElementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
