class FileModel {
  String? name;
  String? contentType;
  String? fileContent;

  FileModel({
    this.name,
    this.contentType,
    this.fileContent,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => FileModel(
    name: json["name"],
    contentType: json["contentType"],
    fileContent: json["fileContent"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "contentType": contentType,
    "fileContent": fileContent,
  };
}