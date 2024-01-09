import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/entities/abstract_bpm_request.dart';
import 'package:kzm/core/models/entities/base_person_ext.dart';
import 'package:kzm/core/models/entities/bproc_process_instance_data.dart';
import 'package:kzm/core/models/entities/other/person_profile.dart';
import 'package:kzm/core/models/entities/sys_file_descriptor.dart';
import 'package:kzm/core/models/entities/tsadv_bpm_roles_definer.dart';
import 'package:kzm/core/models/entities/tsadv_bpm_roles_link.dart';
import 'package:kzm/core/models/entities/tsadv_dicIssuing_authority.dart';
import 'package:kzm/core/models/entities/tsadv_dic_request_status.dart';
import 'package:kzm/core/models/entities/tsadv_ext_task_data.dart';
import 'package:kzm/core/models/entities/tsadv_not_persisit_bproc_actors.dart';
import 'package:kzm/core/models/entities/tsadv_person_document_request.dart';
import 'package:kzm/core/models/entities/tsadv_personal_data_request.dart';
import 'package:kzm/core/models/entities/tsadv_user_ext.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/core/service/provider/provider.dart';
import 'package:kzm/core/service/provider/result_model.dart';
import 'package:kzm/pageviews/lk/main_data/add_or_edit/personal_data/personal_data_request.dart';

const String fName = 'lib/pageviews/lk/_misc/po_services.dart';

class KzmPrivateOfficeServices {
  final KzmProvider _api = Get.find<KzmProvider>();
  Box<dynamic> _settings;

  Future<String> get personGroupId async {
    _settings = await HiveUtils.getSettingsBox();
    return _settings.get('pgId').toString();
  }

  Future<PersonProfile> getPersonProfile() async {
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/tsadv_EmployeeService/personProfile',
      body: <String, dynamic>{
        'personGroupId': await personGroupId,
      },
      map: ({dynamic data}) {
        return PersonProfile.fromMap(data as Map<String, dynamic>);
      },
    );

