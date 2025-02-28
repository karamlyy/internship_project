class ForgotPasswordModel {
  String? userId;
  String? codeExpiry;



  ForgotPasswordModel({
    this.userId,
    this.codeExpiry,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
    userId: json["userId"],
    codeExpiry: json["codeExpiry"],
  );
}
