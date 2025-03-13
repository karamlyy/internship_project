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
      // Let user pick a directory
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
      if (selectedDirectory == null) {
        log('User cancelled folder selection');
        return null;
      }

      log('User selected directory: $selectedDirectory');

      // Generate a unique file name if none provided
      String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      String fileName = customFileName?.trim().isNotEmpty == true
          ? customFileName!
          : 'exported_mastered_words_$timestamp.xlsx';

      final filePath = '$selectedDirectory/$fileName';

      // Decode Base64 and write to file
      final bytes = base64Decode(base64String);
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      log('File saved at: $filePath');
      return filePath;
    } catch (e) {
      log('Error converting and saving Excel file: $e');
      return null;
    }
  }
}