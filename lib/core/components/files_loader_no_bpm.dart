import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/field_caption.dart';
import 'package:kzm/core/components/widgets/shimmer.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/sys_file_descriptor.dart';
import 'package:kzm/core/service/picker_file_service.dart';
import 'package:kzm/generated/l10n.dart';

class KzmFilesLoaderNoBPM extends StatefulWidget {
  final bool isRequired;
  final List<SysFileDescriptor> files;
  final bool isActive;

  final Function() onChange;

  const KzmFilesLoaderNoBPM({
    @required this.files,
    this.onChange,
    this.isRequired = false,
    this.isActive = true,
  });

  @override
  _KzmFilesLoaderNoBPMState createState() => _KzmFilesLoaderNoBPMState();
}

class _KzmFilesLoaderNoBPMState extends State<KzmFilesLoaderNoBPM> {
  final List<String> _paths = <String>[];
  bool isFileLoading = false;

  @override
  void initState() {
    super.initState();
  }

  void processData({@required List<File> filesData}) {
    if (filesData.isNotEmpty) {
      for (final File val in filesData) {
        if (val != null) {
          if (!_paths.contains(val.path)) {
            setState(() {
              _paths.add(val.path);
              widget.files.add(
                SysFileDescriptor(
                  file: val,
                  name: val.path.split('/').last,
                ),
              );
              if (widget.onChange != null) widget.onChange();
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            KzmFieldCaption(
              isLoading: isFileLoading,
              caption: S.current.attachments,
              isRequired: widget.isRequired,
              isExpanded: false,
              captionColor: Styles.appDarkGrayColor,
            ),
            GestureDetector(
              onTap: widget.isActive
                  ? () async {
                      await showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoActionSheet(
                            actions: <Widget>[
                              CupertinoActionSheetAction(
                                onPressed: () async {
                                  Get.back();
                                  setState(() => isFileLoading = true);
                                  final File _tmp = await PickerFileServices.getImageCamera();
                                  if (_tmp != null) processData(filesData: <File>[_tmp]);
                                  setState(() => isFileLoading = false);
                                },
                                child: Text(S.current.camera),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () async {
                                  Get.back();
                                  setState(() => isFileLoading = true);
                                  final File _tmp = await PickerFileServices.getImage();
                                  if (_tmp != null) processData(filesData: <File>[_tmp]);
                                  setState(() => isFileLoading = false);
                                },
                                child: Text(S.current.photo),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () async {
                                  Get.back();
                                  setState(() => isFileLoading = true);
                                  List<File> _files = <File>[];
                                  final dynamic _tmp = await PickerFileServices.getMultiFiles(allowMultiple: true);
                                  if (_tmp != null) {
                                    if (_tmp is List<PlatformFile>) {
                                      for (final PlatformFile x in _tmp) {
                                        _files.add(File(x.path));
                                      }
                                    }
                                    if (_tmp is List<File>) _files = _tmp;
                                    processData(filesData: _files);
                                  }
                                  setState(() => isFileLoading = false);
                                },
                                child: Text(S.current.document),
                              )
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              child: Text(S.current.cancel, style: const TextStyle(fontWeight: FontWeight.w500)),
                              onPressed: () => Get.back(),
                            ),
                          );
                        },
                      );
                    }
                  : null,
              child: isFileLoading
                  ? KzmShimmer(child: KzmIcons.addFile)
                  : widget.isActive
                      ? KzmIcons.addFile
                      : KzmIcons.addFileInactive,
            ),
          ],
        ),
        Container(
          padding: paddingHorizontal(top: Styles.appDoubleMargin, bottom: Styles.appDoubleMargin),
          decoration: BoxDecoration(
            border: Border.all(color: Styles.appBorderColor),
            borderRadius: BorderRadius.circular(Styles.appDefaultBorderRadius),
            color: widget.isActive ? null : Styles.appGrayColor,
          ),
          child: Column(
            children: <Widget>[
              if (widget.files.isNotEmpty)
                ...widget.files.map(
                  (SysFileDescriptor e) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: Styles.appSendMessageFilesListRowHeight,
                        width: Styles.appSendMessageFilesListDeleteIconWidth,
                        child: KzmIcons.sendMessageFilesListClip,
                      ),
                      SizedBox(width: Styles.appStandartMargin),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            e.name,
                            style: Styles.sendMessageFilesListNoBPM,
                          ),
                        ),
                      ),
                      SizedBox(width: Styles.appQuadMargin),
                      SizedBox(
                        height: Styles.appSendMessageFilesListRowHeight,
                        width: Styles.appSendMessageFilesListDeleteIconWidth,
                        child: GestureDetector(
                          onTap: widget.isActive
                              ? () {
                                  setState(() {
                                    _paths.remove(e.file.path);
                                    widget.files.remove(e);
                                    if (widget.onChange != null) widget.onChange();
                                  });
                                }
                              : null,
                          child: widget.isActive ? KzmIcons.sendMessageFilesListDelete : KzmIcons.sendMessageFilesListDeleteInactive,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Icon>[
                    KzmIcons.uploadFile,
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
