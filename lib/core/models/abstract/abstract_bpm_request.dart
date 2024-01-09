import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/dictionary/dic_absence_type.dart';
import 'package:kzm/core/models/person/person.dart';

abstract class AbstractBpmRequest {
  String id;
  PersonGroup employee;
  DicAbsenceType type;
  List<FileDescriptor> files;
  AbstractDictionary status;
  bool requireAgreeAndFamiliarization = true;
  bool familiarization = true;
  bool agree = false;

  //для CubaView, если нет можно указать '_local' или '_minimal'
  String get getView;

  //для bpm
  String get getProcessDefinitionKey;

  String get getEntityName;

  dynamic getFromJson(String string);

  // Map<String, dynamic> get standardFields;
}
