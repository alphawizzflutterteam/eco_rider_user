
class CarTypeModel {
  bool status;
  String message;
  List<CarTypeModelList> data;

  CarTypeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CarTypeModel.fromJson(Map<String, dynamic> json) => CarTypeModel(
    status: json["status"],
    message: json["message"],
    data: json["data"]==null?[]:List<CarTypeModelList>.from(json["data"].map((x) => CarTypeModelList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CarTypeModelList {
  String? id;
  String ?carTypeId;
  String? carImage;
  String? carModel;
  String? status;

  CarTypeModelList({
     this.id,
     this.carTypeId,
     this.carImage,
     this.carModel,
     this.status,
  });

  factory CarTypeModelList.fromJson(Map<String, dynamic> json) => CarTypeModelList(
    id: json["id"],
    carTypeId: json["car_type_id"],
    carImage: json["car_image"],
    carModel: json["car_model"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "car_type_id": carTypeId,
    "car_image": carImage,
    "car_model": carModel,
    "status": status,
  };
}
