// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_group.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PositionGroupAdapter extends TypeAdapter<PositionGroup> {
  @override
  final int typeId = 10;

  @override
  PositionGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PositionGroup(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      organizationGroup: fields[4] as OrganizationGroup,
      company: fields[5] as TsadvDicMilitaryDocumentType,
      list: (fields[3] as List)?.cast<PositionGroupElement>(),
    );
  }

  @override
  void write(BinaryWriter writer, PositionGroup obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.list)
      ..writeByte(4)
      ..write(obj.organizationGroup)
      ..writeByte(5)
      ..write(obj.company);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PositionGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
