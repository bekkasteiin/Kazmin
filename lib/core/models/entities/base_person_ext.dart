  /*
  "_entityName": "base$PersonExt"
  */

  import 'dart:convert';

  import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/base_person_group_ext.dart';

  class BasePersonExt {
    String entityName;
    String instanceName;
    String employeeNumber;
    String endDate;
    String firstName;
    String firstNameLatin;
    String id;
    String lastName;
    String lastNameLatin;
    String middleName;
    String middleNameLatin;
    String startDate;
    String birthPlace;
    DateTime dateOfBirth;
    String fioWithEmployeeNumber;
    String fioWithEmployeeNumberWithSortSupported;
    String firstLastName;
    String fistLastNameLatin;
    String fullName;
    String fullNameLatin;
    String hireDate;
    String legacyId;
    String nationalIdentifier;
    String personName;
    String shortName;
    bool commitmentsCredit;
    String commitmentsFromPrevJob;
    bool commitmentsLoan;
    bool writeHistory;
    String criminalAdministrativeLiability;
    int version;
    String fullNameNumberCyrillic;
    String fullNameCyrillic;
    String haveNDA;
    String childUnder18WithoutFatherOrMother;
    String childUnder14WithoutFatherOrMother;
    BasePersonGroupExt group;
    AbstractDictionary maritalStatus;

    BasePersonExt({
      this.entityName,
      this.instanceName,
      this.employeeNumber,
      this.endDate,
      this.firstName,
      this.firstNameLatin,
      this.id,
      this.lastName,
      this.lastNameLatin,
      this.middleName,
      this.middleNameLatin,
      this.startDate,
      this.birthPlace,
      this.dateOfBirth,
      this.fioWithEmployeeNumber,
      this.fioWithEmployeeNumberWithSortSupported,
      this.firstLastName,
      this.fistLastNameLatin,
      this.fullName,
      this.fullNameLatin,
      this.hireDate,
      this.legacyId,
      this.nationalIdentifier,
      this.personName,
      this.shortName,
      this.commitmentsCredit,
      this.commitmentsFromPrevJob,
      this.commitmentsLoan,
      this.writeHistory,
      this.criminalAdministrativeLiability,
      this.version,
      this.fullNameNumberCyrillic,
      this.haveNDA,
      this.childUnder18WithoutFatherOrMother,
      this.childUnder14WithoutFatherOrMother,
      this.fullNameCyrillic,
      this.group,
      this.maritalStatus,
    });

    static String get entity => 'base\$PersonExt';

    static String get view => 'person.browse';

    static String get property => 'group.id';

    factory BasePersonExt.fromJson(String str) {
      return BasePersonExt.fromMap(json.decode(str) as Map<String, dynamic>);
    }

    String toJson() => json.encode(toMap());

    factory BasePersonExt.fromMap(Map<String, dynamic> json) {
      return BasePersonExt(
        entityName: json['_entityName']?.toString(),
        instanceName: json['_instanceName']?.toString(),
        employeeNumber: json['employeeNumber']?.toString(),
        firstName: json['firstName']?.toString(),
        firstNameLatin: json['firstNameLatin']?.toString(),
        id: json['id']?.toString(),
        lastName: json['lastName']?.toString(),
        lastNameLatin: json['lastNameLatin']?.toString(),
        middleName: json['middleName']?.toString(),
        middleNameLatin: json['middleNameLatin']?.toString(),
        startDate: json['startDate']?.toString(),
        endDate: json['endDate']?.toString(),
        birthPlace: json['birthPlace']?.toString(),
        dateOfBirth: json['dateOfBirth'] == null ? null : DateTime.parse(json['dateOfBirth']),
        fioWithEmployeeNumber: json['fioWithEmployeeNumber']?.toString(),
        fioWithEmployeeNumberWithSortSupported: json['fioWithEmployeeNumberWithSortSupported']?.toString(),
        firstLastName: json['firstLastName']?.toString(),
        fistLastNameLatin: json['fistLastNameLatin']?.toString(),
        fullName: json['fullName']?.toString(),
        fullNameLatin: json['fullNameLatin']?.toString(),
        hireDate: json['hireDate']?.toString(),
        legacyId: json['legacyId']?.toString(),
        nationalIdentifier: json['nationalIdentifier']?.toString(),
        personName: json['personName']?.toString(),
        fullNameNumberCyrillic: json['fullNameNumberCyrillic']?.toString(),
        fullNameCyrillic: json['fullNameCyrillic']?.toString(),
        haveNDA: json['haveNDA']?.toString(),
        childUnder18WithoutFatherOrMother: json['childUnder18WithoutFatherOrMother']?.toString(),
        childUnder14WithoutFatherOrMother: json['childUnder14WithoutFatherOrMother']?.toString(),
        shortName: json['shortName']?.toString(),
        commitmentsCredit: json['commitmentsCredit'] == null ? null : json['commitmentsCredit'] as bool,
        commitmentsFromPrevJob: json['commitmentsFromPrevJob']?.toString(),
        commitmentsLoan: json['commitmentsLoan'] == null ? null : json['commitmentsLoan'] as bool,
        writeHistory: json['writeHistory'] == null ? null : json['writeHistory'] as bool,
        criminalAdministrativeLiability: json['criminalAdministrativeLiability']?.toString(),
        version: json['version'] == null ? null : int.parse(json['version'].toString()),
        group: json['group'] == null ? null : BasePersonGroupExt.fromMap(json['group'] as Map<String, dynamic>),
        maritalStatus: json['maritalStatus'] == null ? null : AbstractDictionary.fromMap(json['maritalStatus'] as Map<String, dynamic>),
      );
    }

    Map<String, dynamic> toMap() {
      return <String, dynamic>{
        '_entityName': entityName,
        '_instanceName': instanceName,
        'employeeNumber': employeeNumber,
        'endDate': endDate,
        'firstName': firstName,
        'firstNameLatin': firstNameLatin,
        'id': id,
        'lastName': lastName,
        'lastNameLatin': lastNameLatin,
        'middleName': middleName,
        'middleNameLatin': middleNameLatin,
        'startDate': startDate,
        'birthPlace': birthPlace,
        'dateOfBirth': dateOfBirth == null
            ? null
            : "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        'fioWithEmployeeNumber': fioWithEmployeeNumber,
        'fioWithEmployeeNumberWithSortSupported': fioWithEmployeeNumberWithSortSupported,
        'firstLastName': firstLastName,
        'fistLastNameLatin': fistLastNameLatin,
        'fullName': fullName,
        'fullNameLatin': fullNameLatin,
        'hireDate': hireDate,
        'legacyId': legacyId,
        'nationalIdentifier': nationalIdentifier,
        'personName': personName,
        'fullNameNumberCyrillic': fullNameNumberCyrillic,
        'fullNameCyrillic': fullNameCyrillic,
        'haveNDA': haveNDA,
        'childUnder18WithoutFatherOrMother': childUnder18WithoutFatherOrMother,
        'childUnder14WithoutFatherOrMother': childUnder14WithoutFatherOrMother,
        'shortName': shortName,
        'commitmentsCredit': commitmentsCredit,
        'commitmentsFromPrevJob': commitmentsFromPrevJob,
        'commitmentsLoan': commitmentsLoan,
        'writeHistory': writeHistory,
        'criminalAdministrativeLiability': criminalAdministrativeLiability,
        'version': version,
        'group': group?.toMap(),
        'maritalStatus': maritalStatus?.toMap(),
      }..removeWhere((String key, dynamic value) => value == null);
    }
  }
