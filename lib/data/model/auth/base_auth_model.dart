class BaseAuthModel {
  String? userId;
  String? codeExpiry;

  BaseAuthModel({
    this.userId,
    this.codeExpiry,
  });

  factory BaseAuthModel.fromJson(Map<String, dynamic> json) => BaseAuthModel(
    userId: json["userId"],
    codeExpiry: json["codeExpiry"],
  );
}
