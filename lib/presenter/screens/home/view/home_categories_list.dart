import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/home/category_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/home/provider/home_provider.dart';
import 'package:language_learning/presenter/screens/home/widgets/catergory_card.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:language_learning/utils/routes/app_routes.dart';
import 'package:language_learning/utils/routes/navigation.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: BlocListener<HomeCubit, BaseState>(
        listener: (context, state) {},
        child: HomeCategoriesList(),
      ),
    );
  }
}

class HomeCategoriesList extends StatelessWidget {
  const HomeCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    return StreamBuilder<List<CategoryModel>>(
      stream: context.read<HomeCubit>().categoriesController,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(16.0).r,
            child: SizedBox(
              height: 125.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final category = snapshot.data?[index];
                  return CategoryCard(
                    id: category?.id,
                    groupName: category?.name,
                    allWords: category?.vocabularyCount,
                    masteredWords: category?.masteredCount,
                    image: category?.image,
                    onTap: () async {
                      Navigation.push(Routes.wordList, arguments: category?.id);
                    },
                  );
                },
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0).r,
            child: SizedBox(
              height: 125.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: AppColors.itemBackground,
                    highlightColor: AppColors.itemBorder,
                    child: Container(
                      width: 200.w,
                      margin: EdgeInsets.only(right: 10.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
