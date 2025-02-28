import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/home/view/home_appbar.dart';
import 'package:language_learning/presenter/screens/home/view/home_cards.dart';
import 'package:language_learning/presenter/screens/home/view/home_categories_list.dart';
import 'package:language_learning/presenter/screens/home/view/home_quiz_button.dart';
import 'package:language_learning/presenter/screens/home/view/home_words.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/presenter/widgets/secondary_floating_bottom_navbar.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessState) {
          return SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            floating: true,
                            pinned: true,
                            automaticallyImplyLeading: false,
                            backgroundColor: AppColors.background,
                            collapsedHeight: 50.h,
                            expandedHeight: 50.h,
                            toolbarHeight: 50.h,
                            elevation: 0,
                            surfaceTintColor: Colors.transparent,
                            title: HomeAppbar(),
                          ),
                          SliverToBoxAdapter(
                            child: HomeCategory(),
                          ),
                          SliverToBoxAdapter(
                            child: HomeQuizButton(),
                          ),
                          SliverToBoxAdapter(
                            child: HomeCards(),
                          ),
                          SliverToBoxAdapter(
                            child: HomeMasterQuizButton(),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(left: 16).r,
                              child: PrimaryText(
                                text: 'Latest added words',
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.w400,
                                fontSize: 26,
                                fontFamily: 'DMSerifDisplay',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: HomeWords(),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        } else if (state is FailureState) {
          return Center(
            child: Text(
              'Failed to load home data: ${state.errorMessage}',
            ),
          );
        } else {
          return const Center(child: Text('Initializing'));
        }
      },
    );
  }
}
