import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/quiz/question_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/quiz/cubit/quiz_cubit.dart';
import 'package:language_learning/presenter/screens/quiz/provider/quiz_provider.dart';
import 'package:language_learning/presenter/screens/quiz/view/quiz_body.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class QuizPage extends StatelessWidget {
  final int? learningCount;

  const QuizPage({super.key, this.learningCount});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit()..getQuizQuestion(),
      child: ChangeNotifierProvider(
        create: (context) => QuizProvider(),
        child: Scaffold(
          appBar: AppBar(
            title: PrimaryText(
              text: 'Quiz',
              color: AppColors.primaryText,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              fontFamily: 'Inter',
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Consumer<QuizProvider>(
                  builder: (context, quizProvider, child) {
                    return Row(
                      children: List.generate(
                        3,
                            (index) {
                          if (index < quizProvider.chances) {
                            return Icon(
                              CupertinoIcons.heart_fill,
                              color: AppColors.primary,
                              size: 20.w,
                            );
                          } else {
                            return Icon(
                              CupertinoIcons.heart,
                              color: AppColors.primary,
                              size: 20.w,
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          body: BlocListener<QuizCubit, BaseState>(
            listener: (context, state) {},
            child: BlocBuilder<QuizCubit, BaseState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is SuccessState) {
                  final quizData = state.data as QuestionModel;
                  final quizProvider = context.read<QuizProvider>();
                  final quizCubit = context.read<QuizCubit>();

                  if (quizData.answers == null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => AlertDialog(
                          title: PrimaryText(
                            text: 'Quiz Finished',
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                          content: PrimaryText(
                            text:
                            'You got ${quizProvider.correctAnswerCount} correct answer(s).',
                            color: AppColors.primaryText.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          actions: [
                            PrimaryButton(
                              title: 'Finish',
                              hasBorder: false,
                              isActive: true,
                              onTap: () async {
                                await quizCubit.createQuizSession(
                                    quizProvider.createQuizSessionInput);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    });

                    return Container();
                  }

                  return QuizBody(
                      quizData: quizData, learningCount: learningCount ?? 1);
                }
                return Center(child: Text('Failed to load quiz'));
              },
            ),
          ),
        ),
      ),
    );
  }
}
