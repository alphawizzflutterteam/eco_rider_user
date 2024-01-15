
class GetDriverModel {
  bool status;
  String message;
  List<GetDriverListModel> data;

  GetDriverModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetDriverModel.fromJson(Map<String, dynamic> json) => GetDriverModel(
    status: json["status"],
    message: json["message"],
    data: List<GetDriverListModel>.from(json["data"].map((x) => GetDriverListModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GetDriverListModel {
  String? userName;
  String?  phone;
  String ? email;
  String ? carNo;
  dynamic  licenseNo;
  String ? gender;
  String ? status;
  String ? bookingId;
  String?  area;
  String?  cityName;
  String?  carModel;
  String?  bookingTypes;
  String?  bookingotp;
  String?  bookingTime;
  String?  amount;
  String?  vehicleType;
  DateTime? reportingTime;

  GetDriverListModel({
     this.userName,
     this.phone,
     this.email,
     this.carNo,
     this.licenseNo,
     this.gender,
     this.status,
     this.bookingId,
     this.area,
     this.cityName,
     this.carModel,
     this.bookingTypes,
     this.bookingotp,
     this.bookingTime,
     this.amount,
     this.vehicleType,
    this.reportingTime,
  });

  factory GetDriverListModel.fromJson(Map<String, dynamic> json) => GetDriverListModel(
    userName:json["user_name"] ?? "",
    phone: json["phone"]?? "",
    email: json["email"]?? "",
    carNo: json["car_no"]?? "",
    licenseNo: json["license_no"]?? "",
    gender: json["gender"]?? "",
    status: json["status"]?? "",
    bookingId: json["booking_id"]?? "",
    area: json["area"],
    cityName: json["city_name"]?? "",
    carModel: json["car_model"]?? "",
    bookingTypes: json["booking_types"]?? "",
    bookingotp: json["booking_otp"]?? "",
    bookingTime: json["booking_time"]?? "",
    amount: json["amount"]?? "",
    vehicleType: json["vehicle_type"]?? "",
    reportingTime:json["reporting_time"]==null?DateTime.now() :DateTime.parse(json["reporting_time"]),
  );

  Map<String, dynamic> toJson() => {
    "user_name": userName,
    "phone": phone,
    "email": email,
    "car_no": carNo,
    "license_no": licenseNo,
    "gender": gender,
    "status": status,
    "booking_id": bookingId,
    "area": area,
    "city_name": cityName,
    "car_model": carModel,
    "booking_types": bookingTypes,
    "booking_otp": bookingotp,
    "booking_time": bookingTime,
    "amount": amount,
    "vehicle_type": vehicleType,
    "reporting_time":reportingTime,
  };
}
