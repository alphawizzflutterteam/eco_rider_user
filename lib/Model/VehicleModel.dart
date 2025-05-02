/// status : true
/// message : "Get car detail"
/// data : [{"id":"64","car_type_id":"1","car_image":null,"car_model":"SUV","status":"1","is_minioutstation":"2","per_hour_charges":"0"}]

class VehicleModel {
  VehicleModel({
    bool? status,
    String? message,
    List<VehcileData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  VehicleModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(VehcileData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<VehcileData>? _data;
  VehicleModel copyWith({
    bool? status,
    String? message,
    List<VehcileData>? data,
  }) =>
      VehicleModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<VehcileData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "64"
/// car_type_id : "1"
/// car_image : null
/// car_model : "SUV"
/// status : "1"
/// is_minioutstation : "2"
/// per_hour_charges : "0"

class VehcileData {
  VehcileData({
    String? id,
    String? carTypeId,
    dynamic carImage,
    String? carModel,
    String? status,
    String? isMinioutstation,
    String? perHourCharges,
  }) {
    _id = id;
    _carTypeId = carTypeId;
    _carImage = carImage;
    _carModel = carModel;
    _status = status;
    _isMinioutstation = isMinioutstation;
    _perHourCharges = perHourCharges;
  }

  VehcileData.fromJson(dynamic json) {
    _id = json['id'];
    _carTypeId = json['car_type_id'];
    _carImage = json['car_image_path'];
    _carModel = json['car_model'];
    _status = json['status'];
    _isMinioutstation = json['is_minioutstation'];
    _perHourCharges = json['per_hour_charges'];
  }
  String? _id;
  String? _carTypeId;
  dynamic _carImage;
  String? _carModel;
  String? _status;
  String? _isMinioutstation;
  String? _perHourCharges;
  VehcileData copyWith({
    String? id,
    String? carTypeId,
    dynamic carImage,
    String? carModel,
    String? status,
    String? isMinioutstation,
    String? perHourCharges,
  }) =>
      VehcileData(
        id: id ?? _id,
        carTypeId: carTypeId ?? _carTypeId,
        carImage: carImage ?? _carImage,
        carModel: carModel ?? _carModel,
        status: status ?? _status,
        isMinioutstation: isMinioutstation ?? _isMinioutstation,
        perHourCharges: perHourCharges ?? _perHourCharges,
      );
  String? get id => _id;
  String? get carTypeId => _carTypeId;
  dynamic get carImage => _carImage;
  String? get carModel => _carModel;
  String? get status => _status;
  String? get isMinioutstation => _isMinioutstation;
  String? get perHourCharges => _perHourCharges;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['car_type_id'] = _carTypeId;
    map['car_image'] = _carImage;
    map['car_model'] = _carModel;
    map['status'] = _status;
    map['is_minioutstation'] = _isMinioutstation;
    map['per_hour_charges'] = _perHourCharges;
    return map;
  }
}
