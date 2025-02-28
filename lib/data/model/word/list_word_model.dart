import 'package:language_learning/data/model/home/word_pair_model.dart';

class ListWordModel {
  final List<WordPairModel> items;
  final int count;


  ListWordModel({
    required this.items,
    required this.count,
  });

  factory ListWordModel.fromJson(Map<String, dynamic> json) {
    return ListWordModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => WordPairModel.fromJson(item))
          .toList() ?? [],
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'count': count,
    };
  }
}
