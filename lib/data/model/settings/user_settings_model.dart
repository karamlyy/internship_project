class UserSettingsModel {
  bool? quizHidden;
  bool? notificationDisabled;
  bool? quizListenable;

  UserSettingsModel({
    this.quizHidden,
    this.notificationDisabled,
    this.quizListenable,
  });

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) =>
      UserSettingsModel(
        quizHidden: json["quizHidden"],
        notificationDisabled: json["notificationDisabled"],
        quizListenable: json["quizListenable"],
      );

  Map<String, dynamic> toJson() => {
        "quizHidden": quizHidden,
        "notificationDisabled": notificationDisabled,
        "quizListenable": quizListenable,
      };
}
