class LoginModel {
  String? accessToken;
  String? refreshToken;
  String? userId;
  bool? hasLanguage;
  bool? emailConfirmed;
  bool? hasNotificationSetting;

  LoginModel({
    this.accessToken,
    this.refreshToken,
    this.hasLanguage,
    this.userId,
    this.emailConfirmed,
    this.hasNotificationSetting,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        userId: json["userId"],
        hasLanguage: json["hasLanguage"],
        emailConfirmed: json["emailConfirmed"],
        hasNotificationSetting: json["hasNotificationSetting"],
      );
}
