import 'dart:developer' as developer;
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:kzm/core/models/absence/absence.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/models/abstract/abstract_dictionary.dart';
import 'package:kzm/core/models/abstract/group_element.dart';
import 'package:kzm/core/models/assignment/assignment.dart';
import 'package:kzm/core/models/assignment/assignment_element.dart';
import 'package:kzm/core/models/assignment/employee_category.dart';
import 'package:kzm/core/models/organization/organization_group.dart';
import 'package:kzm/core/models/organization/organization_group_element.dart';
import 'package:kzm/core/models/person/person.dart';
import 'package:kzm/core/models/position/job_group.dart';
import 'package:kzm/core/models/position/position_group.dart';
import 'package:kzm/core/models/position/position_group_element.dart';
import 'package:kzm/core/models/proc_instance_v.dart';
import 'package:kzm/core/models/user_info.dart';
// import 'package:kinfolk/service/utils.dart';
import 'package:kzm/core/service/kinfolk/service/utils.dart';

class HiveUtils {
  static void regAdapters() {
    Hive.registerAdapter(AbstractDictionaryAdapter());
    Hive.registerAdapter(FileDescriptorAdapter());
    Hive.registerAdapter(GroupElementAdapter());
    Hive.registerAdapter(EmployeeCategoryAdapter());

    Hive.registerAdapter(JobGroupAdapter());
    Hive.registerAdapter(OrganizationGroupExtElementAdapter());
    Hive.registerAdapter(OrganizationGroupExtAdapter());
    Hive.registerAdapter(PositionGroupElementAdapter());
    Hive.registerAdapter(PositionGroupAdapter());
    Hive.registerAdapter(AssignmentElementAdapter());

    Hive.registerAdapter(PersonGroupAdapter());
    Hive.registerAdapter(AbsenceRequestAdapter());
    Hive.registerAdapter(PersonAdapter());
    Hive.registerAdapter(ProcInstanceVAdapter());
  }

  static Future<void> saveDataFromFuture(Future future, String boxName) async {
    try {
      final List list = await future as List;
      // await DBProvider.saveEntitiesListById(boxName: boxName, list: list);
      final Box<dynamic> box = await HiveService.getBox(boxName);
      for (final element in list) {
        await box.put(element.id, element);
      }
    } catch (ex) {
      developer.log('Error', error: ex.toString());
    }
  }

  static Future<UserInfo> getUserInfo() async {
    final Box box = await HiveService.getBox('settings');
    final String json = await box.get('info') as String;
    return userInfoFromJson(json);
  }

  static Future<Box> getSettingsBox() async {
    final Box box = await HiveService.getBox('settings');
    return box;
  }

  static Future<bool> saveUserInfo(UserInfo info) async {
    if (info.login.isEmpty) log('-->> saveUserInfo, login isEmpty !!!!');
    final Box box = await HiveService.getBox('settings');
    await box.put('info', userInfoToJson(info));
    return true;
  }

  static Future<String> getPgId() async {
    final Box box = await getSettingsBox();
    final String id = (box.get('pgId') ?? '') as String;
    return id ?? '';
  }

  static Future<void> syncProcInstanceV(List list) async {
    // ignore: always_specify_types
    final Box box = await HiveService.getBox('ProcInstanceV');
    await box.clear();
    if (list.isNotEmpty) {
      try{
        await box.addAll(list);
      } catch(e) {
        print(e);
      }
    }
  }
}

class DBProvider {
  static Future<bool> saveEntity({element, String boxName, String id}) async {
    final Box<dynamic> box = await HiveService.getBox(boxName);
    await box.add(element);
    return true;
  }

  static Future<bool> saveEntityById({element, String boxName, String id}) async {
    final Box<dynamic> box = await HiveService.getBox(boxName);
    await box.put(id ?? element.id, element);
    return true;
  }

  static Future<bool> saveEntitiesList({List list, String boxName}) async {
    final Box<dynamic> box = await HiveService.getBox(boxName);
    box.addAll(list);
    return true;
  }

  static Future<bool> saveEntitiesListById({List list, String boxName}) async {
    final Box<dynamic> box = await HiveService.getBox(boxName);
    for (final element in list) {
      await box.put(element.id, element);
    }
    return true;
  }

  static Future<List> getEntities({@required String boxName}) async {
    final Box<dynamic> box = await HiveService.getBox(boxName);
    final List list = box.values.toList();
    return list;
  }
}
