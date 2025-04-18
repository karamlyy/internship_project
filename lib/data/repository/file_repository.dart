import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:language_learning/data/endpoint/file/download_template_endpoint.dart';
import 'package:language_learning/data/endpoint/file/export_download_endpoint.dart';
import 'package:language_learning/data/endpoint/file/upload_file_endpoint.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/file/file_model.dart';
import 'package:language_learning/data/service/api/api.dart';

abstract class FileRepository {

  Future<Either<HttpException, void>> uploadTemplate(File file);
  Future<Either<HttpException, FileModel>> exportWords(List<int> ids);
  Future<Either<HttpException, FileModel>> downloadTemplate();
}

class FileRepositoryImpl extends FileRepository {
  final ApiService apiService;

  FileRepositoryImpl(this.apiService);

  @override
  Future<Either<HttpException, void>> uploadTemplate(File file) async {
    return await apiService.uploadFile(UploadFileEndpoint(file));
  }


  @override
  Future<Either<HttpException, FileModel>> exportWords(List<int> ids) async {
    return await apiService.task(ExportDownloadEndpoint(ids: ids));
  }

  @override
  Future<Either<HttpException, FileModel>> downloadTemplate() async {
    return await apiService.task(DownloadTemplateEndpoint());
  }
}
