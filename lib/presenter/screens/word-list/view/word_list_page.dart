import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/word-list/cubit/category_cubit.dart';
import 'package:language_learning/presenter/screens/word-list/provider/word_list_provider.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class WordListPage extends StatelessWidget {
  final int categoryId;

  const WordListPage({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();

    return BlocProvider(
      create: (context) => CategoryCubit(categoryId),
      child: Scaffold(
        appBar: AppBar(
          title: PrimaryText(
            color: AppColors.primaryText,
            fontWeight: FontWeight.w400,
            text: 'Category Vocabulary',
            fontFamily: 'DMSerifDisplay',
            fontSize: 20,
          ),
        ),
        body: ChangeNotifierProvider(
          create: (context) => WordListProvider(),
          child: BlocListener<CategoryCubit, BaseState>(
            listener: (context, state) {},
            child: BlocBuilder<CategoryCubit, BaseState>(
                builder: (context, state) {
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SuccessState) {
                return Padding(
                  padding: const EdgeInsets.all(16.0).r,
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final word = state.data[index];
                      final wordListProvider =
                          context.watch<WordListProvider>();
                      final categoryCubit = context.read<CategoryCubit>();
                      final currentStatus = wordListProvider.getBookmarkStatus(
                        word.id,
                        word.isAdded,
                      );

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0.w,
                          vertical: 5.h,
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 2.h,
                          ),
                          tileColor: AppColors.unselectedItemBackground,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24).r,
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              wordListProvider.toggleBookmarkStatus(
                                word.id,
                                currentStatus,
                              );
                              await categoryCubit.changeWordStatus(word.id);
                              homeCubit.getAllLanguagePairs();
                              homeCubit.getLastWords();
                              homeCubit.getCardCounts();
                            },
                            icon: Icon(
                              currentStatus
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline,
                              color: AppColors.bookMarkBackground,
                              size: 20.w,
                            ),
                          ),
                          title: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.primaryText,
                              ),
                              children: [
                                TextSpan(
                                  text: word.source,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: ' - ${word.translation}',
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: Text('Error'));
              }
            }),
          ),
        ),
      ),
    );
  }
}
