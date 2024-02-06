
class TranjectionHistory {
  bool status;
  String message;
  String total;
  List<TranjectionHistoryModel> data;

  TranjectionHistory({
    required this.status,
    required this.message,
    required this.total,
    required this.data,
  });

  factory TranjectionHistory.fromJson(Map<String, dynamic> json) => TranjectionHistory(
    status: json["status"],
    message: json["message"],
    total: json["total"],
    data: List<TranjectionHistoryModel>.from(json["data"].map((x) => TranjectionHistoryModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class TranjectionHistoryModel {
  String?walletId;
  String? driverId;
  String ?userId;
  String? bookingId;
  String ?crDr;
  String? note;
  String? balance;
  String? mid;
  String? txnId;
  String? txnAmount;
  String? paymentMode;
  String? currency;
  String? txnDate;
  String? status;
  String? respcode;
  String ?respmsg;
  String ?gatewayName;
  String ?bankTxnId;
  String? bankName;
  String? checksumhash;
  String? totalBalance;
  String ?dateAdded;
  String ?dateModified;
  String? incentiveStatus;
  String? numberTrips;
  String? fromDate;
  String? toDate;
  String? refferalStatus;
  String? incentiveId;
  String? incentiveBounusStatus;
  String? bookingTrip;
  String? adminPay;
  String? time;
  String? refferaId;
  String? sign;

  TranjectionHistoryModel({
     this.walletId,
     this.driverId,
     this.userId,
     this.bookingId,
     this.crDr,
     this.note,
     this.balance,
     this.mid,
     this.txnId,
     this.txnAmount,
     this.paymentMode,
     this.currency,
     this.txnDate,
     this.status,
     this.respcode,
     this.respmsg,
     this.gatewayName,
     this.bankTxnId,
     this.bankName,
     this.checksumhash,
     this.totalBalance,
     this.dateAdded,
     this.dateModified,
     this.incentiveStatus,
     this.numberTrips,
     this.fromDate,
     this.toDate,
     this.refferalStatus,
     this.incentiveId,
     this.incentiveBounusStatus,
     this.bookingTrip,
     this.adminPay,
     this.time,
     this.refferaId,
     this.sign,
  });

  factory TranjectionHistoryModel.fromJson(Map<String, dynamic> json) => TranjectionHistoryModel(
    walletId: json["wallet_id"]??"",
    driverId: json["driver_id"]??"",
    userId: json["user_id"]??"",
    bookingId: json["booking_id"]??"",
    crDr: json["cr_dr"]??"",
    note: json["Note"]??"",
    balance: json["balance"]??"",
    mid: json["mid"]??"",
    txnId: json["txn_id"]??"",
    txnAmount: json["txn_amount"]??"",
    paymentMode: json["payment_mode"]??"",
    currency: json["currency"]??"",
    txnDate: json["txn_date"],
    status: json["status"]??"",
    respcode: json["respcode"]??"",
    respmsg: json["respmsg"]??"",
    gatewayName: json["gateway_name"]??"",
    bankTxnId: json["bank_txn_id"]??"",
    bankName: json["bank_name"]??"",
    checksumhash: json["checksumhash"]??"",
    totalBalance: json["total_balance"]??"",
    dateAdded: json["date_added"]??"",
    dateModified: json["date_modified"]??"",
    incentiveStatus: json["incentive_status"]??"",
    numberTrips: json["number_trips"]??"",
    fromDate: json["from_date"]??"",
    toDate: json["to_date"]??"",
    refferalStatus: json["refferal_status"]??"",
    incentiveId: json["incentive_id"]??"",
    incentiveBounusStatus: json["incentive_bounus_status"]??"",
    bookingTrip: json["booking_trip"]??"",
    adminPay: json["admin_pay"]??"",
    time: json["time"]??"",
    refferaId: json["reffera_id"]??"",
    sign: json["sign"]??"",
  );

  Map<String, dynamic> toJson() => {
    "wallet_id": walletId,
    "driver_id": driverId,
    "user_id": userId,
    "booking_id": bookingId,
    "cr_dr": crDr,
    "Note": note,
    "balance": balance,
    "mid": mid,
    "txn_id": txnId,
    "txn_amount": txnAmount,
    "payment_mode": paymentMode,
    "currency": currency,
    "txn_date": txnDate,
    "status": status,
    "respcode": respcode,
    "respmsg": respmsg,
    "gateway_name": gatewayName,
    "bank_txn_id": bankTxnId,
    "bank_name": bankName,
    "checksumhash": checksumhash,
    "total_balance": totalBalance,
    "date_added": dateAdded,
    "date_modified": dateModified,
    "incentive_status": incentiveStatus,
    "number_trips": numberTrips,
    "from_date": fromDate,
    "to_date": toDate,
    "refferal_status": refferalStatus,
    "incentive_id": incentiveId,
    "incentive_bounus_status": incentiveBounusStatus,
    "booking_trip": bookingTrip,
    "admin_pay": adminPay,
    "time": time,
    "reffera_id": refferaId,
    "sign": sign,
  };
}
