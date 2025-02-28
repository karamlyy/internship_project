import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:language_learning/data/model/quiz/question_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/quiz/cubit/quiz_cubit.dart';
import 'package:language_learning/presenter/screens/quiz/provider/quiz_provider.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class MasterQuizPage extends StatelessWidget {
  const MasterQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit()..getMasterQuizQuestion(),
      child: ChangeNotifierProvider(
        create: (context) => QuizProvider(),
        child: Scaffold(
          appBar: AppBar(
            title: PrimaryText(
              text: 'Quiz',
              color: AppColors.primaryText,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              fontFamily: 'DMSerifDisplay',
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
                            fontSize: 20,
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
                              onTap: () {
                                quizCubit.createQuizReport(
                                    quizProvider.correctAnswerCount);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    });

                    return Container();
                  }

                  return MasterQuizBody(quizData: quizData);
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

class MasterQuizBody extends StatelessWidget {
  final dynamic quizData;

  const MasterQuizBody({
    super.key,
    required this.quizData,
  });

  @override
  Widget build(BuildContext context) {
    final quizCubit = context.read<QuizCubit>();
    final quizProvider = context.watch<QuizProvider>();
    final homeCubit = context.read<HomeCubit>();

    final FlutterTts flutterTts = FlutterTts();

    Future<void> _initializeTTS() async {
      try {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.setLanguage("en-US");

        await flutterTts.setPitch(1.0);
        await flutterTts.setSpeechRate(0.5);
      } catch (e) {
        print("TTS Initialization Error: $e");
      }
    }

    Future<void> _speak(String text) async {
      try {
        await _initializeTTS();
        await flutterTts.speak(text);
      } catch (e) {
        print("Error in TTS: $e");
      }
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100.h,
              decoration: BoxDecoration(
                color: AppColors.unselectedItemBackground,
                borderRadius: BorderRadius.circular(24).r,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.h,
                  horizontal: 12.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PrimaryText(
                      text: 'Tap the right answer:',
                      color: AppColors.inputHeading,
                      fontWeight: FontWeight.w600,
                    ),
                    12.verticalSpace,
                    PrimaryText(
                      text: quizData.question,
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            10.verticalSpace,
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: quizData.answers.length,
                    itemBuilder: (context, index) {
                      String answer = quizData.answers.keys.elementAt(index);
                      bool isCorrect = quizData.answers[answer] ?? false;

                      if (!quizData.isHidden && !quizProvider.isAnswersUnblurred) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          quizProvider.unblurAnswers();
                        });
                      }

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: ListTile(
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 12.w),
                          title: PrimaryText(
                            text: answer,
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          trailing: quizProvider.correctAnswer == answer
                              ? IconButton(
                            onPressed: () => _speak(answer),
                            icon: Icon(
                              CupertinoIcons.volume_up,
                              size: 20.w,
                              color: AppColors.primary,
                            ),
                          )
                              : null,
                          tileColor: quizProvider.selectedAnswer != null
                              ? (quizProvider.correctAnswer == answer
                              ? AppColors.success.withValues(alpha: 0.7)
                              : (quizProvider.selectedAnswer == answer
                              ? AppColors.error.withValues(alpha: 0.3)
                              : AppColors.unselectedItemBackground))
                              : AppColors.unselectedItemBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(44.0).r,
                            side: BorderSide(
                              color: quizProvider.selectedAnswer == answer
                                  ? (quizProvider.selectedAnswerCorrect ?? false
                                  ? AppColors.success
                                  : AppColors.wrong)
                                  : AppColors.itemBorder,
                              width: 2,
                            ),
                          ),

                          onTap: quizProvider.isAnswerLocked
                              ? null
                              : () {
                            String correctAnswer = quizData
                                .answers.entries
                                .firstWhere(
                                    (entry) => entry.value == true)
                                .key;

                            quizProvider.setSelectedAnswer(
                                answer, isCorrect, correctAnswer);

                            if (isCorrect) {
                              quizProvider.setCorrectAnswerSelected(true);
                              quizProvider.addCorrectAnswerCount();
                              quizProvider.setShowRemoveFromMaster(false);
                            } else {
                              quizProvider.decrementChance();
                              quizProvider.setShowRemoveFromMaster(true);
                            }
                            quizProvider.selectAnswer(true);

                            if (quizProvider.chances == 0) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: PrimaryText(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.w400,
                                    text: 'Finished',
                                    fontSize: 20,
                                    fontFamily: 'DMSerifDisplay',
                                  ),
                                  content: PrimaryText(
                                    color: AppColors.primaryText
                                        .withValues(alpha: 0.7),
                                    fontWeight: FontWeight.w400,
                                    text: 'You did 3 mistakes',
                                    fontSize: 14,
                                  ),
                                  actions: [
                                    PrimaryButton(
                                      title: 'Restart',
                                      hasBorder: false,
                                      isActive: true,
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        quizProvider.resetChances();
                                        quizCubit.getMasterQuizQuestion();
                                      },
                                    ),
                                    5.verticalSpace,
                                    PrimaryButton(
                                      title: 'Finish',
                                      hasBorder: true,
                                      isActive: true,
                                      onTap: () {
                                        Navigator.of(context).pop();

                                        quizCubit.createQuizReport(
                                            quizProvider
                                                .correctAnswerCount);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                  if (!quizProvider.isAnswersUnblurred)
                    Positioned.fill(
                      bottom: 40.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.1),
                          ),
                        ),
                      ),
                    ),
                  if (!quizProvider.isAnswersUnblurred)
                    Positioned(
                      top: 20,
                      right: 20,
                      child: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: AppColors.primary,
                          size: 26.w,
                        ),
                        onPressed: () {
                          quizProvider.unblurAnswers();
                        },
                      ),
                    ),
                ],
              ),
            ),
            if (quizProvider.showRemoveFromMaster)
              CupertinoButton(
                pressedOpacity: 1,
                padding: EdgeInsets.zero,
                onPressed: () async {
                  await quizCubit.addToMaster(quizData.id, quizProvider);

                  quizProvider.setShowRemoveFromMaster(false);
                  homeCubit.getCardCounts();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                  child: Row(
                    children: [
                      PrimaryText(
                        haveUnderline: TextDecoration.underline,
                        text: 'Remove from Master words',
                        color: AppColors.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),

                    ],
                  ),
                ),
              ),
            PrimaryButton(
              title: 'Next',
              hasBorder: false,
              isActive: quizProvider.isAnswerSelected,
              onTap: () {
                quizProvider.unlockAnswerSelection();
                quizProvider.setShowRemoveFromMaster(false);
                quizCubit.getMasterQuizQuestion();
                quizProvider.setCorrectAnswer(null);
                quizProvider.selectAnswer(false);
                quizProvider.setCorrectAnswerSelected(false);
                quizProvider.blurAnswers();
              },
            ),
          ],
        ),
      ),
    );
  }
}
