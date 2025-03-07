import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_learning/data/model/statistics/quiz_accuracy_model.dart';
import 'package:language_learning/generic/base_state.dart';
import 'package:language_learning/presenter/screens/statistics/cubit/statistics_cubit.dart';
import 'package:language_learning/utils/colors/app_colors.dart';

class StatisticsBody extends StatelessWidget {
  const StatisticsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, BaseState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessState) {
          final quizAccuracy = state.data as QuizAccuracyModel;

          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderSummary(quizAccuracy),
                  16.verticalSpace,
                  _buildCard(
                      'Correct vs Incorrect',
                      CorrectIncorrectPieChart(
                        totalQuestions: quizAccuracy.totalQuestions,
                        correctAnswers: quizAccuracy.totalCorrectAnswers,
                      )),
                  _buildCard(
                      'Weekly Accuracy (Line Chart)',
                      SizedBox(
                        height: 200.h,
                        child: WeeklyLineAccuracyChart(
                            weeklyStats: quizAccuracy.weekly),
                      )),
                  _buildCard(
                      'Monthly Accuracy (Bar Chart)',
                      SizedBox(
                        height: 200.h,
                        child: MonthlyBarAccuracyChart(
                            monthlyStats: quizAccuracy.monthly),
                      )),
                ],
              ),
            ),
          );
        } else if (state is FailureState) {
          return const Center(child: Text('Failed to load statistics'));
        } else {
          return const Center(child: Text('Initializing...'));
        }
      },
    );
  }

  Widget _buildHeaderSummary(QuizAccuracyModel quizAccuracy) {
    return Card(
      elevation: 0,
      color: AppColors.unselectedItemBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overall Accuracy', style: _headerTextStyle()),
            Text(
              '${quizAccuracy.overallAccuracy.toStringAsFixed(2)}%',
              style: _statTextStyle(),
            ),
            const Divider(),
            Text(
              'Total Questions: ${quizAccuracy.totalQuestions}',
              style: _infoTextStyle(),
            ),
            Text(
              'Total Correct Answers: ${quizAccuracy.totalCorrectAnswers}',
              style: _infoTextStyle(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, Widget child) {
    return Card(
      elevation: 0,
      color: AppColors.unselectedItemBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: _headerTextStyle()),
            8.verticalSpace,
            child,
          ],
        ),
      ),
    );
  }

  TextStyle _headerTextStyle() => const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary);
  TextStyle _statTextStyle() => const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryText);
  TextStyle _infoTextStyle() =>
      const TextStyle(fontSize: 14, color: AppColors.primaryText);
}

// ----------------------- Pie Chart (Correct vs Incorrect) -----------------------

class CorrectIncorrectPieChart extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;

  const CorrectIncorrectPieChart({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final incorrectAnswers = totalQuestions - correctAnswers;

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              color: AppColors.primary,
              value: correctAnswers.toDouble(),
              title:
                  '${((correctAnswers / totalQuestions) * 100).toStringAsFixed(1)}% Correct',
              radius: 70,
              titleStyle: _pieTextStyle(),
            ),
            PieChartSectionData(
              color: AppColors.primary.withValues(alpha: 0.4),
              value: incorrectAnswers.toDouble(),
              title:
                  '${((incorrectAnswers / totalQuestions) * 100).toStringAsFixed(1)}% Incorrect',
              radius: 70,
              titleStyle: _pieTextStyle(),
            ),
          ],
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  TextStyle _pieTextStyle() => const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white);
}

// ----------------------- Daily Accuracy (Line Chart) -----------------------

class DailyAccuracyChart extends StatelessWidget {
  final List<DailyStats> dailyStats;

  const DailyAccuracyChart({super.key, required this.dailyStats});

  @override
  Widget build(BuildContext context) {
    return _buildLineChart(dailyStats.map((e) => e.accuracy).toList(),
        dailyStats.map((e) => e.dayStart).toList());
  }
}

// ----------------------- Weekly Accuracy (Line Chart) -----------------------

class WeeklyLineAccuracyChart extends StatelessWidget {
  final List<WeeklyStats> weeklyStats;

  const WeeklyLineAccuracyChart({super.key, required this.weeklyStats});

  @override
  Widget build(BuildContext context) {
    return _buildLineChart(weeklyStats.map((e) => e.accuracy).toList(),
        weeklyStats.map((e) => e.weekStart).toList());
  }
}

// ----------------------- Monthly Accuracy (Bar Chart) -----------------------

class MonthlyBarAccuracyChart extends StatelessWidget {
  final List<MonthlyStats> monthlyStats;

  const MonthlyBarAccuracyChart({super.key, required this.monthlyStats});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
              sideTitles: _bottomTitles(
                  monthlyStats.map((e) => e.monthStart).toList())),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, interval: 20)),
        ),
        barGroups: monthlyStats.asMap().entries.map((entry) {
          final index = entry.key;
          final month = entry.value;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                  toY: month.accuracy, color: AppColors.primary, width: 16)
            ],
          );
        }).toList(),
      ),
    );
  }
}

// ----------------------- Helper Functions -----------------------

Widget _buildLineChart(List<double> data, List<String> labels) {
  return LineChart(
    LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: _bottomTitles(labels)),
        leftTitles:
            AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 20)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: data.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value);
          }).toList(),
          isCurved: true,
          color: AppColors.primary,
          barWidth: 3,
          belowBarData: BarAreaData(
              show: true, color: AppColors.primary.withValues(alpha: 0.2)),
        ),
      ],
    ),
  );
}

SideTitles _bottomTitles(List<String> labels) {
  return SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      int index = value.toInt();
      if (index < 0 || index >= labels.length) return Container();
      return Text(labels[index].substring(5),
          style: const TextStyle(fontSize: 10));
    },
  );
}
