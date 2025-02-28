import 'dart:developer';

class VerificationModel {
  String? accessToken;
  String? refreshToken;
  String userId;

  VerificationModel({
    this.accessToken,
    this.refreshToken,
    required this.userId,
  });

  factory VerificationModel.fromJson(Map<String, dynamic> json) {
    log("VerificationModel $json");
    return VerificationModel(
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      userId: json["userId"],
    );
  }
}
