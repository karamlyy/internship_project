class QuizAccuracyModel {
  final int totalQuestions;
  final int totalCorrectAnswers;
  final double overallAccuracy;
  final List<DailyStats> daily;
  final List<WeeklyStats> weekly;
  final List<MonthlyStats> monthly;

  QuizAccuracyModel({
    required this.totalQuestions,
    required this.totalCorrectAnswers,
    required this.overallAccuracy,
    required this.daily,
    required this.weekly,
    required this.monthly,
  });

  factory QuizAccuracyModel.fromJson(Map<String, dynamic> json) {
    return QuizAccuracyModel(
      totalQuestions: json['totalQuestions'],
      totalCorrectAnswers: json['totalCorrectAnswers'],
      overallAccuracy: (json['overallAccuracy'] as num).toDouble(),
      daily: (json['daily'] as List).map((e) => DailyStats.fromJson(e)).toList(),
      weekly: (json['weekly'] as List).map((e) => WeeklyStats.fromJson(e)).toList(),
      monthly: (json['monthly'] as List).map((e) => MonthlyStats.fromJson(e)).toList(),
    );
  }
}

class DailyStats {
  final String dayStart;
  final int questions;
  final int correctAnswers;
  final double accuracy;

  DailyStats({
    required this.dayStart,
    required this.questions,
    required this.correctAnswers,
    required this.accuracy,
  });

  factory DailyStats.fromJson(Map<String, dynamic> json) {
    return DailyStats(
      dayStart: json['dayStart'],
      questions: json['questions'],
      correctAnswers: json['correctAnswers'],
      accuracy: (json['accuracy'] as num).toDouble(),
    );
  }
}

class WeeklyStats {
  final String weekStart;
  final int questions;
  final int correctAnswers;
  final double accuracy;

  WeeklyStats({
    required this.weekStart,
    required this.questions,
    required this.correctAnswers,
    required this.accuracy,
  });

  factory WeeklyStats.fromJson(Map<String, dynamic> json) {
    return WeeklyStats(
      weekStart: json['weekStart'],
      questions: json['questions'],
      correctAnswers: json['correctAnswers'],
      accuracy: (json['accuracy'] as num).toDouble(),
    );
  }
}

class MonthlyStats {
  final String monthStart;
  final int questions;
  final int correctAnswers;
  final double accuracy;

  MonthlyStats({
    required this.monthStart,
    required this.questions,
    required this.correctAnswers,
    required this.accuracy,
  });

  factory MonthlyStats.fromJson(Map<String, dynamic> json) {
    return MonthlyStats(
      monthStart: json['monthStart'],
      questions: json['questions'],
      correctAnswers: json['correctAnswers'],
      accuracy: (json['accuracy'] as num).toDouble(),
    );
  }
}