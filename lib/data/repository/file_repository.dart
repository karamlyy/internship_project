import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:language_learning/data/endpoint/file/download_file_endpoint.dart';
import 'package:language_learning/data/endpoint/file/upload_file_endpoint.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/service/api/api.dart';

abstract class FileRepository {

  Future<Either<HttpException, void>> uploadTemplate(File file);
}

class FileRepositoryImpl extends FileRepository {
  final ApiService apiService;

  FileRepositoryImpl(this.apiService);



  @override
  Future<Either<HttpException, void>> uploadTemplate(File file) async {
    return await apiService.uploadFile(UploadFileEndpoint(file));
  }

}
