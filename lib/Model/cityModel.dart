
class CityModel {
  bool status;
  String message;
  List<CityList> data;

  CityModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    status: json["status"],
    message: json["message"],
    data: List<CityList>.from(json["data"].map((x) => CityList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CityList {
  String id;
  String name;
  String status;

  CityList({
    required this.id,
    required this.name,
    required this.status,
  });

  factory CityList.fromJson(Map<String, dynamic> json) => CityList(
    id: json["id"],
    name: json["name"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
  };
}
