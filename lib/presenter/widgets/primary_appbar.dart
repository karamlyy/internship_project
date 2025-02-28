import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/presenter/provider/appbar_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class PrimaryAppbar extends StatelessWidget {
  final String title;

  final Icon? leadingIcon;
  final Icon? trailingIcon;
  final VoidCallback? onTap;

  const PrimaryAppbar({
    super.key,
    this.onTap,
    required this.title,
    this.trailingIcon,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final appbarProvider = context.watch<AppbarProvider>();

    return AppBar(
      toolbarHeight: 60.h,
      leading: leadingIcon,

      title: AnimatedContainer(

        duration: Duration(milliseconds: 300),
        width: appbarProvider.isSearching ? 300.w : 150.w,
        child: appbarProvider.isSearching
            ? TextField(
                style: TextStyle(fontSize: 16.sp),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.inputBackground,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: AppColors.hintText,
                    fontSize: 14.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0).r,
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(12).r,
                  suffixText: 'clear',
                  suffixStyle: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.inputSuffix,
                  ),
                ),
              )
            : PrimaryText(
                text: title,
                color: AppColors.primaryText,
                fontWeight: FontWeight.w400,
                fontFamily: 'DMSerifDisplay',
                fontSize: 20,
              ),
      ),
      actions: [
        if (trailingIcon != null)
          IconButton(
            onPressed: () {
              if (appbarProvider.isSearching == true) {
                appbarProvider.changeSearchBarStatus(false);
              } else {
                appbarProvider.changeSearchBarStatus(true);
              }
            },
            icon: Icon(
              appbarProvider.isSearching
                  ? CupertinoIcons.clear
                  : trailingIcon!.icon,
              color: AppColors.primary,
              size: 20.h,
            ),
          ),
      ],
    );
  }
}
