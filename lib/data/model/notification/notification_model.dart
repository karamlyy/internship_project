class NotificationModel {
  int? id;
  String? title;
  String? body;
  String? createdOn;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.createdOn,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"],
      title: json["title"],
      body: json["body"],
      createdOn: json["createdOn"],
    );
  }
}
