import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

/*
class DownloaderService {
  Future<String?> convertBase64ToExcel({
    required String base64String,
    String fileName = 'exported_mastered_words.xlsx',
  }) async {
    try {
      final bytes = base64Decode(base64String);

      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        print('Unable to get external storage directory');
        return null;
      }

      final documentsDirectory = Directory((await getApplicationDocumentsDirectory()).absolute.path);
      if (!documentsDirectory.existsSync()) {
        await documentsDirectory.create(recursive: true);
      }

      final filePath = '${documentsDirectory.path}/$fileName';
      log('documentsDirectory: ${documentsDirectory.path}');
      final file = File(filePath);

      await file.writeAsBytes(bytes);

      print('File saved at: $filePath');
      return filePath;
    } catch (e) {
      print('Error converting and saving Excel file: $e');
      return null;
    }
  }
}

 */

import 'package:file_picker/file_picker.dart';

class DownloaderService {
  Future<String?> convertBase64ToExcel({
    required String base64String,
    String fileName = 'exported_mastered_words.xlsx',
  }) async {
    try {
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath();

      if (selectedDirectory == null) {
        log('User cancelled folder selection');
        return null;
      }

      log('User selected directory: $selectedDirectory');

      final filePath = '$selectedDirectory/$fileName';

      final bytes = base64Decode(base64String);
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      print('File saved at: $filePath');
      return filePath;
    } catch (e) {
      print('Error converting and saving Excel file: $e');
      return null;
    }
  }
}