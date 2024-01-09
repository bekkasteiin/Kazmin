// To parse this JSON data, do
//
//     final insuredPerson = insuredPersonFromMap(jsonString);

import 'dart:convert';

import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/dms/contract_assistance.dart';
import 'package:kzm/core/models/dms/insurance_contract.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/position/job_group.dart';

class InsuredPerson {
  InsuredPerson(
      {this.entityName,
      this.instanceName,
      this.id,
      this.statusRequest,
      this.birthdate,
      this.documentType,
      this.documentNumber,
      this.employee,
      this.insuranceProgram,
      this.type,
      this.iin,
      this.file,
      this.company,
      this.secondName,
      this.amount,
      this.address,
      this.insuranceContract,
      this.sex,
      this.firstName,
      this.totalAmount,
      this.attachDate,
      this.region,
      this.relative,
      this.middleName,
      this.statementFile,
      this.addressType,
      this.job,
      this.jobMember,
      this.phoneNumber,
      this.assistance,
      this.exclusionDate
      });

  String entityName;
  String instanceName;
  String id;
  AbstractDictionary statusRequest;
  DateTime birthdate;
  AbstractDictionary documentType;
  String documentNumber;
  PersonGroup employee;
  String insuranceProgram;
  String type;
  String iin;
  List<FileDescriptor> file;
  FileDescriptor statementFile;
  AbstractDictionary company;
  String secondName;
  String middleName;
  double amount;
  String address;
  AbstractDictionary addressType;
  InsuranceContract insuranceContract;
  AbstractDictionary sex;
  String firstName;
  double totalAmount;
  DateTime attachDate;
  DateTime exclusionDate;
  AbstractDictionary region;
  AbstractDictionary relative;
  JobGroup job;
  String jobMember;
  String phoneNumber;
  ContractAssistance assistance;

  factory InsuredPerson.fromJson(String str) => InsuredPerson.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InsuredPerson.fromMap(Map<String, dynamic> json) => InsuredPerson(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        statusRequest: json['statusRequest'] == null ? null : AbstractDictionary.fromMap(json['statusRequest']),
        birthdate: json['birthdate'] == null ? null : DateTime.parse(json['birthdate']),
        documentType: json['documentType'] == null ? null : AbstractDictionary.fromMap(json['documentType']),
        addressType: json['addressType'] == null ? null : AbstractDictionary.fromMap(json['addressType']),
        documentNumber: json['documentNumber'],
        employee: json['employee'] == null ? null : PersonGroup.fromMap(json['employee']),
        assistance: json['assistance'] == null ? null : ContractAssistance.fromMap(json['assistance']),
        job: json['job'] == null ? null : JobGroup.fromMap(json['job']),
        insuranceProgram: json['insuranceProgram'],
        type: json['type'],
        iin: json['iin'],
        jobMember: json['jobMember'],
        file: json['file'] == null ? null : List<FileDescriptor>.from(json['file'].map((x) => FileDescriptor.fromMap(x))),
        company: json['company'] == null ? null : AbstractDictionary.fromMap(json['company']),
        secondName: json['secondName'],
        middleName: json['middleName'],
        amount: json['amount'] == null ? null : json['amount'].toDouble(),
        address: json['address'],
        insuranceContract: json['insuranceContract'] == null ? null : InsuranceContract.fromMap(json['insuranceContract']),
        statementFile: json['statementFile'] == null ? null : FileDescriptor.fromMap(json['statementFile']),
        sex: json['sex'] == null ? null : AbstractDictionary.fromMap(json['sex']),
        firstName: json['firstName'],
        phoneNumber: json['phoneNumber'],
        totalAmount: json['totalAmount'] == null ? null : json['totalAmount'].toDouble(),
        attachDate: json['attachDate'] == null ? null : DateTime.parse(json['attachDate']),
        exclusionDate: json['exclusionDate'] == null ? null : DateTime.parse(json['exclusionDate']),
        region: json['region'] == null ? null : AbstractDictionary.fromMap(json['region']),
        relative: json['relative'] == null ? null : AbstractDictionary.fromMap(json['relative']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id ?? '',
        'statusRequest': statusRequest == null ? null : statusRequest.toMap(),
        'birthdate': birthdate == null ? null : formatFullRest(birthdate),
        'documentType': documentType == null ? null : documentType.toMap(),
        'addressType': addressType == null ? null : addressType.toMap(),
        'documentNumber': documentNumber,
        'jobMember': jobMember,
        'employee': employee == null ? null : employee.toMapId(),
        'assistance': assistance == null ? null : assistance.toMapId(),
        'insuranceProgram': insuranceProgram,
        'type': type,
        'iin': iin,
        'file': file == null ? null : List<dynamic>.from(file.map((FileDescriptor x) => x.toMap())),
        'company': company == null ? null : company.toMap(),
        'secondName': secondName,
        'middleName': middleName,
        'amount': amount,
        'address': address,
        'phoneNumber': phoneNumber,
        'insuranceContract': insuranceContract == null ? null : insuranceContract.toMap(),
        'job': job == null ? null : job.toMap(),
        'statementFile': statementFile == null ? null : statementFile.toMap(),
        'sex': sex == null ? null : sex.toMap(),
        'firstName': firstName,
        'totalAmount': totalAmount,
        'attachDate': attachDate == null ? null : formatFullRest(attachDate),
        // 'exclusionDate': exclusionDate == null ? null : formatFullRest(exclusionDate),
        'region': region == null ? null : region.toMap(),
        'relative': relative == null ? null : relative.toMap(),
      };
}
