
class GetChargesModel {
  bool status;
  String message;
  TranjectionHistoryModelList data;

  GetChargesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetChargesModel.fromJson(Map<String, dynamic> json) => GetChargesModel(
    status: json["status"],
    message: json["message"],
    data: TranjectionHistoryModelList.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class TranjectionHistoryModelList {
  String ?id;
  String? title;
  String ?logo;
  String? comission;
  String ?favicon;
  String ?cancellationCharges;
  String? smtpUsername;
  String? smtpHost;
  String ?smtpPassword;
  String ?email;
  String? places;
  String ?country;
  String ?communication;
  String? senderId;
  String? smsUsername;
  String? smsPassword;
  String ?languages;
  String? sidebar;
  String? paypal;
  String? paypalid;
  String? servSecretKey;
  String ?analaticCode;
  String ?measurements;
  String ?currency;
  String ?paypalOption;
  String? cardOption;
  String? verification;
  String? mechanicAssigned;
  String? authorizeNetUrl;
  String? authorizeKey;
  String ?authorizeId;
  String? braintreeMerchantId;
  String ?braintreePublicKey;
  String? braintreePrivateKey;
  String? userNumber;
  String ?driverNumber;
  String? walletBalance;
  String ?radius;
  String? commision;
  String? serviceGstCharge;
  String? walletAmount;
  String? adminCommision;
  String ?rideCancellationTime;
  String? nightIncentiveAmount;
  String ?morningHours;
  String? eventingHours;

  TranjectionHistoryModelList({
   this.id,
   this.title,
   this.logo,
   this.comission,
   this.favicon,
   this.cancellationCharges,
   this.smtpUsername,
   this.smtpHost,
   this.smtpPassword,
   this.email,
   this.places,
   this.country,
   this.communication,
   this.senderId,
   this.smsUsername,
   this.smsPassword,
   this.languages,
   this.sidebar,
   this.paypal,
   this.paypalid,
   this.servSecretKey,
   this.analaticCode,
   this.measurements,
   this.currency,
   this.paypalOption,
   this.cardOption,
   this.verification,
   this.mechanicAssigned,
   this.authorizeNetUrl,
   this.authorizeKey,
   this.authorizeId,
   this.braintreeMerchantId,
   this.braintreePublicKey,
   this.braintreePrivateKey,
   this.userNumber,
   this.driverNumber,
   this.walletBalance,
   this.radius,
   this.commision,
   this.serviceGstCharge,
   this.walletAmount,
   this.adminCommision,
   this.rideCancellationTime,
   this.nightIncentiveAmount,
   this.morningHours,
   this.eventingHours,
  });

  factory TranjectionHistoryModelList.fromJson(Map<String, dynamic> json) => TranjectionHistoryModelList(
    id: json["id"]??"",
    title: json["title"]??"",
    logo: json["logo"]??"",
    comission: json["comission"]??"",
    favicon: json["favicon"],
    cancellationCharges: json["cancellation_charges"]??"",
    smtpUsername: json["smtp_username"]??"",
    smtpHost: json["smtp_host"]??"",
    smtpPassword: json["smtp_password"]??"",
    email: json["email"]??"",
    places: json["places"]??"",
    country: json["country"]??"",
    communication: json["communication"]??"",
    senderId: json["sender_id"]??"",
    smsUsername: json["sms_username"]??"",
    smsPassword: json["sms_password"]??"",
    languages: json["languages"]??"",
    sidebar: json["sidebar"]??"",
    paypal: json["paypal"]??"",
    paypalid: json["paypalid"]??"",
    servSecretKey: json["serv_secret_key"]??"",
    analaticCode: json["analatic_code"]??"",
    measurements: json["measurements"]??"",
    currency: json["currency"]??"",
    paypalOption: json["paypal_option"]??"",
    cardOption: json["card_option"]??"",
    verification: json["verification"]??"",
    mechanicAssigned: json["mechanic_assigned"]??"",
    authorizeNetUrl: json["authorize_net_url"]??"",
    authorizeKey: json["authorize_key"]??"",
    authorizeId: json["authorize_id"]??"",
    braintreeMerchantId: json["braintree_merchant_id"]??"",
    braintreePublicKey: json["braintree_public_key"]??"",
    braintreePrivateKey: json["braintree_private_key"]??"",
    userNumber: json["user_number"]??"",
    driverNumber: json["driver_number"]??"",
    walletBalance: json["wallet_balance"]??"",
    radius: json["radius"]??"",
    commision: json["commision"]??"",
    serviceGstCharge: json["service_gst_charge"]??"",
    walletAmount: json["wallet_amount"]??"",
    adminCommision: json["admin_commision"]??"",
    rideCancellationTime: json["ride_cancellation_time"]??"",
    nightIncentiveAmount: json["night_incentive_amount"]??"",
    morningHours: json["morning_hours"]??"",
    eventingHours: json["eventing_hours"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "logo": logo,
    "comission": comission,
    "favicon": favicon,
    "cancellation_charges": cancellationCharges,
    "smtp_username": smtpUsername,
    "smtp_host": smtpHost,
    "smtp_password": smtpPassword,
    "email": email,
    "places": places,
    "country": country,
    "communication": communication,
    "sender_id": senderId,
    "sms_username": smsUsername,
    "sms_password": smsPassword,
    "languages": languages,
    "sidebar": sidebar,
    "paypal": paypal,
    "paypalid": paypalid,
    "serv_secret_key": servSecretKey,
    "analatic_code": analaticCode,
    "measurements": measurements,
    "currency": currency,
    "paypal_option": paypalOption,
    "card_option": cardOption,
    "verification": verification,
    "mechanic_assigned": mechanicAssigned,
    "authorize_net_url": authorizeNetUrl,
    "authorize_key": authorizeKey,
    "authorize_id": authorizeId,
    "braintree_merchant_id": braintreeMerchantId,
    "braintree_public_key": braintreePublicKey,
    "braintree_private_key": braintreePrivateKey,
    "user_number": userNumber,
    "driver_number": driverNumber,
    "wallet_balance": walletBalance,
    "radius": radius,
    "commision": commision,
    "service_gst_charge": serviceGstCharge,
    "wallet_amount": walletAmount,
    "admin_commision": adminCommision,
    "ride_cancellation_time": rideCancellationTime,
    "night_incentive_amount": nightIncentiveAmount,
    "morning_hours": morningHours,
    "eventing_hours": eventingHours,
  };
}
