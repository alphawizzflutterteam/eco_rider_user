
class DurationDayModel {
  bool status;
  String message;
  List<DurationModelList> data;

  DurationDayModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DurationDayModel.fromJson(Map<String, dynamic> json) => DurationDayModel(
    status: json["status"],
    message: json["message"],
    data: List<DurationModelList>.from(json["data"].map((x) => DurationModelList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DurationModelList {
  String id;
  String title;
  String price;
  DateTime createdAt;

  DurationModelList({
    required this.id,
    required this.title,
    required this.price,
    required this.createdAt,
  });

  factory DurationModelList.fromJson(Map<String, dynamic> json) => DurationModelList(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "created_at": createdAt.toIso8601String(),
  };
}
