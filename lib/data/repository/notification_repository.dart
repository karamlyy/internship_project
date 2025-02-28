import 'package:dartz/dartz.dart';
import 'package:language_learning/data/endpoint/notification/notification_endpoint.dart';
import 'package:language_learning/data/endpoint/vocabulary/category_vocabulary_endpoint.dart';
import 'package:language_learning/data/endpoint/vocabulary/category_word_endpoint.dart';
import 'package:language_learning/data/exception/error.dart';
import 'package:language_learning/data/model/home/category_word_model.dart';
import 'package:language_learning/data/model/notification/notification_model.dart';
import 'package:language_learning/data/service/api/api.dart';

abstract class NotificationRepository {
  Future<Either<HttpException, List<NotificationModel>>> getAllNotification();

}

class NotificationRepositoryImpl extends NotificationRepository {
  final ApiService apiService;

  NotificationRepositoryImpl(this.apiService);

  @override
  Future<Either<HttpException, List<NotificationModel>>> getAllNotification() async {
    return await apiService.task(NotificationEndpoint());
  }


}
