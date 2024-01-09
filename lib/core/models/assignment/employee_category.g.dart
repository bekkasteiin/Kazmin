// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeCategoryAdapter extends TypeAdapter<EmployeeCategory> {
  @override
  final int typeId = 5;

  @override
  EmployeeCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeCategory(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      langValue3: fields[3] as String,
      langValue2: fields[4] as String,
      langValue1: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeCategory obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.langValue3)
      ..writeByte(4)
      ..write(obj.langValue2)
      ..writeByte(5)
      ..write(obj.langValue1);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
