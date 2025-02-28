import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/utils/colors/app_colors.dart';


class PrimaryTextField extends StatelessWidget {
  final String hint;
  final String? errorText;
  final bool isObscureText;
  final Color? borderColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final IconButton? suffixIcon;

  final Function(String)? onChanged;
  final VoidCallback? onTap;

  const PrimaryTextField({
    super.key,
    required this.hint,
    this.errorText,
    required this.isObscureText,
    this.borderColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      onChanged: onChanged,
      onTap: onTap,
      style: TextStyle(
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        filled: true,
        suffixIcon: suffixIcon,
        errorText: errorText,
        fillColor: AppColors.background,
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColors.hintText,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        border: buildBorder(errorText),
        contentPadding: EdgeInsets.all(16.0).r,
      ),
    );
  }

  buildBorder(String? error) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.r),
      borderSide: BorderSide(
        color: error?.isNotEmpty ?? false ? Colors.red : Colors.yellow,
        width: 2.w,
      ),
    );
  }
}
