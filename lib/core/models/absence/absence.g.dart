// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AbsenceRequestAdapter extends TypeAdapter<AbsenceRequest> {
  @override
  final int typeId = 12;

  @override
  AbsenceRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AbsenceRequest(
      entityName: fields[0] as String,
      id: fields[1] as String,
      type: fields[2] as DicAbsenceType,
      absenceDays: fields[3] as int,
      personGroup: fields[4] as PersonGroup,
      dateFrom: fields[5] as DateTime,
      dateTo: fields[6] as DateTime,
      assignmentGroup: fields[8] as GroupElement,
      compensation: fields[11] as bool,
      distanceWorkingConfirm: fields[9] as bool,
      requestDate: fields[10] as DateTime,
      requestNumber: fields[12] as num,
      status: fields[7] as AbstractDictionary,
      vacationScheduleRequest: fields[13] as VacationScheduleRequest,
      reason: fields[14] as String,
      originalSheet: fields[15] as bool,
      scheduleStartDate: fields[16] as DateTime,
      scheduleEndDate: fields[17] as DateTime,
      addNextYear: fields[18] as bool,
      newStartDate: fields[19] as DateTime,
      newEndDate: fields[20] as DateTime,
      instanceName: fields[24] as String,
      periodDateFrom: fields[21] as DateTime,
      agree: fields[28] as bool,
      files: (fields[23] as List)?.cast<FileDescriptor>(),
      vacationDay: fields[29] as bool,
      periodDateTo: fields[22] as DateTime,
      startTime: fields[30] as String,
      endTime: fields[31] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AbsenceRequest obj) {
    writer
      ..writeByte(29)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.absenceDays)
      ..writeByte(4)
      ..write(obj.personGroup)
      ..writeByte(5)
      ..write(obj.dateFrom)
      ..writeByte(6)
      ..write(obj.dateTo)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.assignmentGroup)
      ..writeByte(9)
      ..write(obj.distanceWorkingConfirm)
      ..writeByte(10)
      ..write(obj.requestDate)
      ..writeByte(11)
      ..write(obj.compensation)
      ..writeByte(12)
      ..write(obj.requestNumber)
      ..writeByte(13)
      ..write(obj.vacationScheduleRequest)
      ..writeByte(14)
      ..write(obj.reason)
      ..writeByte(15)
      ..write(obj.originalSheet)
      ..writeByte(16)
      ..write(obj.scheduleStartDate)
      ..writeByte(17)
      ..write(obj.scheduleEndDate)
      ..writeByte(18)
      ..write(obj.addNextYear)
      ..writeByte(19)
      ..write(obj.newStartDate)
      ..writeByte(20)
      ..write(obj.newEndDate)
      ..writeByte(21)
      ..write(obj.periodDateFrom)
      ..writeByte(22)
      ..write(obj.periodDateTo)
      ..writeByte(23)
      ..write(obj.files)
      ..writeByte(24)
      ..write(obj.instanceName)
      ..writeByte(28)
      ..write(obj.agree)
      ..writeByte(29)
      ..write(obj.vacationDay)
      ..writeByte(30)
      ..write(obj.startTime)
      ..writeByte(31)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AbsenceRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
