class TimeIntervalModel {
  int? id;
  String? name;
  int? minutes;

  TimeIntervalModel({
    this.id,
    this.name,
    this.minutes,
  });

  factory TimeIntervalModel.fromJson(Map<String, dynamic> json) => TimeIntervalModel(
    id: json["id"],
    name: json["name"],
    minutes: json["minutes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "minutes": minutes,
  };
}