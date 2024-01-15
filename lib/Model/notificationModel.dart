
class NotificationModel {
  bool status;
  String message;
  List<NotifivationList> data;

  NotificationModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    status: json["status"],
    message: json["message"],
    data: List<NotifivationList>.from(json["data"].map((x) => NotifivationList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NotifivationList {
  String? id;
  String ?title;
  String? message;


  NotifivationList({
     this.id,
     this.title,
     this.message,

  });

  factory NotifivationList.fromJson(Map<String, dynamic> json) => NotifivationList(
    id: json["id"],
    title: json["title"],
    message: json["message"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,

  };
}
