class TimingModel {
  int? intervalId;
  String? startTime;
  String? endTime;

  TimingModel({
    this.intervalId,
    this.startTime,
    this.endTime,
  });



  factory TimingModel.fromJson(Map<String, dynamic> json) => TimingModel(
    intervalId: json["intervalId"],
    startTime: json["startTime"],
    endTime: json["endTime"],
  );
}