    return (resp.result ?? PersonProfile()) as PersonProfile;
  }

  Future<List<TsadvPersonalDataRequest>> getPersonalDataRequestList() async {
    final KzmApiResult resp = await _api.reqGetMap(
      url: 'entities/tsadv\$PersonalDataRequest/search',
      query: <String, dynamic>{
        'view': 'personalDataRequest-edit',
        'filter': json.encode(<String, dynamic>{
          'conditions': <dynamic>[
            <String, dynamic>{
              'property': 'personGroup.id',
              'operator': '=',
              'value': await personGroupId,
            },
            <String, dynamic>{
              'property': 'status.code',
              'operator': 'in',
              'value': <String>[
                'DRAFT',
                'TO_BE_REVISED',
                'APPROVING',
              ]
            }
          ]
        }),
      },
      map: ({dynamic data}) {
        return (data as List<dynamic>).map((dynamic e) => TsadvPersonalDataRequest.fromMap(e as Map<String, dynamic>)).toList();
      },
    );

    return (resp.result ?? <TsadvPersonalDataRequest>[]) as List<TsadvPersonalDataRequest>;
  }

  Future<List<T>> getEntityList<T>({
    @required String entityName,
    @required String view,
    @required String property,
    @required Function(Map<String, dynamic>) fromMap,
    int limit,
  }) async {
    try {
      final KzmApiResult resp = await _api.reqGetMap(
        url: 'entities/$entityName/search',
        query: <String, dynamic>{
          'view': view,
          'sort': '	-updateTs',
          if (limit != null) 'limit': '$limit',
          'filter': json.encode(<String, dynamic>{
            'conditions': <dynamic>[
              <String, dynamic>{
                'property': property,
                'operator': '=',
                'value': await personGroupId,
              },
            ]
          }),
          'returnCount': 'true',
        },
        map: ({dynamic data}) => (data as List<dynamic>).map((dynamic e) => fromMap(e as Map<String, dynamic>) as T).toList(),
      );

      return (resp.result ?? <T>[]) as List<T>;
    } catch (e) {
      log('-->> $fName, getEntityList ->> exception: $e');
    }
    return <T>[];
  }

  Future<T> getEntity<T>({
    @required String entityName,
    @required String id,
    @required Function(Map<String, dynamic>) fromMap,
    String view,
  }) async {
    final KzmApiResult resp = await _api.reqGetMap(
      url: 'entities/$entityName/$id',
      query: <String, dynamic>{
        'view': view ?? 'portal.my-profile',
      },
      map: ({dynamic data}) {
        return fromMap(data as Map<String, dynamic>) as T;
      },
    );
    return (resp.result ?? fromMap(<String, dynamic>{}) as T) as T;
  }

  Future<List<T>> getEntityRequestList<T>({
    @required String entity,
    @required String view,
    @required String property,
    @required String id,
    @required Function(Map<String, dynamic>) fromMap,
  }) async {
    final KzmApiResult resp = await _api.reqGetMap(
      url: 'entities/$entity/search',
      query: <String, dynamic>{
        'view': view,
        'filter': json.encode(<String, dynamic>{
          'conditions': <Map<String, dynamic>>[
            <String, dynamic>{
              'property': property,
              'operator': '=',
              'value': id,
            },
            <String, dynamic>{
              'property': 'status.code',
              'operator': 'in',
              'value': <String>[
                'DRAFT',
                'TO_BE_REVISED',
                'APPROVING',
              ]
            }
          ]
        }),
      },
      map: ({dynamic data}) {
        return (data as List<dynamic>).map((dynamic e) => fromMap(e as Map<String, dynamic>) as T).toList();
      },
    );

    return (resp.result ?? <T>[]) as List<T>;
  }

  Future<PersonalDataRequest> getPersonalDataRequestByID({
    @required String id,
  }) async {
    final KzmApiResult resp = await _api.reqGetMap(
      url: 'entities/tsadv\$PersonalDataRequest/$id',
      query: <String, String>{
        'view': 'portal.my-profile',
      },
      map: ({dynamic data}) => PersonalDataRequest.fromMap(data as Map<String, dynamic>),
    );

    return (resp.result ?? PersonalDataRequest()) as PersonalDataRequest;
  }

  Future<TsadvPersonalDataRequest> getPersonalDataRequest({
    @required TsadvPersonalDataRequest personalDataRequest,
  }) async {
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'entities/tsadv\$PersonalDataRequest',
      body: personalDataRequest.toMap(),
      map: ({dynamic data}) => TsadvPersonalDataRequest.fromMap(data as Map<String, dynamic>),
    );

    return (resp.result ?? TsadvPersonalDataRequest()) as TsadvPersonalDataRequest;
  }

  Future<TsadvPersonalDataRequest> getPersonalDataNewEntity({
    @required KzmAbstractBpmModel model,
  }) async {
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/tsadv_PortalHelperService/newEntity',
      body: <String, dynamic>{
        'entityName': model.entityName,
      },
      map: ({dynamic data}) => TsadvPersonalDataRequest.fromMap(data as Map<String, dynamic>),
    );

    return (resp.result ?? TsadvPersonalDataRequest()) as TsadvPersonalDataRequest;
  }

  Future<TsadvPersonDocumentRequest> getPersonDocumentNewEntity({
    @required KzmAbstractBpmModel model,
  }) async {
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/tsadv_PortalHelperService/newEntity',
      body: <String, dynamic>{
        'entityName': model.entityName,
      },
      map: ({dynamic data}) => TsadvPersonDocumentRequest.fromMap(data as Map<String, dynamic>),
    );

    return (resp.result ?? TsadvPersonDocumentRequest()) as TsadvPersonDocumentRequest;
  }

  Future<List<TsadvDicRequestStatus>> gGetDicRequestStatus() async {
    final KzmApiResult resp = await _api.reqGetMap(
      url: 'entities/tsadv\$DicRequestStatus',
      query: <String, String>{
        'view': '_minimal',
        'returnCount': 'true',
      },
      map: ({dynamic data}) {
        return (data as List<dynamic>).map((dynamic e) => TsadvDicRequestStatus.fromMap(e as Map<String, dynamic>)).toList();
      },
    );

    return (resp.result ?? <TsadvDicRequestStatus>[]) as List<TsadvDicRequestStatus>;
  }

  Future<List<TsadvDicIssuingAuthority>> gGetDicIssuingAuthority() async {
    final KzmApiResult resp = await _api.reqGetMap(
      url: 'entities/tsadv_DicIssuingAuthority',
      query: <String, String>{
        'view': '_minimal',
        'returnCount': 'true',
      },
      map: ({dynamic data}) {
        return (data as List<dynamic>).map((dynamic e) => TsadvDicIssuingAuthority.fromMap(e as Map<String, dynamic>)).toList();
      },
    );

    return (resp.result ?? <TsadvDicIssuingAuthority>[]) as List<TsadvDicIssuingAuthority>;
  }

  // Future<List<BasePersonExt>> gGetPersonExtOld({
  //   @required String startDate,
  //   @required String endDate,
  // }) async {
  //   final KzmApiResult resp = await _api.reqGetMap(
  //     url: 'entities/base\$PersonExt/search',
  //     query: <String, String>{
  //       'view': 'person-edit',
  //       'filter': json.encode(<String, dynamic>{
  //         'conditions': <Map<String, String>>[
  //           <String, String>{'property': 'group.id', 'operator': '=', 'value': await personGroupId},
  //           <String, String>{'property': 'startDate', 'operator': '<=', 'value': startDate},
  //           <String, String>{'property': 'endDate', 'operator': '>=', 'value': endDate}
  //         ]
  //       }),
  //     },
  //     map: ({dynamic data}) {
  //       return (data as List<dynamic>).map((dynamic e) => BasePersonExt.fromMap(e as Map<String, dynamic>)).toList();
  //     },
  //   );
  //
  //   return (resp.result ?? <BasePersonExt>[]) as List<BasePersonExt>;
  // }

  Future<List<BasePersonExt>> getPersonExt({
    @required String startDate,
    @required String endDate,
  }) async {
    final KzmApiResult resp = await _api.reqGetMap(
      url: 'entities/base\$PersonExt/search',
      query: <String, String>{
        'view': 'person-edit',
        'filter': json.encode(<String, dynamic>{
          'conditions': <Map<String, String>>[
            <String, String>{'property': 'group.id', 'operator': '=', 'value': await personGroupId},
            <String, String>{'property': 'startDate', 'operator': '<=', 'value': startDate},
            <String, String>{'property': 'endDate', 'operator': '>=', 'value': endDate}
          ]
        }),
      },
      map: ({dynamic data}) {
        return (data as List<dynamic>).map((dynamic e) => BasePersonExt.fromMap(e as Map<String, dynamic>)).toList();
      },
    );

    return (resp.result ?? <BasePersonExt>[]) as List<BasePersonExt>;
  }

  // Future<TsadvStartBprocScreen> getStartFormData() async {
  //   final KzmApiResult resp = await _api.reqPostMap(
  //     url: 'services/tsadv_BprocService/getStartFormData',
  //     body: <String, dynamic>{
  //       'processDefinitionKey': 'personalDataRequest',
  //     },
  //     map: ({dynamic data}) => TsadvStartBprocScreen.fromMap(data as Map<String, dynamic>),
  //   );
  //
  //   return (resp.result ?? TsadvStartBprocScreen()) as TsadvStartBprocScreen;
  // }

  Future<BprocProcessInstanceData> getBprocProcessInstanceData({
    @required String id,
  }) async {
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/tsadv_BprocService/getProcessInstanceData',
      body: <String, String>{
        'processDefinitionKey': 'personalDataRequest',
        'processInstanceBusinessKey': id,
      },
      map: ({dynamic data}) => BprocProcessInstanceData.fromMap(data as Map<String, dynamic>),
    );

    return (resp.result ?? BprocProcessInstanceData()) as BprocProcessInstanceData;
  }

  Future<List<TsadvExtTaskData>> getProcessTasks({
    @required BprocProcessInstanceData processInstanceData,
  }) async {
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/tsadv_BprocService/getProcessTasks',
      body: <String, dynamic>{
        'processInstanceData': processInstanceData.toMap(),
      },
      map: ({dynamic data}) => (data as List<dynamic>).map((dynamic e) => TsadvExtTaskData.fromMap(e as Map<String, dynamic>)).toList(),
    );
    return (resp.result ?? <TsadvExtTaskData>[]) as List<TsadvExtTaskData>;
  }

  Future<List<TsadvUserExt>> gGetUsers() async {
    final KzmApiResult resp = await _api.reqGetMap(
      url: 'entities/tsadv\$UserExt',
      query: <String, String>{
        'view': 'portal-bproc-users',
        'returnCount': 'true',
      },
      map: ({dynamic data}) => (data as List<dynamic>).map((dynamic e) => TsadvUserExt.fromMap(e as Map<String, dynamic>)).toList(),
    );

    return (resp.result ?? <TsadvUserExt>[]) as List<TsadvUserExt>;
  }

  Future<Map<String, dynamic>> _requestForBody({
    @required KzmAbstractBpmModel abstractBpmRequest,
  }) async {
    return <String, dynamic>{
      '_entityName': abstractBpmRequest?.entityName,
      'status': <String, String>{'id': abstractBpmRequest?.status?.id},
      'personGroup': <String, String>{'id': await personGroupId},
      'attachments': abstractBpmRequest?.attachments?.map((SysFileDescriptor e) => <String, String>{'id': e.id})?.toList(),
    }..removeWhere((String key, dynamic value) => value == null);
  }

  Future<TsadvBpmRolesDefiner> gGetBpmRolesDefiner({
    @required KzmAbstractBpmModel abstractBpmRequest,
  }) async {
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/tsadv_StartBprocService/getBpmRolesDefiner',
      body: <String, dynamic>{
        'request': await _requestForBody(abstractBpmRequest: abstractBpmRequest),
        'employeePersonGroupId': await personGroupId,
        'isAssistant': 'false',
      },
      map: ({dynamic data}) => TsadvBpmRolesDefiner.fromMap(
        data as Map<String, dynamic>,
      ),
    );

    return (resp.result ?? TsadvBpmRolesDefiner()) as TsadvBpmRolesDefiner;
  }

  Future<void> uploadFiles({@required List<SysFileDescriptor> files}) => _api.uploadFiles(files: files);

  Future<List<TsadvNotPersisitBprocActors>> getNotPersisitBprocActorsList({
    @required KzmAbstractBpmModel personalDataRequest,
  }) async {
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/tsadv_StartBprocService/getNotPersisitBprocActors',
      body: <String, dynamic>{
        'employeePersonGroupId': await personGroupId,
        'bpmRolesDefiner': (await gGetBpmRolesDefiner(abstractBpmRequest: personalDataRequest)).toMap(),
        'isAssistant': false,
        'request': await _requestForBody(abstractBpmRequest: personalDataRequest),
      },
      map: ({dynamic data}) => (data as List<dynamic>).map((dynamic e) => TsadvNotPersisitBprocActors.fromMap(e as Map<String, dynamic>)).toList(),
    );

    return (resp.result ?? <TsadvNotPersisitBprocActors>[]) as List<TsadvNotPersisitBprocActors>;
  }

  Future<bool> saveBprocActors({
    @required String entityId,
    @required List<Map<String, dynamic>> actors,
  }) async {
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/tsadv_StartBprocService/saveBprocActors',
      body: <String, dynamic>{
        'entityId': entityId,
        'notPersisitBprocActors': actors,
      },
      map: ({dynamic data}) => null,
    );

    if (resp.statusCode == 204) return true;

    return false;
  }

  Future<bool> startProcessInstanceByKey({
    @required TsadvPersonalDataRequest personalDataRequest,
    @required List<TsadvBpmRolesLink> bpmRolesLinks,
  }) async {
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/bproc_BprocRuntimeService/startProcessInstanceByKey',
      body: <String, dynamic>{
        'processDefinitionKey': 'personalDataRequest',
        'businessKey': personalDataRequest.id,
        'variables': <String, dynamic>{
          'entity': personalDataRequest.toMap(),
          'rolesLinks': bpmRolesLinks.map((TsadvBpmRolesLink e) => e.toMap()).toList(),
        }
      },
      map: ({dynamic data}) => null,
    );

    if (resp.statusCode == 200) return true;

    return false;
  }

  Future<bool> putPersonalDataRequest({
    @required TsadvPersonalDataRequest personalDataRequest,
  }) async {
    final KzmApiResult resp = await _api.reqPutMap(
      url: 'entities/tsadv\$PersonalDataRequest/${personalDataRequest.id}',
      body: personalDataRequest.toMap(),
      map: ({dynamic data}) => data['id'],
    );

    return resp.result == personalDataRequest.id;
  }

  Future<bool> completeWithOutcome({
    @required TsadvExtTaskData extTaskData,
    @required String comment,
  }) async {
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/bproc_BprocTaskService/completeWithOutcome',
      body: <String, dynamic>{
        'taskData': extTaskData.toMap(),
        'outcomeId': 'CANCEL',
        'processVariables': <String, String>{'comment': comment}
      },
      map: ({dynamic data}) => null,
    );

    if (resp.statusCode == 204) return true;

    return false;
  }
}
