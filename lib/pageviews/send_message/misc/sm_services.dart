import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:kzm/core/constants/globals.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/models/entities/sys_file_descriptor.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/provider/provider.dart';
import 'package:kzm/core/service/provider/result_model.dart';

const String fName = 'lib/pageviews/send_message/_misc/sm_services.dart';

class KzmSendMessageServices {
  final KzmProvider _api = Get.find<KzmProvider>();

  Future<List<String>> getCompanies() async {
    final Box<dynamic> _settings = await HiveUtils.getSettingsBox();
    final String _personGroupId = _settings.get('pgId').toString();

    final KzmApiResult resp = await _api.reqPostMap(
      url: 'services/tsadv_PortalHelperService/getCompaniesForLoadDictionary',
      body: <String, dynamic>{
        'personGroupId': _personGroupId,
      },
      map: ({dynamic data}) {
        return (data as List<dynamic>).map((dynamic e) => e as String).toList();
      },
    );

    return (resp.result ?? <String>[]) as List<String>;
  }

  Future<List<KzmCommonItem>> getCategories() async {
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'entities/tsadv_PortalFeedback/search',
      body: <String, dynamic>{
        'view': 'portalFeedback-portal',
        'filter': <String, dynamic>{
          'conditions': <dynamic>[
            <String, dynamic>{
              'property': 'company.id',
              'operator': 'in',
              'value': await getCompanies(),
            },
          ],
        },
      },
      map: ({dynamic data}) {
        return (data as List<dynamic>).map(
          (dynamic e) {
            final dynamic langValue = e['category']['langValue${mapLocale()}'] ?? e['category']['langValue1'];
            return KzmCommonItem(
              id: e['id'].toString(),
              text: langValue.toString(),
            );
          },
        ).toList();
      },
    );

    return (resp.result ?? <KzmCommonItem>[]) as List<KzmCommonItem>;
  }

  Future<List<KzmCommonItem>> getTypes() async {
    final KzmApiResult resp = await _api.reqGetMap(
      url: 'entities/tsadv_DicPortalFeedbackType',
      query: <String, String>{
        'view': '_local',
        'returnCount': 'true',
      },
      map: ({dynamic data}) {
        return (data as List<dynamic>).map(
          (dynamic e) {
            final dynamic langValue = e['langValue${mapLocale()}'] ?? e['langValue1'];
            return KzmCommonItem(
              id: e['id'].toString(),
              text: langValue.toString(),
            );
          },
        ).toList();
      },
    );

    return (resp.result ?? <KzmCommonItem>[]) as List<KzmCommonItem>;
  }

  Future<Map<String, dynamic>> pushResults({@required Map<String, dynamic> body}) async {
    _api.setBusy(busy: true);
    final KzmApiResult resp = await _api.reqPostMap(
      url: 'entities/tsadv_PortalFeedbackQuestions',
      body: body,
      map: ({dynamic data}) {
        return data as Map<String, dynamic>;
      },
    );
    _api.setBusy(busy: false);
    return (resp.result ?? <String, dynamic>{}) as Map<String, dynamic>;
  }

  Future<List<SysFileDescriptor>> uploadFiles({@required List<SysFileDescriptor> files}) async {
    // Future<void> uploadFiles({@required List<SysFileDescriptor> files}) async {
    //   _api.setBusy(busy: true);
    final List<SysFileDescriptor> _tmp = await _api.uploadFiles(files: files);
    // await _api.uploadFiles(files: files);
    // _api.setBusy(busy: false);
    return _tmp;
  }
}
