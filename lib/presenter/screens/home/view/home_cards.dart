import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/home/card_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/home/provider/home_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeCards extends StatelessWidget {
  const HomeCards({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: BlocListener<HomeCubit, BaseState>(
        listener: (context, state) {},
        child: HomeCardsList(),
      ),
    );
  }
}

class HomeStatCard extends StatelessWidget {
  final String count;
  final String label;
  final VoidCallback onTap;

  const HomeStatCard({
    super.key,
    required this.count,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        color: AppColors.unselectedItemBackground,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryText(
                    text: count,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w400,
                    fontSize: 36,
                    fontFamily: 'DMSerifDisplay',
                  ),
                  PrimaryText(
                    text: label,
                    color: AppColors.primaryText.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeCardsList extends StatelessWidget {
  const HomeCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CardModel>(
      stream: context.read<HomeCubit>().countController,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.0.h,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        HomeStatCard(
                          count: '${snapshot.data?.totalCount ?? 0}',
                          label: 'Vocabulary',
                          onTap: () {
                            Navigation.push(Routes.vocabulary);
                          },
                        ),
                        12.verticalSpace,
                        HomeStatCard(
                          count: '${snapshot.data?.learningCount ?? 0}',
                          label: 'Learning Now',
                          onTap: () {
                            Navigation.push(Routes.learningVocabulary);
                          },
                        ),
                      ],
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigation.push(Routes.masteredVocabulary);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(16).r),
                          color: AppColors.unselectedItemBackground,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 10.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText(
                                  text: '${snapshot.data?.masteredCount}',
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 36,
                                  fontFamily: 'DMSerifDisplay',
                                ),
                                PrimaryText(
                                  text: 'Mastered Words',
                                  color: AppColors.primaryText
                                      .withValues(alpha: 0.8),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0).r,
            child: SizedBox(
              height: 140.h,
              child: Shimmer.fromColors(
                baseColor: AppColors.itemBackground,
                highlightColor: AppColors.itemBorder,
                child: Container(
                  margin: EdgeInsets.only(right: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
