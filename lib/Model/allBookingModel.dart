
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
    data: List<BookingModelList>.from(json["data"].map((x) => BookingModelList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class BookingModelList {
  String?bookingId;
  String? area;
  String? pickupAddress;
  String? dropAddress;
  String? inOutCity;
  String? oneTowWay;
  String? pickupDate;
  String? pickupTime;
  String? carModel;
  String? bookingTypes;
  String? bookingTime;
  String? amount;
  String? reporting;
  String? vehicleType;
  String? userName;
  String ?status;

  BookingModelList({
    this.bookingId,
    this.area,
    this.pickupAddress,
    this.dropAddress,
    this.inOutCity,
    this.oneTowWay,
    this.pickupDate,
    this.pickupTime,
    this.carModel,
    this.bookingTypes,
    this.bookingTime,
    this.amount,
    this.reporting,
    this.vehicleType,
    this.userName,
    this.status,
  });

  factory BookingModelList.fromJson(Map<String, dynamic> json) => BookingModelList(
    bookingId: json["booking_id"]??"",
    area: json["area"]??"",
    pickupAddress: json["pickup_address"]??"",
    dropAddress: json["drop_address"]??"",
    inOutCity: json["in_out_city"]??"",
    oneTowWay: json["one_tow_way"]??"",
    pickupDate: json["pickup_date"]??"",
    pickupTime: json["pickup_time"]??"",
    carModel: json["car_model"]??"",
    bookingTypes: json["booking_types"]??"",
    bookingTime: json["booking_time"]??"",
    amount: json["amount"]??"",
    reporting: json["reporting_time"]??"",
    vehicleType: json["vehicle_type"]??"",
    userName: json["user_name"]??"",
    status: json["status"]??"",
  );

  Map<String, dynamic> toJson() => {
    "booking_id": bookingId,
    "area": area,
    "pickup_address": pickupAddress,
    "drop_address": dropAddress,
    "in_out_city": inOutCity,
    "one_tow_way": oneTowWay,
    "pickup_date": pickupDate,
    "pickup_time": pickupTime,
    "car_model": carModel,
    "booking_types": bookingTypes,
    "booking_time": bookingTime,
    "amount": amount,
    "reporting_time": reporting,
    "vehicle_type": vehicleType,
    "user_name": userName,
    "status": status,
  };
}
