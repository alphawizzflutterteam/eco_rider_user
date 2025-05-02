/// status : true
/// message : "Trip Type Get Successfully"
/// need_help : [{"id":"1","type":"In City","image":"https://developmentalphawizz.com/eco_rider/upload/trip_1745490153.png","created_at":"2025-04-25 11:30:14","update_at":null},{"id":"2","type":"In City One Way","image":"https://developmentalphawizz.com/eco_rider/upload/trip_1745490153.png","created_at":"2025-04-25 11:02:26","update_at":null},{"id":"3","type":"Mini Outstation","image":"https://developmentalphawizz.com/eco_rider/upload/trip_1745560736.png","created_at":null,"update_at":null},{"id":"4","type":"Outstation","image":"https://developmentalphawizz.com/eco_rider/upload/trip_1745560756.png","created_at":null,"update_at":null}]

class CabTypeModel {
  CabTypeModel({
    bool? status,
    String? message,
    List<CabData>? needHelp,
  }) {
    _status = status;
    _message = message;
    _needHelp = needHelp;
  }

  CabTypeModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['need_help'] != null) {
      _needHelp = [];
      json['need_help'].forEach((v) {
        _needHelp?.add(CabData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<CabData>? _needHelp;
  CabTypeModel copyWith({
    bool? status,
    String? message,
    List<CabData>? needHelp,
  }) =>
      CabTypeModel(
        status: status ?? _status,
        message: message ?? _message,
        needHelp: needHelp ?? _needHelp,
      );
  bool? get status => _status;
  String? get message => _message;
  List<CabData>? get needHelp => _needHelp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_needHelp != null) {
      map['need_help'] = _needHelp?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "1"
/// type : "In City"
/// image : "https://developmentalphawizz.com/eco_rider/upload/trip_1745490153.png"
/// created_at : "2025-04-25 11:30:14"
/// update_at : null

class CabData {
  CabData({
    String? id,
    String? type,
    String? image,
    String? createdAt,
    dynamic updateAt,
  }) {
    _id = id;
    _type = type;
    _image = image;
    _createdAt = createdAt;
    _updateAt = updateAt;
  }

  CabData.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updateAt = json['update_at'];
  }
  String? _id;
  String? _type;
  String? _image;
  String? _createdAt;
  dynamic _updateAt;
  CabData copyWith({
    String? id,
    String? type,
    String? image,
    String? createdAt,
    dynamic updateAt,
  }) =>
      CabData(
        id: id ?? _id,
        type: type ?? _type,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updateAt: updateAt ?? _updateAt,
      );
  String? get id => _id;
  String? get type => _type;
  String? get image => _image;
  String? get createdAt => _createdAt;
  dynamic get updateAt => _updateAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['update_at'] = _updateAt;
    return map;
  }
}
