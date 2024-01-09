// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final int typeId = 16;

  @override
  Person read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Person(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      endDate: fields[3] as DateTime,
      fistLastNameLatin: fields[4] as String,
      employeeNumber: fields[5] as String,
      createTs: fields[6] as DateTime,
      group: fields[7] as GroupElement,
      fioWithEmployeeNumber: fields[8] as String,
      version: fields[9] as int,
      fullNameLatin: fields[11] as String,
      fullNameCyrillic: fields[12] as String,
      firstName: fields[13] as String,
      fullNameNumberCyrillic: fields[15] as String,
      shortName: fields[16] as String,
      startDate: fields[17] as DateTime,
      lastNameLatin: fields[18] as String,
      lastName: fields[19] as String,
      firstNameLatin: fields[20] as String,
      firstLastName: fields[21] as String,
      hireDate: fields[22] as DateTime,
      fullName: fields[23] as String,
      dateOfBirth: fields[24] as DateTime,
      createdBy: fields[25] as String,
      fioWithEmployeeNumberWithSortSupported: fields[26] as String,
      updateTs: fields[27] as DateTime,
      nationalIdentifier: fields[10] as String,
      middleName: fields[14] as String,
      image: fields[28] as FileDescriptor,
      sex: fields[29] as AbstractDictionary,
    );
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer
      ..writeByte(30)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.fistLastNameLatin)
      ..writeByte(5)
      ..write(obj.employeeNumber)
      ..writeByte(6)
      ..write(obj.createTs)
      ..writeByte(7)
      ..write(obj.group)
      ..writeByte(8)
      ..write(obj.fioWithEmployeeNumber)
      ..writeByte(9)
      ..write(obj.version)
      ..writeByte(10)
      ..write(obj.nationalIdentifier)
      ..writeByte(11)
      ..write(obj.fullNameLatin)
      ..writeByte(12)
      ..write(obj.fullNameCyrillic)
      ..writeByte(13)
      ..write(obj.firstName)
      ..writeByte(14)
      ..write(obj.middleName)
      ..writeByte(29)
      ..write(obj.sex)
      ..writeByte(15)
      ..write(obj.fullNameNumberCyrillic)
      ..writeByte(16)
      ..write(obj.shortName)
      ..writeByte(17)
      ..write(obj.startDate)
      ..writeByte(18)
      ..write(obj.lastNameLatin)
      ..writeByte(19)
      ..write(obj.lastName)
      ..writeByte(20)
      ..write(obj.firstNameLatin)
      ..writeByte(21)
      ..write(obj.firstLastName)
      ..writeByte(22)
      ..write(obj.hireDate)
      ..writeByte(23)
      ..write(obj.fullName)
      ..writeByte(24)
      ..write(obj.dateOfBirth)
      ..writeByte(25)
      ..write(obj.createdBy)
      ..writeByte(26)
      ..write(obj.fioWithEmployeeNumberWithSortSupported)
      ..writeByte(27)
      ..write(obj.updateTs)
      ..writeByte(28)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
