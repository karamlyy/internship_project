import 'package:language_learning/data/model/home/word_pair_model.dart';

class UserVocabularyModel {
  final List<WordPairModel> items;
  final int page;
  final int pageSize;
  final int totalCount;
  final int pageCount;
  final bool hasNextPage;
  final bool hasPreviousPage;

  UserVocabularyModel({
    required this.items,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.pageCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory UserVocabularyModel.fromJson(Map<String, dynamic> json) {
    return UserVocabularyModel(
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => WordPairModel.fromJson(item))
              .toList() ?? [],
      page: json['page'] ?? 1,
      pageSize: json['pageSize'] ?? 20,
      totalCount: json['totalCount'],
      pageCount: json['pageCount'],
      hasNextPage: json['hasNextPage'] ?? false,
      hasPreviousPage: json['hasPreviousPage'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'page': page,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'pageCount': pageCount,
      'hasNextPage': hasNextPage,
      'hasPreviousPage': hasPreviousPage,
    };
  }
}
