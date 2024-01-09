// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationTemplateAdapter extends TypeAdapter<NotificationTemplate> {
  @override
  final int typeId = 13;

  @override
  NotificationTemplate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationTemplate(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      notificationHeaderKz: fields[3] as String,
      notificationHeaderEn: fields[4] as String,
      notificationBodyKz: fields[5] as String,
      description: fields[6] as String,
      referenceId: fields[7] as String,
      notificationBodyEn: fields[8] as String,
      nameRu: fields[9] as String,
      notificationTemplateCode: fields[10] as String,
      notificationHeaderRu: fields[11] as String,
      nameKz: fields[12] as String,
      notificationBodyRu: fields[13] as String,
      notificationBody: fields[23] as String,
      nameEn: fields[14] as String,
      startDateTime: fields[15] as DateTime,
      updateTs: fields[22] as DateTime,
      status: fields[16] as String,
      type: fields[17] as ActivityType,
      name: fields[18] as String,
      createTs: fields[19] as DateTime,
      link: fields[20] as String,
      entityId: fields[21] as String,
      notificationHeader: fields[25] as String,
      version: fields[24] as int,
      createdBy: fields[26] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationTemplate obj) {
    writer
      ..writeByte(27)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.notificationHeaderKz)
      ..writeByte(4)
      ..write(obj.notificationHeaderEn)
      ..writeByte(5)
      ..write(obj.notificationBodyKz)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.referenceId)
      ..writeByte(8)
      ..write(obj.notificationBodyEn)
      ..writeByte(9)
      ..write(obj.nameRu)
      ..writeByte(10)
      ..write(obj.notificationTemplateCode)
      ..writeByte(11)
      ..write(obj.notificationHeaderRu)
      ..writeByte(12)
      ..write(obj.nameKz)
      ..writeByte(13)
      ..write(obj.notificationBodyRu)
      ..writeByte(14)
      ..write(obj.nameEn)
      ..writeByte(15)
      ..write(obj.startDateTime)
      ..writeByte(16)
      ..write(obj.status)
      ..writeByte(17)
      ..write(obj.type)
      ..writeByte(18)
      ..write(obj.name)
      ..writeByte(19)
      ..write(obj.createTs)
      ..writeByte(20)
      ..write(obj.link)
      ..writeByte(21)
      ..write(obj.entityId)
      ..writeByte(22)
      ..write(obj.updateTs)
      ..writeByte(23)
      ..write(obj.notificationBody)
      ..writeByte(25)
      ..write(obj.notificationHeader)
      ..writeByte(24)
      ..write(obj.version)
      ..writeByte(26)
      ..write(obj.createdBy);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationTemplateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
