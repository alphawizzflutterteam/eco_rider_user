class GetChargeModel {
  bool? status;
  String? message;
  ChargeData? data;

  GetChargeModel({this.status, this.message, this.data});

  GetChargeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ChargeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ChargeData {
  dynamic totalHours;
  dynamic nightHours;
  dynamic perHourCharge;
  dynamic nightChargePerHour;
  dynamic baseAmount;
  dynamic nightCharge;
  dynamic totalAmount;
  dynamic type;
  dynamic fromDate;
  dynamic fromTime;
  dynamic toDate;
  dynamic toTime;
  Cars? cars;

  ChargeData(
      {this.totalHours,
      this.nightHours,
      this.perHourCharge,
      this.nightChargePerHour,
      this.baseAmount,
      this.nightCharge,
      this.totalAmount,
      this.type,
      this.fromDate,
      this.fromTime,
      this.toDate,
      this.toTime,
      this.cars});

  ChargeData.fromJson(Map<String, dynamic> json) {
    totalHours = json['total_hours'];
    nightHours = json['night_hours'];
    perHourCharge = json['per_hour_charge'];
    nightChargePerHour = json['night_charge_per_hour'];
    baseAmount = json['base_amount'];
    nightCharge = json['night_charge'];
    totalAmount = json['total_amount'];
    type = json['type'];
    fromDate = json['from_date'];
    fromTime = json['from_time'];
    toDate = json['to_date'];
    toTime = json['to_time'];
    cars = json['cars'] != null ? new Cars.fromJson(json['cars']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_hours'] = this.totalHours;
    data['night_hours'] = this.nightHours;
    data['per_hour_charge'] = this.perHourCharge;
    data['night_charge_per_hour'] = this.nightChargePerHour;
    data['base_amount'] = this.baseAmount;
    data['night_charge'] = this.nightCharge;
    data['total_amount'] = this.totalAmount;
    data['type'] = this.type;
    data['from_date'] = this.fromDate;
    data['from_time'] = this.fromTime;
    data['to_date'] = this.toDate;
    data['to_time'] = this.toTime;
    if (this.cars != null) {
      data['cars'] = this.cars!.toJson();
    }
    return data;
  }
}

class Cars {
  String? id;
  dynamic carTypeId;
  String? carImage;
  String? carModel;
  String? status;
  String? isMinioutstation;
  String? perHourCharges;
  String? carImagePath;

  Cars(
      {this.id,
      this.carTypeId,
      this.carImage,
      this.carModel,
      this.status,
      this.isMinioutstation,
      this.perHourCharges,
      this.carImagePath});

  Cars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carTypeId = json['car_type_id'];
    carImage = json['car_image'];
    carModel = json['car_model'];
    status = json['status'];
    isMinioutstation = json['is_minioutstation'];
    perHourCharges = json['per_hour_charges'];
    carImagePath = json['car_image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['car_type_id'] = this.carTypeId;
    data['car_image'] = this.carImage;
    data['car_model'] = this.carModel;
    data['status'] = this.status;
    data['is_minioutstation'] = this.isMinioutstation;
    data['per_hour_charges'] = this.perHourCharges;
    data['car_image_path'] = this.carImagePath;
    return data;
  }
}
