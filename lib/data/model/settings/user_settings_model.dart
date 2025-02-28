class UserSettingsModel {
  bool? quizHidden;
  bool? notificationDisabled;

  UserSettingsModel({
    this.quizHidden,
    this.notificationDisabled,
  });

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) =>
      UserSettingsModel(
        quizHidden: json["quizHidden"],
        notificationDisabled: json["notificationDisabled"],
      );

  Map<String, dynamic> toJson() => {
        "quizHidden": quizHidden,
        "notificationDisabled": notificationDisabled,
      };
}
