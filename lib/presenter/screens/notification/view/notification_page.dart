import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/notification/cubit/notification_cubit.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: PrimaryText(
            text: 'Notifications',
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: 'DMSerifDisplay',
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: 16.w,
              ),
              child: Icon(
                Icons.done_all,
                size: 20.w,
              ),
            )
          ],
        ),
        body: BlocListener<NotificationCubit, BaseState>(
          listener: (context, state) {},
          child: NotificationBody(),
        ),
      ),
    );
  }
}

class NotificationBody extends StatelessWidget {
  const NotificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const ShimmerLoading();
        } else if (state is SuccessState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0).r,
              child: NotificationList(),
            ),
          );
        } else {
          return const Center(child: Text('Initializing...'));
        }
      },
    );
  }
}

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const ShimmerLoading(); // Show shimmer effect while loading
        } else if (state is SuccessState) {
          final notifications = state.data;

          Map<String, List<dynamic>> groupedNotifications = {};

          for (var notification in notifications) {
            DateTime dateTime = DateTime.parse(notification.createdOn);

            String formattedDay = DateFormat.yMMMMd().format(dateTime);

            if (groupedNotifications[formattedDay] == null) {
              groupedNotifications[formattedDay] = [];
            }
            groupedNotifications[formattedDay]!.add(notification);
          }

          List<String> sortedDays = groupedNotifications.keys.toList()
            ..sort((a, b) {
              DateTime dayA = DateFormat.yMMMMd().parse(a);
              DateTime dayB = DateFormat.yMMMMd().parse(b);
              return dayB.compareTo(dayA);
            });

          return ListView.builder(
            itemCount: sortedDays.length,
            itemBuilder: (context, index) {
              String day = sortedDays[index];
              List<dynamic> dayNotifications = groupedNotifications[day]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                    child: PrimaryText(
                      text: day,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryText,
                    ),
                  ),
                  ...dayNotifications.map(
                        (notification) {
                      DateTime time = DateTime.parse(notification.createdOn);
                      String formattedTime = DateFormat.jm().format(time);

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.w,
                          vertical: 5.h,
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12).r,
                          tileColor: AppColors.unselectedItemBackground,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24).r,
                            borderSide: const BorderSide(color: Colors.transparent),
                          ),
                          title: PrimaryText(
                            text: '${notification.title} 🔥',
                            fontSize: 16,
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w600,
                          ),
                          subtitle: PrimaryText(
                            text: '${notification.body} - $formattedTime',
                            color: AppColors.primaryText.withOpacity(0.8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          );
        } else {
          return const Center(child: Text('Loading...'));
        }
      },
    );
  }
}

// Shimmer loading widget
class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Shimmer.fromColors(
            baseColor: AppColors.itemBackground,
            highlightColor: AppColors.itemBorder,
            child: Container(
              padding: EdgeInsets.all(12).r,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24).r,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(4).r,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    width: double.infinity,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(4).r,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Container(
                    width: 150.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(4).r,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
