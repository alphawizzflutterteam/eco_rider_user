/// status : true
/// message : "Transactions fetched successfully."
/// data : [{"id":"1","user_id":"15","booking_id":"21","amount":"21978.33","payment_mode":"Cash","transaction_id":"null","created_at":null},{"id":"2","user_id":"15","booking_id":"22","amount":"12225.0","payment_mode":"Cash","transaction_id":"null","created_at":null},{"id":"3","user_id":"15","booking_id":"23","amount":"2370.0","payment_mode":"Razorpay","transaction_id":"pay_QPb7nVDoxKoEY7","created_at":"2025-05-01 13:54:59"}]

class GetTransactionModel {
  GetTransactionModel({
    bool? status,
    String? message,
    List<TransactionData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetTransactionModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TransactionData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<TransactionData>? _data;
  GetTransactionModel copyWith({
    bool? status,
    String? message,
    List<TransactionData>? data,
  }) =>
      GetTransactionModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<TransactionData>? get data => _data;

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

/// id : "1"
/// user_id : "15"
/// booking_id : "21"
/// amount : "21978.33"
/// payment_mode : "Cash"
/// transaction_id : "null"
/// created_at : null

class TransactionData {
  TransactionData({
    String? id,
    String? userId,
    String? bookingId,
    String? amount,
    String? paymentMode,
    String? transactionId,
    dynamic createdAt,
  }) {
    _id = id;
    _userId = userId;
    _bookingId = bookingId;
    _amount = amount;
    _paymentMode = paymentMode;
    _transactionId = transactionId;
    _createdAt = createdAt;
  }

  TransactionData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _bookingId = json['booking_id'];
    _amount = json['amount'];
    _paymentMode = json['payment_mode'];
    _transactionId = json['transaction_id'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _userId;
  String? _bookingId;
  String? _amount;
  String? _paymentMode;
  String? _transactionId;
  dynamic _createdAt;
  TransactionData copyWith({
    String? id,
    String? userId,
    String? bookingId,
    String? amount,
    String? paymentMode,
    String? transactionId,
    dynamic createdAt,
  }) =>
      TransactionData(
        id: id ?? _id,
        userId: userId ?? _userId,
        bookingId: bookingId ?? _bookingId,
        amount: amount ?? _amount,
        paymentMode: paymentMode ?? _paymentMode,
        transactionId: transactionId ?? _transactionId,
        createdAt: createdAt ?? _createdAt,
      );
  String? get id => _id;
  String? get userId => _userId;
  String? get bookingId => _bookingId;
  String? get amount => _amount;
  String? get paymentMode => _paymentMode;
  String? get transactionId => _transactionId;
  dynamic get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['booking_id'] = _bookingId;
    map['amount'] = _amount;
    map['payment_mode'] = _paymentMode;
    map['transaction_id'] = _transactionId;
    map['created_at'] = _createdAt;
    return map;
  }
}
