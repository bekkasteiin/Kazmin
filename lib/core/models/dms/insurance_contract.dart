import 'dart:convert';

import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/dms/contract_administrator.dart';
import 'package:kzm/core/models/dms/contract_assistance.dart';
import 'package:kzm/core/models/dms/contract_conditions.dart';

class InsuranceContract {
  InsuranceContract({
    this.entityName,
    this.instanceName,
    this.id,
    this.attachments,
    this.attachingFamily,
    this.signDate,
    this.insuranceProgram,
    this.company,
    this.expirationDate,
    this.programConditions,
    this.availabilityPeriodTo,
    this.attachingAnEmployee,
    this.policyName,
    this.contract,
    this.startDate,
    this.contractAdministrator,
    this.availabilityPeriodFrom,
    this.notificationDate,
    // this.assistance
  });

  String entityName;
  String instanceName;
  String id;
  List<ContractFile> attachments;
  int attachingFamily;
  DateTime signDate;
  String insuranceProgram;
  AbstractDictionary company;
  DateTime expirationDate;
  List<ContractConditions> programConditions;
  DateTime availabilityPeriodTo;
  int attachingAnEmployee;
  String policyName;
  String contract;
  DateTime startDate;
  List<ContractAdministrator> contractAdministrator;
  DateTime availabilityPeriodFrom;
  DateTime notificationDate;
  // ContractAssistance assistance;

  factory InsuranceContract.fromJson(String str) => InsuranceContract.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InsuranceContract.fromMap(Map<String, dynamic> json) => InsuranceContract(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
      //  assistance: json['assistance'] == null ? null : ContractAssistance.fromMap(json['assistance']),
        attachments: json['attachments'] == null ? null : List<ContractFile>.from(json['attachments'].map((x) => ContractFile.fromMap(x))),
        attachingFamily: json['attachingFamily'],
        signDate: json['signDate'] == null ? null : DateTime.parse(json['signDate']),
        insuranceProgram: json['insuranceProgram'],
        company: json['company'] == null ? null : AbstractDictionary.fromMap(json['company']),
        expirationDate: json['expirationDate'] == null ? null : DateTime.parse(json['expirationDate']),
        programConditions:
            json['programConditions'] == null ? null : List<ContractConditions>.from(json['programConditions'].map((x) => ContractConditions.fromMap(x))),
        availabilityPeriodTo: json['availabilityPeriodTo'] == null ? null : DateTime.parse(json['availabilityPeriodTo']),
        attachingAnEmployee: json['attachingAnEmployee'],
        policyName: json['policyName'],
        contract: json['contract'],
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate']),
        contractAdministrator: json['contractAdministrator'] == null
            ? null
            : List<ContractAdministrator>.from(json['contractAdministrator'].map((x) => ContractAdministrator.fromMap(x))),
        availabilityPeriodFrom: json['availabilityPeriodFrom'] == null ? null : DateTime.parse(json['availabilityPeriodFrom']),
        notificationDate: json['notificationDate'] == null ? null : DateTime.parse(json['notificationDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
       // 'assistance': assistance == null ? null : assistance.toMapId(),
        // "attachments": attachments == null ? null : List<FileDescriptor>.from(attachments.map((x) => x.toMap())),
        // "attachingFamily": attachingFamily == null ? null : attachingFamily,
        // "signDate": signDate == null ? null : "${signDate.year.toString().padLeft(4, '0')}-${signDate.month.toString().padLeft(2, '0')}-${signDate.day.toString().padLeft(2, '0')}",
        // "insuranceProgram": insuranceProgram == null ? null : insuranceProgram,
        // "company": company == null ? null : company.toMap(),
        // "expirationDate": expirationDate == null ? null : "${expirationDate.year.toString().padLeft(4, '0')}-${expirationDate.month.toString().padLeft(2, '0')}-${expirationDate.day.toString().padLeft(2, '0')}",
        // "programConditions": programConditions == null ? null : List<dynamic>.from(programConditions.map((x) => x)),
        // "availabilityPeriodTo": availabilityPeriodTo == null ? null : "${availabilityPeriodTo.year.toString().padLeft(4, '0')}-${availabilityPeriodTo.month.toString().padLeft(2, '0')}-${availabilityPeriodTo.day.toString().padLeft(2, '0')}",
        // "attachingAnEmployee": attachingAnEmployee == null ? null : attachingAnEmployee,
        // "policyName": policyName == null ? null : policyName,
        // "contract": contract == null ? null : contract,
        // "startDate": startDate == null ? null : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        // "contractAdministrator": contractAdministrator == null ? null : List<ContractConditions>.from(contractAdministrator.map((x) => x.toMap())),
        // "availabilityPeriodFrom": availabilityPeriodFrom == null ? null : "${availabilityPeriodFrom.year.toString().padLeft(4, '0')}-${availabilityPeriodFrom.month.toString().padLeft(2, '0')}-${availabilityPeriodFrom.day.toString().padLeft(2, '0')}",
        // "notificationDate": notificationDate == null ? null : "${notificationDate.year.toString().padLeft(4, '0')}-${notificationDate.month.toString().padLeft(2, '0')}-${notificationDate.day.toString().padLeft(2, '0')}",
      };
}

class ContractFile {
  ContractFile({
    this.entityName,
    this.instanceName,
    this.id,
    this.attachment,
  });

  String entityName;
  String instanceName;
  String id;
  FileDescriptor attachment;

  factory ContractFile.fromJson(String str) => ContractFile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ContractFile.fromMap(Map<String, dynamic> json) => ContractFile(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    attachment: json["attachment"] == null ? null : FileDescriptor.fromMap(json["attachment"]),
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "attachment": attachment == null ? null : attachment.toMap(),
  };
}
