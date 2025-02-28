import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/language/language_model.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class CreateLanguageList extends StatelessWidget {
  final List<LanguageModel> languages;
  final int? selectedLanguageId;
  final Function(int) onLanguageSelected;


  const CreateLanguageList({
    super.key,
    required this.languages,
    required this.selectedLanguageId,
    required this.onLanguageSelected,
  });

  Widget _buildLanguageImage(String? base64String) {
    if (base64String == null || base64String.isEmpty) {
      return SizedBox(
        width: 32.w,
        height: 32.h,
        child: Icon(Icons.language, size: 30, color: Colors.grey),
      );
    }

    try {
      Uint8List bytes = base64Decode(base64String);
      return Image.memory(
        bytes,
        width: 32,
        height: 32,
        fit: BoxFit.cover,
      );
    } catch (e) {
      return const SizedBox(
        width: 40,
        height: 40,
        child: Icon(
          Icons.broken_image,
          size: 30,
          color: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final language = languages[index];
              final isSelected = selectedLanguageId == language.id;

              return GestureDetector(
                onTap: () {
                  onLanguageSelected(language.id);
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12).r,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.itemBackground
                        : AppColors.unselectedItemBackground,
                    borderRadius: BorderRadius.circular(8).r,
                    border: Border.all(
                      color: isSelected ? AppColors.itemBorder : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      _buildLanguageImage(language.image),
                      16.horizontalSpace,
                      PrimaryText(
                        text: language.name,
                        color: isSelected
                            ? AppColors.primaryText
                            : AppColors.primaryText.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
