class PromoCodeListModel {
  bool? status;
  String? message;
  List<PromoData>? data;

  PromoCodeListModel({this.status, this.message, this.data});

  PromoCodeListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PromoData>[];
      json['data'].forEach((v) {
        data!.add(PromoData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PromoData {
  String? id;
  String? promocode;
  String? type;
  String? amount;
  String? startdate;
  String? enddate;
  String? status;
  dynamic discount;
  String? message;
  String? userId;
  String? minOrderAmount;
  String? maxOrderAmount;
  dynamic tueStatus;
  String? noUsers;
  String? usedCount;
  String? vehicleType;
  String? promoUsedCounter;
  String? userPromoUsageCounter;

  PromoData(
      {this.id,
      this.promocode,
      this.type,
      this.amount,
      this.startdate,
      this.enddate,
      this.status,
      this.discount,
      this.message,
      this.userId,
      this.minOrderAmount,
      this.maxOrderAmount,
      this.tueStatus,
      this.noUsers,
      this.usedCount,
      this.vehicleType,
      this.promoUsedCounter,
      this.userPromoUsageCounter});

  PromoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    promocode = json['promocode'];
    type = json['type'];
    amount = json['amount'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    status = json['status'];
    discount = json['discount'];
    message = json['message'];
    userId = json['user_id'];
    minOrderAmount = json['min_order_amount'];
    maxOrderAmount = json['max_order_amount'];
    tueStatus = json['tue_status'];
    noUsers = json['no_users'];
    usedCount = json['used_count'];
    vehicleType = json['vehicle_type'];
    promoUsedCounter = json['promo_used_counter'];
    userPromoUsageCounter = json['user_promo_usage_counter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['promocode'] = this.promocode;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['startdate'] = this.startdate;
    data['enddate'] = this.enddate;
    data['status'] = this.status;
    data['discount'] = this.discount;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['min_order_amount'] = this.minOrderAmount;
    data['max_order_amount'] = this.maxOrderAmount;
    data['tue_status'] = this.tueStatus;
    data['no_users'] = this.noUsers;
    data['used_count'] = this.usedCount;
    data['vehicle_type'] = this.vehicleType;
    data['promo_used_counter'] = this.promoUsedCounter;
    data['user_promo_usage_counter'] = this.userPromoUsageCounter;
    return data;
  }
}
