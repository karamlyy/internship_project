import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class PrimaryTextFormField extends StatelessWidget {
  final String? hint;
  final String? errorText;
  final String? initialText;
  final VoidCallback? onTap;
  final ValueChanged<String> onChanged;

  final bool isObscureText;
  final bool hasError;
  final bool isFilled;
  final bool isReadOnly;
  final Color errorColor;
  final Color successColor;
  final Color defaultBorderColor;
  final Color defaultEnabledBorderColor;
  final Color defaultFocusedBorderColor;
  final Color defaultFilledBackgroundColor;
  final Widget? suffixIcon;
  final String? headText;
  final TextEditingController? controller;

  const PrimaryTextFormField({
    super.key,
    this.hint,
    this.errorText,
    this.initialText,
    this.isFilled = true,
    this.isReadOnly = false,
    required this.onChanged,
    this.onTap,
    this.isObscureText = false,
    this.hasError = false,
    this.errorColor = AppColors.error,
    this.successColor = AppColors.inputBorder,
    this.defaultBorderColor = AppColors.inputBorder,
    this.defaultEnabledBorderColor = AppColors.inputBorder,
    this.defaultFocusedBorderColor = AppColors.inputBorder,
    this.defaultFilledBackgroundColor = AppColors.inputBackground,
    this.suffixIcon,
    this.controller,
    this.headText,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = hasError ? errorColor : defaultBorderColor;
    Color enabledBorderColor = hasError ? successColor : defaultEnabledBorderColor;
    Color focusedBorderColor = hasError ? errorColor : defaultFocusedBorderColor;
    Color filledBackgroundColor = isFilled ? defaultFilledBackgroundColor : Colors.transparent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headText?.isNotEmpty ?? false)
          PrimaryText(
            text: headText ?? '',
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
          ),
        6.verticalSpace,
        TextFormField(
          onTap: onTap,
          readOnly: isReadOnly,
          initialValue: initialText,
          obscureText: isObscureText,
          style: TextStyle(fontSize: 16.sp),
          onChanged: onChanged,
          controller: controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(color: AppColors.inputText, fontSize: 16.sp),
            hintText: hint,
            errorText: errorText,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(10.0).r,
              child: suffixIcon,
            ),
            filled: true,
            fillColor: filledBackgroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0).r,
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0).r,
              borderSide: BorderSide(color: enabledBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0).r,
              borderSide: BorderSide(color: focusedBorderColor),
            ),
          ),
        ),
      ],
    );
  }
}
