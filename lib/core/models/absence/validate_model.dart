// To parse this JSON data, do
//
//     final validateModel = validateModelFromJson(jsonString);

import 'dart:convert';

List<ValidateModel> validateModelFromJson(String str) => List<ValidateModel>.from(json.decode(str).map((x) => ValidateModel.fromJson(x)));

String validateModelToJson(List<ValidateModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ValidateModel {
  ValidateModel({
    this.type,
    this.value,
  });

  String type;
  dynamic value;

  factory ValidateModel.fromJson(Map<String, dynamic> json) => ValidateModel(
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
  };
}

class MessageValidate {
  MessageValidate({
    this.success,
    this.errorMessageRu,
    this.errorMessageEn,
    this.errorMessageKz,
  });

  bool success;
  String errorMessageRu;
  String errorMessageEn;
  String errorMessageKz;

  factory MessageValidate.fromJson(dynamic json) => MessageValidate(
    success: json["success"],
    errorMessageRu: json["error_message_ru"],
    errorMessageEn: json["error_message_en"],
    errorMessageKz: json["error_message_kz"],
  );

  Map<String, dynamic> toJson() => {
    "success": success ?? false,
    "error_message_ru": errorMessageRu ?? '',
    "error_message_en": errorMessageEn ?? '',
    "error_message_kz": errorMessageKz ?? '',
  };
}

class ContractValue {
  ContractValue({
    this.contractId,
    this.contractNumber,
  });

  String contractId;
  String contractNumber;

  factory ContractValue.fromJson(dynamic json) => ContractValue(
    contractId: json["contractId"],
    contractNumber: json["contractNumber"],
  );

  Map<String, dynamic> toJson() => {
    "contractNumber": contractNumber ?? '',
    "contractId": contractId ?? '',
  };
}

