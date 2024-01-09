import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kzm/core/components/widgets/field_caption.dart';
import 'package:kzm/core/components/widgets/shimmer.dart';
import 'package:kzm/core/constants/icons.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/entities/sys_file_descriptor.dart';

class KzmFilesLoader extends StatefulWidget {
  final bool isRequired;

  // final List<KzmFileData> files;
  final List<SysFileDescriptor> files;
  final bool isActive;

  final Function() onChange;

  const KzmFilesLoader({
    @required this.files,
    this.onChange,
    this.isRequired = false,
    this.isActive = true,
  });

  @override
  _KzmFilesLoaderState createState() => _KzmFilesLoaderState();
}

class _KzmFilesLoaderState extends State<KzmFilesLoader> {
  final List<String> _paths = <String>[];
  bool isFileLoading = false;

  @override
  void initState() {
    super.initState();
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
              caption: 'Вложения'.tr,
              isRequired: widget.isRequired,
              isExpanded: false,
            ),
            GestureDetector(
              onTap: widget.isActive
                  ? () async {
                      setState(() => isFileLoading = true);
                      final FilePickerResult result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: <String>[
                          'pdf',
                          'doc',
                          'docx',
                          'csv',
                          'xls',
                          'xlsx',
                          'jpeg',
                          'jpg',
                          'png',
                        ],
                      );
                      setState(() => isFileLoading = false);
                      if (result != null) {
                        if (!_paths.contains(result.files.single.path)) {
                          setState(() {
                            _paths.add(result.files.single.path);
                            widget.files.add(
                              SysFileDescriptor(
                                file: File(result.files.single.path),
                                name: result.files.single.path.split('/').last,
                              ),
                            );
                            if (widget.onChange != null) widget.onChange();
                          });
                        }
                      }
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
                            style: Styles.sendMessageFilesList,
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
                          child: widget.isActive
                              ? KzmIcons.sendMessageFilesListDelete
                              : KzmIcons.sendMessageFilesListDeleteInactive,
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
