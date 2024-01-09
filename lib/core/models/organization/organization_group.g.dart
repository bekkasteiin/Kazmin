// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_group.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrganizationGroupExtAdapter extends TypeAdapter<OrganizationGroupExt> {
  @override
  final int typeId = 6;

  @override
  OrganizationGroupExt read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrganizationGroupExt(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      analytics: fields[3] as GroupElement,
      updatedBy: fields[4] as String,
      list: (fields[5] as List)?.cast<OrganizationGroupExtElement>(),
    );
  }

  @override
  void write(BinaryWriter writer, OrganizationGroupExt obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.analytics)
      ..writeByte(4)
      ..write(obj.updatedBy)
      ..writeByte(5)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrganizationGroupExtAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
