// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FileDescriptor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileDescriptorAdapter extends TypeAdapter<FileDescriptor> {
  @override
  final int typeId = 1;

  @override
  FileDescriptor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileDescriptor(
      entityName: fields[0] as String,
      id: fields[1] as String,
      extension: fields[2] as String,
      name: fields[3] as String,
      createDate: fields[5] as DateTime,
    )..url = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, FileDescriptor obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.extension)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.createDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileDescriptorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
