// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_element.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupElementAdapter extends TypeAdapter<GroupElement> {
  @override
  final int typeId = 2;

  @override
  GroupElement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupElement(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GroupElement obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupElementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
