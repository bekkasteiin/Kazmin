import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kzm/core/constants/ui_design.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
import 'package:kzm/core/service/picker_file_service.dart';
import 'package:kzm/generated/l10n.dart';
import 'package:kzm/layout/widgets.dart';
import 'package:kzm/viewmodels/bpm_requests/abstract_bpm_model.dart';

// ignore: must_be_immutable
class FilesWidget<T extends AbstractBpmModel> extends StatefulWidget {
  final bool editable;
  final T model;
  final bool isRequired;

  const FilesWidget({
    @required this.model,
    this.editable = true,
    this.isRequired = false,
  });

  @override
  _FilesWidgetState createState() => _FilesWidgetState();
}

class _FilesWidgetState extends State<FilesWidget> {
  @override
  Widget build(BuildContext context) {
    return KzmFileDescriptorsWidget(
      editable: widget.editable,
      isRequired: widget.model.request?.type?.isFileRequired ?? widget.isRequired /*false*/,
      onTap: () => pickerFileDialog(),
      list: Column(
        mainAxisSize: MainAxisSize.min,
        children: widget.model.request.files.isNotEmpty
            ? widget.model.request.files.map((FileDescriptor e) {
                return KzmFileTile(
                  fileName: e.name,
                  onTap: widget.editable
                      ? () {
                    FocusScope.of(context).requestFocus(FocusNode());
                          widget.model.request.files.remove(e);
                          setState(() {});
                        }
                      : null,
                  fileDescriptor: e,
                );
              }).toList()
            : [noData],
      ),
    );
  }

  void pickerFileDialog() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () async {
                  Get.back();
                  final File file = await PickerFileServices.getImageCamera();
                  if (file != null) {
                    await widget.model.saveFilesToEntity(picker: file);
                  }
                  setState(() {});
                },
                child: Text(S.current.camera),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  Get.back();
                  final File file = await PickerFileServices.getImage();
                  if (file != null) {
                    await widget.model.saveFilesToEntity(picker: file);
                  }
                  setState(() {});
                },
                child: Text(S.current.photo),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  Get.back();
                  final List<File> files = await PickerFileServices.getMultiFiles(allowMultiple: true) as List<File>;
                  if (files != null) {
                    await widget.model.saveFilesToEntity(multiPicker: files);
                  }
                  setState(() {});
                },
                child: Text(S.current.document),
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: Text(
                S.current.cancel,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          );
        },);
  }
}
