class ResponseApiModel {
  final String data;

  ResponseApiModel({
    required this.data,
  });

  factory ResponseApiModel.fromJson(Map<String, dynamic> json) =>
      ResponseApiModel(
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
