import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/quiz/question_model.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/quiz/cubit/quiz_cubit.dart';
import 'package:language_learning/presenter/screens/quiz/provider/quiz_provider.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

class QuizBody extends StatelessWidget {
  final QuestionModel quizData;
  final int learningCount;

  const QuizBody({
    super.key,
    required this.quizData,
    required this.learningCount,
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
                    2.verticalSpace,
                    PrimaryText(
                      text: quizData.question,
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      textAlign: TextAlign.center,
                    ),
                    2.verticalSpace,
                    PrimaryText(
                      text:
                          '${quizProvider.quizQuestionOrder} / $learningCount',
                      color: AppColors.inputHeading,
                      fontWeight: FontWeight.w600,
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
                    itemCount: quizData.answers?.length,
                    itemBuilder: (context, index) {
                      bool isCorrect = quizData.answers?.any(
                              (args) => args.source == quizData.question) ??
                          false;

                      bool isListenable = true;

                      if (!(quizData.isHidden ?? false) &&
                          !quizProvider.isAnswersUnblurred) {
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
                              text: quizData.answers?[index].answer,
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            trailing: (quizData.answers?[index].answer ==
                                    quizProvider.correctAnswer)
                                ? IconButton(
                                    onPressed: () => _speak(
                                        quizData.answers?[index].answer ?? ""),
                                    icon: Icon(
                                      CupertinoIcons.volume_up,
                                      size: 20.w,
                                      color: AppColors.primary,
                                    ),
                                  )
                                : null,
                            tileColor: quizProvider.selectedAnswer ==
                                    quizData.answers?[index].answer
                                ? (quizProvider.selectedAnswerCorrect == true
                                    ? AppColors.success.withValues(alpha: 0.7)
                                    : AppColors.wrong.withValues(alpha: 0.3))
                                : (quizProvider.correctAnswer ==
                                            quizData.answers?[index].answer &&
                                        quizProvider.selectedAnswer !=
                                            quizProvider.correctAnswer
                                    ? AppColors.success.withValues(alpha: 0.7)
                                    : AppColors.unselectedItemBackground),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(44.0).r,
                              side: BorderSide(
                                color: quizProvider.selectedAnswer ==
                                        quizData.answers?[index].answer
                                    ? (quizProvider.selectedAnswerCorrect ==
                                            true
                                        ? AppColors.success
                                        : AppColors.wrong)
                                    : (quizProvider.correctAnswer ==
                                                quizData
                                                    .answers?[index].answer &&
                                            quizProvider.selectedAnswer !=
                                                quizProvider.correctAnswer
                                        ? AppColors.success
                                        : AppColors.itemBorder),
                                width: 2,
                              ),
                            ),
                            onTap: quizProvider.isAnswerLocked
                                ? null
                                : () {
                                    String correctAnswer = quizData.answers
                                            ?.firstWhere((entry) =>
                                                entry.source ==
                                                quizData.question)
                                            .answer ??
                                        "";

                                    bool isCorrect = correctAnswer ==
                                        quizData.answers?[index].answer;

                                    quizProvider.setSelectedAnswer(
                                        quizData.answers?[index].answer ?? "",
                                        isCorrect,
                                        correctAnswer);

                                    if (isCorrect && isListenable) {
                                      quizProvider
                                          .setCorrectAnswerSelected(true);
                                      quizProvider.addCorrectAnswerCount();

                                      _speak(quizData.answers?[index].answer ??
                                          "");
                                    } else {
                                      quizProvider.decrementChance();
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
                                            fontFamily: 'Inter',
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
                                              title: 'Finish',
                                              hasBorder: true,
                                              isActive: true,
                                              onTap: () async {
                                                await quizCubit.createQuizSession(
                                                    quizProvider
                                                        .createQuizSessionInput);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                            onLongPress: () {
                              String correctAnswer = quizData.answers
                                      ?.firstWhere(
                                          (entry) =>
                                              entry.source == quizData.question,
                                          orElse: () => AnswerModel(
                                              answer: "", source: ""))
                                      .answer ??
                                  "";

                              if (quizData.answers?[index].answer !=
                                  correctAnswer) {
                                String sourceValue =
                                    quizData.answers?[index].source ??
                                        "No source";

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: PrimaryText(
                                      text: 'This may helpful for you.',
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                    content: PrimaryText(
                                      text:
                                          'Translation is: $sourceValue',
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('OK',
                                            style: TextStyle(
                                                color: AppColors.primary)),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }),
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
            if (quizProvider.showAddToMaster)
              CupertinoButton(
                pressedOpacity: 1,
                padding: EdgeInsets.zero,
                onPressed: quizProvider.isAddingToMaster
                    ? null
                    : () async {
                        quizProvider.setIsAddingToMaster(true);
                        await quizCubit.addToMaster(quizData.id!, quizProvider);
                        homeCubit.getCardCounts();
                        quizProvider.setIsAddingToMaster(false);
                      },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                  child: Row(
                    children: [
                      if (quizProvider.isAddingToMaster)
                        SizedBox(
                          width: 18.w,
                          height: 18.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary,
                          ),
                        )
                      else
                        PrimaryText(
                          haveUnderline: TextDecoration.underline,
                          text: 'Add to Master words',
                          color: AppColors.primary,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      12.horizontalSpace,
                      Icon(
                        quizProvider.isAddedToMaster
                            ? Icons.bookmark
                            : Icons.bookmark_outline,
                        color: AppColors.primary,
                        size: 20.w,
                      ),
                    ],
                  ),
                ),
              ),
            PrimaryButton(
              title: 'Next',
              hasBorder: false,
              isActive: quizProvider.isAnswerSelected &&
                  !quizProvider.isAddingToMaster,
              onTap: quizProvider.isAddingToMaster
                  ? () {}
                  : () {
                      quizProvider.unlockAnswerSelection();
                      quizProvider.setAddToMaster(false);
                      quizProvider.setCorrectAnswer(null);
                      quizProvider.incrementQuizQuestionOrder();
                      quizProvider.setTotalQuestionCount();
                      quizCubit.getQuizQuestion();
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
