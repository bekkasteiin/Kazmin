import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kzm/core/models/abstract/FileDescriptor.dart';
// import 'package:kinfolk/kinfolk.dart';
import 'package:kzm/core/service/kinfolk/kinfolk.dart';
import 'package:kzm/core/service/rest_service.dart';
import 'package:kzm/layout/loader_layout.dart';
import 'package:open_file_safe/open_file_safe.dart';

class PickerFileServices {
  static Future<dynamic> getMultiFiles({bool allowMultiple = true}) async {
    List<PlatformFile> _picker;
    final List<File> multiFile = [];
    try {
      _picker = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: allowMultiple,
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
      ))
          ?.files;
      if (_picker != null) {
        for (int i = 0; i < _picker.length; i++) {
          multiFile.add(File(_picker[i].path));
        }
      }
    } on PlatformException catch (e) {
      print('Unsupported operation$e');
    } catch (ex) {
      print(ex);
    }
    return multiFile.isEmpty ? null : (allowMultiple ? multiFile : multiFile.first);
  }

  static Future<File> getImage() async {
    final ImagePicker picker = ImagePicker();
    File file;
    final PickedFile pickerFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickerFile != null) {
      file = File(pickerFile.path);
    } else {
      print('No image selected');
    }
    return file;
  }

  static Future<File> getImageCamera() async {
    final ImagePicker picker = ImagePicker();
    File file;
    final PickedFile pickerFile = await picker.getImage(source: ImageSource.camera);
    if (pickerFile != null) {
      file = File(pickerFile.path);
    } else {
      print('No image selected');
    }
    return file;
  }

  static Future<void> downloadFile(FileDescriptor fileDescriptor) async {
    Get.dialog(const LoaderWidget(isPop: true));
    final String url = Kinfolk.getFileUrl(fileDescriptor.id) as String;
    final String fileName = '${fileDescriptor.name}.${fileDescriptor.extension}';
    final String fullPath = await RestServices.downloadFile(url, fileName);
    // log('-->> $fName, downloadFile ->> url: $url');
    Get.back();
    // print(fullPath);
    OpenFile.open(fullPath);
  }

  static Future<PDFDocument> getPdf(String url) async {
    final PDFDocument document = await PDFDocument.fromURL(url);
    return document;
  }
}
