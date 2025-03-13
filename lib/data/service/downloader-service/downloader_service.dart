import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';

class DownloaderService {
  Future<String?> convertBase64ToExcel({
    required String base64String,
    String? customFileName,
  }) async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) {
        return null;
      }

      String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      String fileName = customFileName?.trim().isNotEmpty == true
          ? customFileName!
          : 'language_learning_$timestamp.xlsx';

      final filePath = '$selectedDirectory/$fileName';

      final bytes = base64Decode(base64String);
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      return filePath;
    } catch (e) {
      return null;
    }
  }
}
