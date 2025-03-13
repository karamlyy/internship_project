import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/quiz/question_model.dart';
import 'package:language_learning/data/service/voice-service/voice_service.dart';
import 'package:language_learning/presenter/screens/home/cubit/home_cubit.dart';
import 'package:language_learning/presenter/screens/quiz/cubit/quiz_cubit.dart';
import 'package:language_learning/presenter/screens/quiz/provider/quiz_provider.dart';
import 'package:language_learning/presenter/widgets/primary_button.dart';
import 'package:language_learning/presenter/widgets/primary_text.dart';
import 'package:language_learning/utils/colors/app_colors.dart';
import 'package:provider/provider.dart';

class MasterQuizBody extends StatelessWidget {
  final QuestionModel quizData;
  final int masterQuizCount;

  const MasterQuizBody({
    super.key,
    required this.quizData,
    required this.masterQuizCount,
  });

  @override
  Widget build(BuildContext context) {
    final quizCubit = context.read<QuizCubit>();
    final quizProvider = context.watch<QuizProvider>();
    final homeCubit = context.read<HomeCubit>();

    final VoiceService voiceService = VoiceService();

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
                      fontSize: 18,
                      textAlign: TextAlign.center,
                    ),
                    2.verticalSpace,
                    PrimaryText(
                      text:
                          '${quizProvider.quizQuestionOrder} / $masterQuizCount',
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

                      bool? isListenable = quizData.isListenable;

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
                                    onPressed: () => voiceService.flutterTts.speak(
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
                                    ? (quizProvider.selectedAnswerCorrect ??
                                            false
                                        ? AppColors.success
                                        : AppColors.wrong)
                                    : AppColors.itemBorder,
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

                                    if (isCorrect && isListenable!) {
                                      quizProvider.setCorrectAnswerSelected(true);
                                      quizProvider.addCorrectAnswerCount();
                                      voiceService.flutterTts.speak(quizData.answers?[index].answer ??
                                          "");
                                      quizProvider.setShowRemoveFromMaster(false);
                                    }

                                    if(!isCorrect) {
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
                                                    quizProvider.createQuizSessionInput);
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
            if (quizProvider.showRemoveFromMaster)
              CupertinoButton(
                pressedOpacity: 1,
                padding: EdgeInsets.zero,
                onPressed: () async {
                  await quizCubit.addToMaster(quizData.id!, quizProvider);

                  quizProvider.setShowRemoveFromMaster(false);
                  homeCubit.getCardCounts();
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
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
              title: quizProvider.chances == 0 ? 'Finish' : 'Next',
              hasBorder: false,
              isActive: quizProvider.isAnswerSelected,
              onTap: () async {
                if (quizProvider.chances == 0) {
                  await quizCubit.createQuizSession(quizProvider.createQuizSessionInput);
                } else {
                  quizProvider.unlockAnswerSelection();
                  quizProvider.setShowRemoveFromMaster(false);
                  quizCubit.getMasterQuizQuestion();
                  quizProvider.setCorrectAnswer(null);
                  quizProvider.incrementQuizQuestionOrder();
                  quizProvider.setTotalQuestionCount();
                  quizProvider.selectAnswer(false);
                  quizProvider.setCorrectAnswerSelected(false);
                  quizProvider.blurAnswers();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
