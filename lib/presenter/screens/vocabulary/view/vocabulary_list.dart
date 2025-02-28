// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:language_learning/data/endpoint/word/update_word_endpoint.dart';
// import 'package:language_learning/generic/base_state.dart';
// import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
// import 'package:language_learning/presenter/screens/vocabulary/cubit/vocabulary_cubit.dart';
// import 'package:language_learning/presenter/widgets/primary_text.dart';
// import 'package:language_learning/utils/colors/app_colors.dart';
//
// class VocabularyWordsList extends StatelessWidget {
//   const VocabularyWordsList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final homeCubit = context.read<HomeCubit>();
//
//     return BlocBuilder<VocabularyCubit, BaseState>(
//       builder: (context, state) {
//         if (state is SuccessState) {
//           final data = state.data;
//           return ListView.builder(
//             itemCount: data.items.length,
//             itemBuilder: (context, index) {
//               final vocabularyCubit = context.read<VocabularyCubit>();
//               final word = data.items[index];
//
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 5.h),
//                 child: Dismissible(
//                   key: UniqueKey(),
//                   background: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(26.r),
//                       color: AppColors.error,
//                     ),
//                     child: Row(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 16.w),
//                           child: Icon(
//                             CupertinoIcons.delete,
//                             color: AppColors.itemBackground,
//                             size: 20.w,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   secondaryBackground: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(26.r),
//                       color: AppColors.error,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(right: 16.w),
//                           child: Icon(
//                             CupertinoIcons.pencil,
//                             color: AppColors.itemBackground,
//                             size: 20.w,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   confirmDismiss: (direction) async {
//                     if (direction == DismissDirection.startToEnd) {
//                       vocabularyCubit.deleteWord(word.id);
//                       return true;
//                     }
//                     if (direction == DismissDirection.endToStart) {
//                       _showUpdateDialog(context, vocabularyCubit, word);
//                       return false;
//                     }
//                     return false;
//                   },
//                   child: ListTile(
//                     contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h),
//                     tileColor: AppColors.unselectedItemBackground,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(24.r),
//                       side: BorderSide(color: Colors.transparent),
//                     ),
//                     trailing: IconButton(
//                       onPressed: () async {
//                         await vocabularyCubit.addToLearning(word.id);
//                         homeCubit.getLastWords();
//                         homeCubit.getCardCounts();
//                       },
//                       icon: Icon(
//                         word.isLearningNow ? Icons.bookmark : Icons.bookmark_outline,
//                         size: 20.w,
//                         color: AppColors.bookMarkBackground,
//                       ),
//                     ),
//                     title: PrimaryText(
//                       text: '${word.source} - ${word.translation}',
//                       fontSize: 16,
//                       color: AppColors.primaryText,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         } else {
//           return Center(child: Text('yuklenir'));
//         }
//       },
//     );
//   }
//
//   void _showUpdateDialog(BuildContext context, VocabularyCubit cubit, dynamic word) {
//     final TextEditingController sourceController = TextEditingController(text: word.source);
//     final TextEditingController translationController = TextEditingController(text: word.translation);
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Update Word'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: sourceController,
//                 decoration: InputDecoration(labelText: 'Source Word'),
//               ),
//               TextField(
//                 controller: translationController,
//                 decoration: InputDecoration(labelText: 'Translation'),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 await cubit.updateWord(UpdateWordInput(
//                   id: word.id,
//                   source: sourceController.text,
//                   translation: translationController.text,
//                 ));
//                 Navigator.pop(context);
//               },
//               child: Text('Update'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
