// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonGroupAdapter extends TypeAdapter<PersonGroup> {
  @override
  final int typeId = 3;

  @override
  PersonGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonGroup(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      assignments: (fields[3] as List)?.cast<AssignmentElement>(),
      list: (fields[4] as List)?.cast<Person>(),
      person: fields[5] as Person,
    );
  }

  @override
  void write(BinaryWriter writer, PersonGroup obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.assignments)
      ..writeByte(4)
      ..write(obj.list)
      ..writeByte(5)
      ..write(obj.person);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
