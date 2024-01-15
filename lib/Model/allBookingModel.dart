
class BookingModel {
  bool status;
  String message;
  List<BookingModelList> data;

  BookingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    status: json["status"],
    message: json["message"],
    data:json["data"]==null?[]: List<BookingModelList>.from(json["data"].map((x) => BookingModelList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BookingModelList {
  String ?bookingId;
  String ?area;
  String ?cityName;
  String? carModel;
  String? bookingTypes;
  String? bookingTime;
  String ?amount;
  String ?vehicleType;

  String? status;

  BookingModelList({
    this.bookingId,
     this.area,
     this.cityName,
     this.carModel,
     this.bookingTypes,
     this.bookingTime,
     this.amount,
     this.vehicleType,

     this.status,
  });

  factory BookingModelList.fromJson(Map<String, dynamic> json) => BookingModelList(

    bookingId:json["booking_id"]==null?"" :json["booking_id"],
    area:json["area"]==null?"" : json["area"],
    cityName:json["city_name"]==null?"" : json["city_name"],
    carModel: json["car_model"]==null?"" :json["car_model"],
    bookingTypes:json["booking_types"]==null?"" : json["booking_types"],
    bookingTime:json["booking_time"]==null?"" : json["booking_time"],
    amount:json["amount"]==null?"" : json["amount"],
    vehicleType:json["vehicle_type"]==null?"" : json["vehicle_type"],
    status:json["status"]==null?"" : json["status"],
  );

  Map<String, dynamic> toJson() => {

    "booking_id": bookingId,
    "area": area,
    "city_name": cityName,
    "car_model": carModel,
    "booking_types": bookingTypes,
    "booking_time": bookingTime,
    "amount": amount,
    "vehicle_type": vehicleType,
    "status": status,
  };
}
