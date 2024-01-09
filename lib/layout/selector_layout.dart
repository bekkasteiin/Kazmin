import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kzm/app.dart';
import 'package:kzm/core/components/widgets/no_data.dart';
import 'package:kzm/core/components/widgets/select_widget.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/common_item.dart';
import 'package:kzm/core/service/db_provider.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/core/service/kinfolk/model/cuba_entity_filter.dart';
import 'package:kzm/core/service/kinfolk/model/url_types.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:kzm/layout/widget_helpers.dart';
import 'package:kzm/layout/widgets.dart';

class EntitySelector extends StatelessWidget {
  final future;
  final mapFunction;

  const EntitySelector({Key key, this.future, this.mapFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        heroTag: 'EntitySelector',
        transitionBetweenRoutes: false,
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        leading: BrandLogo(),
        middle: Text(S.of(context).observer),
      ),
      child: Material(
        child: FutureBuilder(
          future: future,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const LoaderWidget();
            } else {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children:
                      snapshot.data.map(mapFunction).toList().cast<Widget>(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Future selector({
  Types type,
  String entityName,
  String methodName,
  String body,
  fromMap,
  dynamic entity,
  CubaEntityFilter filter,
  bool isPopUp = false,
  dynamic initialValue,
  String useFilterByProperty,
  List<KzmCommonItem> values,
}) async {
  Widget mapFunction(dynamic e) {
    String placeholder;
    bool current = false;
    try {
      placeholder ??= e.absencePurpose?.instanceName;
    } catch (_) {}
    try {
      placeholder ??= e.personGroupChild?.instanceName;
    } catch (_) {}
    try {
      placeholder ??= e.addressType.instanceName;
    } catch (_) {}
    try {
      placeholder ??= e.fullName;
      placeholder += ' ' + '[${e.login}]';
    } catch (_) {}
    try {
      placeholder ??= e.instanceName;
    } catch (_) {}
    try {
      placeholder ??= e.languageValue;
    } catch (_) {}
    try {
      placeholder ??= e.name;
    } catch (_) {}
    try {
      placeholder ??= e.fullName;
    } catch (_) {}
    try {
      placeholder ??= e.langValue1;
    } catch (_) {}
    try {
      placeholder ??= e.name1;
    } catch (_) {}
    try {
      placeholder ??=
          '${formatShortly(e.startDate as DateTime)}  ${formatShortly(e.endDate as DateTime)}';
    } catch (_) {}
    try {
      placeholder ??= e.text;
    } catch (_) {}
    if (entity != null) {
      print('eId${e.id}');
      current = e.id == entity.id;
    }

    DBProvider.saveEntityById(element: e, id: e.id, boxName: entityName);
    return placeholder == null
        ? SizedBox()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            color: current ? Styles.appBrightBlueColor.withOpacity(0.5) : null,
            child: ListTile(
              onTap: ()=>Get.back(result: e),
              contentPadding: EdgeInsets.zero,
              title: Text(
                placeholder ?? '',
                style: Styles.mainTS
                    .copyWith(fontSize: 14, color: Styles.appDarkBlackColor),
              ),
              trailing: current
                  ? const Icon(
                      Icons.check_circle_outline,
                      color: Colors.blueAccent,
                    )
                  : null,
            ),
          );

  }

  Future future;
  if (useFilterByProperty == null) {
    final bool connection = await RestServices.checkConnection();
    future = _getFromApi(
      connection: connection,
      entityName: entityName,
      methodName: methodName,
      body: body,
      type: type,
      filter: filter,
      fromMap: fromMap,
      useFilterByProperty: useFilterByProperty,
      values: values,
    );
  }
  if (isPopUp) {
    final value = await showModalBottomSheet(
      context: navigatorKey.currentContext,
      isScrollControlled: true,
      elevation: 0.6,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.w),
          topRight: Radius.circular(16.w),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (_) => Container(
        color: Colors.transparent,
        height: MediaQuery.of(navigatorKey.currentContext).size.height *0.5,
        child: SelectorPopUp(
          future: future,
          mapFunction: mapFunction,
          fromMap: fromMap,
          entityName: entityName,
          methodName: methodName,
          type: type,
          filter: filter,
          useFilterByProperty: useFilterByProperty,
          values: values,
        ),
      ),
    );
    return value ?? initialValue;
  }

  return await Navigator.push(
    navigatorKey.currentContext,
    MaterialPageRoute(
      builder: (_) => EntitySelector(
        future: future,
        mapFunction: mapFunction,
      ),
    ),
  );
}

Future<dynamic> _getFromApi({
  @required bool connection,
  @required String entityName,
  @required CubaEntityFilter filter,
  @required fromMap,
  @required String useFilterByProperty,
  @required String methodName,
  @required Types type,
  @required String body,
  @required List<KzmCommonItem> values,
}) {
  if (values != null) return Future<List<KzmCommonItem>>.value(values);
  return connection
      ? Kinfolk.getListModelRest(
          type: type ?? Types.entities,
          serviceOrEntityName: entityName,
          methodName: ((useFilterByProperty == null) && (filter == null))
              ? methodName ?? ''
              : methodName ?? 'search',
          body: body,
          filter: filter,
          fromMap: fromMap,
        )
      : DBProvider.getEntities(boxName: entityName);
}

class SelectorPopUp extends StatefulWidget {
  final Future future;
  final mapFunction;
  dynamic entity;
  final dynamic Function(Map<String, dynamic>) fromMap;
  final String entityName;
  final String methodName;
  final Types type;
  final CubaEntityFilter filter;
  final String useFilterByProperty;
  final String body;
  final List<KzmCommonItem> values;

  SelectorPopUp({
    Key key,
    this.future,
    this.mapFunction,
    this.fromMap,
    this.entityName,
    this.methodName,
    this.body,
    this.type,
    this.filter,
    this.useFilterByProperty,
    this.entity,
    this.values,
  }) : super(key: key);

  @override
  State<SelectorPopUp> createState() => _SelectorPopUpState();
}

class _SelectorPopUpState extends State<SelectorPopUp> {
  static const int _kRequestPauseMillisecs = 768;
  static const int _kSearchMinSymbols = 3;
  CubaEntityFilter _filter;
  DateTime _lastTappedAt;
  Future<dynamic> _future;
  String _lastData;

  @override
  void initState() {
    _future = widget.future;
    _filter = CubaEntityFilter(
      sort: widget.useFilterByProperty,
      sortType: SortTypes.desc,
      filter: Filter(
        conditions: <FilterCondition>[
          FilterCondition(
            property: null,
            conditionOperator: Operators.contains,
            value: null,
          )
        ],
      ),
      returnCount: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.w),
          child: Container(
            height: 5.h,
            width: size.width / 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: Styles.appBrightBlueColor.withOpacity(0.4),
            ),
          ),
        ),
        if (widget.useFilterByProperty != null)
          Padding(
            padding: paddingLR,
            child: FieldBones(
              isTextField: true,
              keyboardType: TextInputType.text,
              onChanged: (String str) => _filterChanged(data: str),
              placeholder: '',
            ),
          ),
        FutureBuilder<dynamic>(
          future: _future,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (widget.useFilterByProperty != null) {
              if (_future == null) {
                return Text(S.current.searchHint);
              }
            }
            if (snapshot.data == null ||
                snapshot.connectionState == ConnectionState.waiting) {
              return const LoaderWidget();
            }else if(snapshot.data.isEmpty || snapshot.data == null){
              return KZMNoData();

            }
            else {
              return Container(
                child: Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return widget.mapFunction(snapshot.data[index])
                          as Widget;
                    },
                    itemCount: (snapshot.data as List<dynamic>).length,
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Future<void> _filterChanged({@required String data}) async {
    if (data != _lastData) {
      _lastData = data;
      _lastTappedAt = DateTime.now();
      if (data.length > _kSearchMinSymbols) {
        await Future<Duration>.delayed(
            const Duration(milliseconds: _kRequestPauseMillisecs));

        if (DateTime.now().difference(_lastTappedAt).inMilliseconds >
            _kRequestPauseMillisecs) {
          _filter.filter.conditions.first.property = widget.useFilterByProperty;
          _filter.filter.conditions.first.value = data;

          RestServices.checkConnection().then((bool connection) {
            setState(() {
              _future = _getFromApi(
                connection: connection,
                entityName: widget.entityName,
                methodName: widget.methodName,
                body: widget.body,
                type: widget.type,
                filter: _filter,
                fromMap: widget.fromMap,
                useFilterByProperty: widget.useFilterByProperty,
                values: widget.values,
              );
            });
          });
        }
      } else {
        setState(() {
          _future = null;
        });
      }
    }
  }
}
