import 'package:flutter_svg/flutter_svg.dart';

class Category {
  final int id;
  final String groupName;
  final int masteredWords;
  final int allWords;
  final SvgPicture? icon;

  Category({
    required this.id,
    required this.groupName,
    required this.masteredWords,
    required this.allWords,
    this.icon,
  });
}