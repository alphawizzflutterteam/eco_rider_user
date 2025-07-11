class BookingModel {
  bool? status;
  String? message;
  BookingModelList? data;

  BookingModel({this.status, this.message, this.data});

  BookingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? BookingModelList.fromJson(json['data']) : null;
  }
}

class BookingModelList {
  List<BookingDataModel>? upcomingbooking;
  List<BookingDataModel>? pastbooking;

  BookingModelList({this.upcomingbooking, this.pastbooking});

  BookingModelList.fromJson(Map<String, dynamic> json) {
    if (json['upcomingbooking'] != null) {
      upcomingbooking = List<BookingDataModel>.from(
        json['upcomingbooking'].map((x) => BookingDataModel.fromJson(x)),
      );
    }
    if (json['pastbooking'] != null) {
      pastbooking = List<BookingDataModel>.from(
        json['pastbooking'].map((x) => BookingDataModel.fromJson(x)),
      );
    }
  }
}

class BookingDataModel {
  String? id;
  String? userId;
  String? uneaqueId;
  dynamic purpose;
  dynamic driverId;
  dynamic pickupArea;
  String? pickupDate;
  dynamic dropArea;
  String? pickupTime;
  dynamic area;
  dynamic landmark;
  String? pickupAddress;
  String? dropAddress;
  String? vehicleId;
  dynamic oneTowWay;
  String? manualType;
  dynamic taxiModal;
  dynamic departureTime;
  dynamic departureDate;
  dynamic returnDate;
  dynamic flightNumber;
  dynamic package;
  dynamic promoCode;
  dynamic distance;
  String? amount;
  String? paidAmount;
  dynamic address;
  dynamic transfer;
  dynamic itemStatus;
  String? transaction;
  String? paymentMedia;
  dynamic km;
  dynamic duration;
  String? assignedFor;
  String? isPaidAdvance;
  String? status;
  String? latitude;
  String? longitude;
  String? dateAdded;
  dynamic dropLatitude;
  dynamic dropLongitude;
  dynamic bookingType;
  String? acceptReject;
  String? createdDate;
  dynamic username;
  dynamic reason;
  dynamic surgeAmount;
  dynamic gstAmount;
  String? baseFare;
  String? perHourCharge;
  dynamic ratePerKm;
  dynamic adminCommision;
  dynamic totalTime;
  dynamic cancelCharge;
  String? nightCharge;
  dynamic startTime;
  dynamic taxiId;
  String? nightHours;
  dynamic bookingTime;
  dynamic bookingTimes;
  dynamic bookingTypes;
  dynamic shareingType;
  dynamic sharingUserId;
  String? promoDiscount;
  dynamic paymentStatus;
  String? bookingOtp;
  dynamic deliveryType;
  dynamic otpStatus;
  dynamic extraTimeCharge;
  dynamic extraKmCharge;
  dynamic pickupCity;
  dynamic dropCity;
  String? dropDate;
  String? dropTime;
  dynamic addOnDistance;
  dynamic estimateAmountWallet;
  String? nightChargePerHour;
  dynamic initialAmount;
  dynamic taxPercentage;
  dynamic reportingTime;
  dynamic adminPercentage;
  String? cancelRide;
  String? bookingStartTime;
  dynamic endTime;
  String? startOtp;
  dynamic gstCharge;
  dynamic platfarmCharge;
  dynamic driverAmount;
  dynamic driverName;
  dynamic driverNumber;
  String? tripId;
  String? bookingId;
  String? tripType;
  String? tripImage;
  String? carModel;
  String? carImage;
  String? driverLat;
  String? driverLong;
  String? driverRating;
  bool? ratingGiven;
  String? driverImage;
  dynamic userName;

  BookingDataModel(
      {this.id,
      this.userId,
      this.uneaqueId,
      this.purpose,
      this.driverId,
      this.pickupArea,
      this.pickupDate,
      this.dropArea,
      this.pickupTime,
      this.area,
      this.landmark,
      this.pickupAddress,
      this.dropAddress,
      this.vehicleId,
      this.oneTowWay,
      this.manualType,
      this.taxiModal,
      this.departureTime,
      this.departureDate,
      this.returnDate,
      this.flightNumber,
      this.package,
      this.promoCode,
      this.distance,
      this.amount,
      this.paidAmount,
      this.address,
      this.transfer,
      this.itemStatus,
      this.transaction,
      this.paymentMedia,
      this.km,
      this.duration,
      this.assignedFor,
      this.isPaidAdvance,
      this.status,
      this.latitude,
      this.longitude,
      this.dateAdded,
      this.dropLatitude,
      this.dropLongitude,
      this.bookingType,
      this.acceptReject,
      this.createdDate,
      this.username,
      this.reason,
      this.surgeAmount,
      this.gstAmount,
      this.baseFare,
      this.perHourCharge,
      this.ratePerKm,
      this.adminCommision,
      this.totalTime,
      this.cancelCharge,
      this.nightCharge,
      this.startTime,
      this.taxiId,
      this.nightHours,
      this.bookingTime,
      this.bookingTimes,
      this.bookingTypes,
      this.shareingType,
      this.sharingUserId,
      this.promoDiscount,
      this.paymentStatus,
      this.bookingOtp,
      this.deliveryType,
      this.otpStatus,
      this.extraTimeCharge,
      this.extraKmCharge,
      this.pickupCity,
      this.dropCity,
      this.dropDate,
      this.dropTime,
      this.addOnDistance,
      this.estimateAmountWallet,
      this.nightChargePerHour,
      this.initialAmount,
      this.taxPercentage,
      this.reportingTime,
      this.adminPercentage,
      this.cancelRide,
      this.bookingStartTime,
      this.endTime,
      this.startOtp,
      this.gstCharge,
      this.platfarmCharge,
      this.driverAmount,
      this.driverName,
      this.driverNumber,
      this.tripId,
      this.bookingId,
      this.tripType,
      this.tripImage,
      this.carModel,
      this.carImage,
      this.userName,
      this.driverLat,
      this.driverLong,
      this.driverImage,
      this.ratingGiven,
      this.driverRating});

  BookingDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    uneaqueId = json['uneaque_id'];
    purpose = json['purpose'];
    driverId = json['driver_id'];
    pickupArea = json['pickup_area'];
    pickupDate = json['pickup_date'];
    dropArea = json['drop_area'];
    pickupTime = json['pickup_time'];
    area = json['area'];
    landmark = json['landmark'];
    pickupAddress = json['pickup_address'];
    dropAddress = json['drop_address'];
    vehicleId = json['vehicle_id'];
    oneTowWay = json['one_tow_way'];
    manualType = json['manual_type'];
    taxiModal = json['taxi_modal'];
    departureTime = json['departure_time'];
    departureDate = json['departure_date'];
    returnDate = json['return_date'];
    flightNumber = json['flight_number'];
    package = json['package'];
    promoCode = json['promo_code'];
    distance = json['distance'];
    amount = json['amount'];
    paidAmount = json['paid_amount'];
    address = json['address'];
    transfer = json['transfer'];
    itemStatus = json['item_status'];
    transaction = json['transaction'];
    paymentMedia = json['payment_media'];
    km = json['km'];
    duration = json['duration'];
    assignedFor = json['assigned_for'];
    isPaidAdvance = json['is_paid_advance'];
    status = json['status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    dateAdded = json['date_added'];
    dropLatitude = json['drop_latitude'];
    dropLongitude = json['drop_longitude'];
    bookingType = json['booking_type'];
    acceptReject = json['accept_reject'];
    createdDate = json['created_date'];
    username = json['username'];
    reason = json['reason'];
    surgeAmount = json['surge_amount'];
    gstAmount = json['gst_amount'];
    baseFare = json['base_fare'];
    perHourCharge = json['per_hour_charge'];
    ratePerKm = json['rate_per_km'];
    adminCommision = json['admin_commision'];
    totalTime = json['total_time'];
    cancelCharge = json['cancel_charge'];
    nightCharge = json['night_charge'];
    startTime = json['start_time'];
    taxiId = json['taxi_id'];
    nightHours = json['night_hours'];
    bookingTime = json['booking_time'];
    bookingTimes = json['booking_times'];
    bookingTypes = json['booking_types'];
    shareingType = json['shareing_type'];
    sharingUserId = json['sharing_user_id'];
    promoDiscount = json['promo_discount'];
    paymentStatus = json['payment_status'];
    bookingOtp = json['booking_otp'];
    deliveryType = json['delivery_type'];
    otpStatus = json['otp_status'];
    extraTimeCharge = json['extra_time_charge'];
    extraKmCharge = json['extra_km_charge'];
    pickupCity = json['pickup_city'];
    dropCity = json['drop_city'];
    dropDate = json['drop_date'];
    dropTime = json['drop_time'];
    addOnDistance = json['add_on_distance'];
    estimateAmountWallet = json['estimate_amount_wallet'];
    nightChargePerHour = json['night_charge_per_hour'];
    initialAmount = json['initial_amount'];
    taxPercentage = json['tax_percentage'];
    reportingTime = json['reporting_time'];
    adminPercentage = json['admin_percentage'];
    cancelRide = json['cancel_ride'];
    bookingStartTime = json['booking_start_time'];
    endTime = json['end_time'];
    startOtp = json['start_otp'];
    gstCharge = json['gst_charge'];
    platfarmCharge = json['platfarm_charge'];
    driverAmount = json['driver_amount'];
    driverName = json['driver_name'];
    driverNumber = json['driver_number'];
    tripId = json['trip_id'];
    bookingId = json['booking_id'];
    tripType = json['trip_type'];
    tripImage = json['trip_image'];
    carModel = json['car_model'];
    carImage = json['car_image'];
    userName = json['user_name'];
    driverLat = json['driver_lat'];
    driverLong = json['driver_long'];
    driverImage = json['driver_image'];
    driverRating = json['driver_rating'];
    ratingGiven = json['rating_given'];
  }
}
