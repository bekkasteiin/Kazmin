// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abstract_dictionary.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AbstractDictionaryAdapter extends TypeAdapter<AbstractDictionary> {
  @override
  final int typeId = 0;

  @override
  AbstractDictionary read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AbstractDictionary(
      active: fields[24] as bool,
      code: fields[22] as String,
      color: fields[29] as String,
      createdBy: fields[4] as String,
      createTs: fields[3] as DateTime,
      customField1: fields[30] as String,
      deletedBy: fields[8] as String,
      deleteTs: fields[7] as DateTime,
      description1: fields[11] as String,
      description2: fields[13] as String,
      description3: fields[15] as String,
      description4: fields[17] as String,
      description5: fields[19] as String,
      endDate: fields[21] as DateTime,
      entityName: fields[2] as String,
      id: fields[0] as String,
      instanceName: fields[28] as String,
      isDefault: fields[31] as bool,
      isSystemRecord: fields[23] as bool,
      langValue1: fields[10] as String,
      langValue2: fields[12] as String,
      langValue3: fields[14] as String,
      langValue4: fields[16] as String,
      langValue5: fields[18] as String,
      languageValue: fields[32] as String,
      legacyId: fields[9] as String,
      name: fields[26] as String,
      amount: fields[37] as double,
      order: fields[25] as int,
      rate: fields[27] as num,
      startDate: fields[20] as DateTime,
      updatedBy: fields[6] as String,
      updateTs: fields[5] as DateTime,
      version: fields[1] as int,
      absencePurpose: fields[33] as String,
      langValueOrig: fields[34] as String,
      langValueLocale: fields[35] as String,
      closeRelative: fields[36] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AbstractDictionary obj) {
    writer
      ..writeByte(38)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.version)
      ..writeByte(2)
      ..write(obj.entityName)
      ..writeByte(3)
      ..write(obj.createTs)
      ..writeByte(4)
      ..write(obj.createdBy)
      ..writeByte(5)
      ..write(obj.updateTs)
      ..writeByte(6)
      ..write(obj.updatedBy)
      ..writeByte(7)
      ..write(obj.deleteTs)
      ..writeByte(8)
      ..write(obj.deletedBy)
      ..writeByte(9)
      ..write(obj.legacyId)
      ..writeByte(10)
      ..write(obj.langValue1)
      ..writeByte(11)
      ..write(obj.description1)
      ..writeByte(12)
      ..write(obj.langValue2)
      ..writeByte(13)
      ..write(obj.description2)
      ..writeByte(14)
      ..write(obj.langValue3)
      ..writeByte(15)
      ..write(obj.description3)
      ..writeByte(16)
      ..write(obj.langValue4)
      ..writeByte(17)
      ..write(obj.description4)
      ..writeByte(18)
      ..write(obj.langValue5)
      ..writeByte(19)
      ..write(obj.description5)
      ..writeByte(20)
      ..write(obj.startDate)
      ..writeByte(21)
      ..write(obj.endDate)
      ..writeByte(22)
      ..write(obj.code)
      ..writeByte(23)
      ..write(obj.isSystemRecord)
      ..writeByte(24)
      ..write(obj.active)
      ..writeByte(25)
      ..write(obj.order)
      ..writeByte(26)
      ..write(obj.name)
      ..writeByte(27)
      ..write(obj.rate)
      ..writeByte(28)
      ..write(obj.instanceName)
      ..writeByte(29)
      ..write(obj.color)
      ..writeByte(30)
      ..write(obj.customField1)
      ..writeByte(31)
      ..write(obj.isDefault)
      ..writeByte(32)
      ..write(obj.languageValue)
      ..writeByte(33)
      ..write(obj.absencePurpose)
      ..writeByte(34)
      ..write(obj.langValueOrig)
      ..writeByte(35)
      ..write(obj.langValueLocale)
      ..writeByte(36)
      ..write(obj.closeRelative)
      ..writeByte(37)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbstractDictionaryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
