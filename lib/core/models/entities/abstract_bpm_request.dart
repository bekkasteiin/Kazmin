import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/entities/sys_file_descriptor.dart';
import 'package:kzm/core/models/entities/tsadv_bpm_roles_definer.dart';
import 'package:kzm/core/models/entities/tsadv_bpm_roles_link.dart';
import 'package:kzm/core/models/entities/tsadv_dic_request_status.dart';

abstract class KzmAbstractBpmModel<T> {
  T request;

  String get entityName;

  set entityName(String value);

  TsadvDicRequestStatus get status;

  set status(TsadvDicRequestStatus value);

  List<SysFileDescriptor> get attachments;

  set attachments(List<SysFileDescriptor> value);

  TsadvBpmRolesDefiner get bpmRolesDefiner;

  set bpmRolesDefiner(TsadvBpmRolesDefiner value);

  List<KzmCommonItem> get bpmRoles =>
      bpmRolesDefiner.links.map((TsadvBpmRolesLink e) => KzmCommonItem(id: e.hrRole.id, text: e.hrRole?.langValue ?? '')).toList();

  List<KzmCommonItem> get bpmUsers;

  set bpmUsers(List<KzmCommonItem> value);
}
