import 'dart:async';

import 'package:eco_rider_user/Screen/Mybooking/mybookingScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../Api services/api_services/apiBasehelper.dart';
import '../Api services/api_services/apiStrings.dart';
import '../Helper/Colors.dart';
import '../Helper/customeTost.dart';
import '../Helper/loadingwidget.dart';
import '../Model/ChargeModel.dart';
import '../Model/PromoCodeList.dart';
import '../Model/VehicleModel.dart';
import '../Widget/custom_app_button.dart';

class SelectVehicle extends StatefulWidget {
  String? cabId,
      dropAddress,
      pickAddress,
      dropLat,
      dropLng,
      pickupLat,
      pickupLong;
  SelectVehicle(
      {Key? key,
      this.cabId,
      this.dropAddress,
      this.pickAddress,
      this.dropLat,
      this.pickupLong,
      this.pickupLat,
      this.dropLng})
      : super(key: key);

  @override
  State<SelectVehicle> createState() => _SelectVehicleState();
}

class _SelectVehicleState extends State<SelectVehicle> {
  GoogleMapController? mapController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lat = widget.pickupLat;
    long = widget.pickupLong;
    destination = LatLng(double.parse(widget.dropLat ?? '22.719568'),
        double.parse(widget.dropLng ?? '75.857727'));
    _razorpayy = Razorpay();
    _razorpayy!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpayy!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpayy!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    //getUserCurrentLocation();
    getVehicle();
    getPromoList();
  }

  String? transactionId;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    transactionId = response.paymentId.toString();
    confirmbooking();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Cancel");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  Razorpay? _razorpayy;

  int? pricerazorpayy;
  void openCheckout(amount) async {
    double res = double.parse(amount.toString());
    pricerazorpayy = int.parse(res.toStringAsFixed(0)) * 100;
    var options = {
      'key': 'rzp_test_UUBtmcArqOLqIY',
      'amount': "$pricerazorpayy",
      'name': 'EcoRider',
      'image': 'assets/images/Group 165.png',
      'description': 'EcoRider',
    };
    try {
      _razorpayy?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  bool isLoading = false;
  var userId;

  Future<void> confirmbooking() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    var param = {
      'user_id': userId.toString(),
      'trip_id': widget.cabId.toString(),
      'vehicle_id': selectVehicleId.toString(),
      // 'total_hours': totalHours.toString(),
      'night_hours': nightHours.toString(),
      'promo_discount': promoCode.toString(),
      'per_hour_charge': perHourCharge.toString(),
      'night_charge_per_hour': nightChargePerHour.toString(),
      'base_amount': baseAmount.toString(),
      'night_charge': nightCharge.toString(),
      'total_amount': finalAmt.toString(),
      'pickup_date': DateFormat('yyyy-MM-dd').format(
        DateTime.parse(
          selectedDate.toString(),
        ),
      ),
      'pickup_time': timeCtr.text,
      'drop_date': DateFormat('yyyy-MM-dd').format(
        DateTime.parse(
          selectedEndDate.toString(),
        ),
      ),
      'drop_lat': widget.dropLat.toString(),
      'drop_long': widget.dropLng.toString(),
      'drop_time': timeEndCtr.text,
      'pickup_address': widget.pickAddress.toString(),
      'drop_address': widget.dropAddress.toString(),
      'duration': totalHours.toString(),
      'manual_type': isOn == false ? "Auto" : "Manual",
      // 'duration_time': '',
      'payment_type': _paymentMethod.toString(),
      "transaction_id": transactionId.toString(),
      'latitude': widget.pickupLat, //lat.toString(),
      'longitude': widget.pickupLong //long.toString(),
    };
    print("add booking parar $param");
    apiBaseHelper.postAPICall(bookindurl, param).then(
      (getDta) {
        bool error = getDta['status'];
        String msg = getDta['message'];
        if (error == true) {
          setState(() {
            customSnackbar(context, msg.toString());
            setState(() {
              isLoading = false;
            });
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyblookingScr(),
            ),
          );
        } else {
          customSnackbar(context, msg.toString());
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  List<VehcileData> vehcileList = [];
  Future<void> getVehicle() async {
    setState(() {
      isLoading = true;
    });
    var param = {
      'cab_id': widget.cabId.toString(),
    };
    print("cab id is $param");
    apiBaseHelper.postAPICall(getVehicleurl, param).then(
      (getDta) {
        bool error = getDta['status'];
        String msg = getDta['message'];
        if (error == true) {
          setState(() {
            vehcileList = VehicleModel.fromJson(getDta).data ?? [];

            selectVehicleId =
                vehcileList.isNotEmpty ? vehcileList.first.id : null;

            setState(() {
              isLoading = false;
            });
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  String? selectVehicleId;

  String? totalHours,
      nightHours,
      perHourCharge,
      nightChargePerHour,
      baseAmount,
      nightCharge,
      totalAmount;

  ChargeData? chargeList;
  Future<void> getCharges() async {
    setState(() {
      isLoading = true;
    });
    var param = {
      'from_date': DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(selectedDate.toString())),
      'from_time': timeCtr.text,
      'to_date': DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(selectedEndDate.toString())),
      'to_time': timeEndCtr.text,
      'car_model_id': selectVehicleId.toString(),
      'type': isOn == false ? "Auto" : "Manual",
    };

    print("cab charge $param");
    apiBaseHelper.postAPICall(getChargeurl, param).then(
      (getDta) {
        bool error = getDta['status'];
        String msg = getDta['message'];
        if (error == true) {
          setState(() {
            chargeList = GetChargeModel.fromJson(getDta).data;
            totalHours = getDta['data']['total_hours'].toString();
            nightHours = getDta['data']['night_hours'].toString();
            perHourCharge = getDta['data']['per_hour_charge'].toString();
            nightChargePerHour =
                getDta['data']['night_charge_per_hour'].toString();
            baseAmount = getDta['data']['base_amount'].toString();
            nightCharge = getDta['data']['night_charge'].toString();
            finalAmt = double.parse(getDta['data']['total_amount'].toString());
            print(
                "total $totalHours night $nightHours perhour $perHourCharge nightcharge $nightChargePerHour fsds $baseAmount sa $nightCharge aads $finalAmt");
            setState(() {
              isLoading = false;
            });
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  PromoData? selectedPromo;
  String? promoCode;

  List<PromoData> promoList = [];

  Future<void> getPromoList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    setState(() {
      isLoading = true;
    });
    var param = {'user_id': '7'};
    print("get promo $param");
    apiBaseHelper.postAPICall(getPromo, param).then(
      (getDta) {
        bool error = getDta['status'];
        String msg = getDta['message'];
        if (error == true) {
          setState(() {
            promoList = PromoCodeListModel.fromJson(getDta).data ?? [];
            setState(() {
              isLoading = false;
            });
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  String? discount;
  double? finalAmt;

  Future<void> applyCode(String? promoCode, amount) async {
    setState(() {
      isLoading = true;
    });
    var param = {
      'promo_code': promoCode.toString(),
      'final_total': amount.toString()
    };
    print("get promo $param");
    apiBaseHelper.postAPICall(applyPromoCode, param).then(
      (getDta) {
        bool error = getDta['status'];
        String msg = getDta['message'];
        if (error == true) {
          setState(() {
            promoList = PromoCodeListModel.fromJson(getDta).data ?? [];
            discount = getDta['discount'].toString();

            finalAmt = (chargeList?.totalAmount ?? 0) -
                (double.tryParse(discount.toString()) ?? 0.0);

            print("=======ddddddd========$finalAmt===========");
            isLoading = false;
          });

          Fluttertoast.showToast(msg: msg);
        } else {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  int selectedIndex = 0;
  String? dropLat, dropLong, dropLocation;
  bool isOn = false;
  String? lat;
  String? long;
  Position? currentLocation;
  String? currentAddres;

  List<LatLng> polylineCoordinates = [];

  LatLng destination = const LatLng(22.719568, 75.857727);
  bool showCarTypeContainer = true;

  Future<void> getUserCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    lat = position.latitude.toString();
    long = position.longitude.toString();

    List<Placemark> placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
      localeIdentifier: "en",
    );

    if (mounted) {
      setState(() {
        currentAddres =
            "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}";
        lat = position.latitude.toString();
        long = position.longitude.toString();

        print('Latitude============= $lat');
        print('Longitude************* $long');
      });
    }

    // Move map camera to current location
    final GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        ),
      ),
    );
  }

  bool isManual = true;
  DateTime? selectedDate;
  DateTime? selectedEndDate;
  TimeOfDay? selectedTime;
  TimeOfDay? selectedEndTime;
  Duration? selectedDuration;

  Future<void> pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      if (selectedEndDate != null && date.isAfter(selectedEndDate!)) {
        Fluttertoast.showToast(msg: 'Start date should be less then end date');
      } else {
        setState(() {
          selectedDate = date;
        });
      }
    }
  }

  Future<void> pickEndDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      if (selectedDate != null && date.isBefore(selectedDate!)) {
        ;
        Fluttertoast.showToast(
            msg: 'End date should be grater then start date');
      } else {
        setState(() {
          selectedEndDate = date;
        });
      }
    }
  }

  //
  // Future<TimeOfDay?> pickTime(
  //     BuildContext context, TimeOfDay? initialTime) async {
  //   TimeOfDay? time = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //   if (time != null) {
  //     setState(() {
  //       selectedTime = time;
  //       print("time $selectedTime");
  //     });
  //   }
  //   getCharges();
  // }

  Future<TimeOfDay?> pickTime(
      BuildContext context, TimeOfDay? initialTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
    return picked;
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm();
    return format.format(dt);
  }

  Future<void> pickDuration() async {
    Duration? duration = await showDialog<Duration>(
      context: context,
      builder: (context) {
        Duration tempDuration = const Duration(hours: 1);
        return AlertDialog(
          title: const Text("Select Duration"),
          content: DropdownButton<int>(
            value: tempDuration.inHours,
            items: List.generate(12, (index) => index + 1)
                .map((hour) => DropdownMenuItem(
                      value: hour,
                      child: Text("$hour hours"),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                tempDuration = Duration(hours: value);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
    if (duration != null) {
      setState(() {
        selectedDuration = duration;
      });
    }
  }

  int currentContainer = 0;

  Widget _buildCarTypeContainer() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.directions_car, color: Colors.black, size: 25),
              SizedBox(width: 8),
              Text(
                "CAR TYPE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          vehcileList.isEmpty
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 50),
                  child: Text(
                    "No Data Available",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ))
              : Expanded(
                  child: ListView.builder(
                    itemCount: vehcileList.length,
                    itemBuilder: (context, index) {
                      final option = vehcileList[index];
                      final isSelected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            selectVehicleId = vehcileList[index].id.toString();
                            print("dfjfsfh $selectVehicleId");
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: isSelected
                                ? Colors.blue[50]
                                : Colors.transparent,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Image.network(
                                "${option.carImage}",
                                height: 40,
                                width: 50,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                option.carModel.toString(),
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color:
                                      isSelected ? Colors.blue : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
          const SizedBox(height: 15),
          Container(
            height: 40,
            width: 130,
            child: ToggleSwitch(
              activeBgColor: const [AppColors.primary],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey[300],
              inactiveFgColor: Colors.black,
              initialLabelIndex: isOn ? 1 : 0,
              totalSwitches: 2,
              labels: const ['Auto', 'Manual'],
              fontSize: 12,
              onToggle: (index) {
                setState(() {
                  isOn = index == 1;
                });
              },
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () {
              setState(() {
                currentContainer = 1;
              });
            },
            child: Center(
              child: Container(
                width: 320,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary,
                ),
                child: const Center(
                  child: Text(
                    'Schedule',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController timeCtr = TextEditingController();
  TextEditingController timeEndCtr = TextEditingController();

  Widget _buildScheduleContainer() {
    return Container(
      height: 220,
      // padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.black),
              SizedBox(width: 8),
              Text(
                "Schedule",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black,
          ),
          Row(
            children: [
              const Icon(Icons.calendar_month_outlined),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {
                  pickDate();
                },
                child: Text(
                  selectedDate != null
                      ? "${selectedDate!.toLocal()}".split(' ')[0]
                      : "Start Date",
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Icon(Icons.calendar_month_outlined),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {
                  pickEndDate();
                },
                child: Text(
                  selectedEndDate != null
                      ? "${selectedEndDate!.toLocal()}".split(' ')[0]
                      : "End Date",
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Icon(Icons.timer),
              const SizedBox(width: 5),
              InkWell(
                onTap: () async {
                  TimeOfDay? pickedtime = await pickTime(context, selectedTime);
                  if (pickedtime != null) {
                    if (selectedEndTime != null && selectedDate != null) {
                      final startDateTime = DateTime(
                        selectedDate!.year,
                        selectedDate!.month,
                        selectedDate!.day,
                        pickedtime.hour,
                        pickedtime.minute,
                      );
                      final endDateTime = DateTime(
                        selectedEndDate!.year,
                        selectedEndDate!.month,
                        selectedEndDate!.day,
                        selectedEndTime!.hour,
                        selectedEndTime!.minute,
                      );
                      print('${startDateTime}__________dfsdfs');

                      if (startDateTime.isAfter(endDateTime)) {
                        Fluttertoast.showToast(
                            msg: 'Start time should be less then End Time');
                      } else {
                        setState(() {
                          selectedEndTime = pickedtime;
                          timeEndCtr.text =
                              pickedtime.format(context).toString();
                          getCharges();
                        });
                      }
                    } else if (selectedDate == null) {
                      Fluttertoast.showToast(msg: 'select start date first');
                    } else {
                      setState(() {
                        selectedTime = pickedtime;
                        timeCtr.text = pickedtime.format(context).toString();
                      });
                    }
                  }
                },
                child: Text(
                    selectedTime != null
                        ? "${selectedTime?.format(context)}"
                        : (timeCtr.text != ''
                            ? DateFormat("hh:mm a").format(
                                DateFormat("HH:mm:ss").parse(timeCtr.text))
                            : 'Start Time'),
                    style: const TextStyle(fontSize: 16)),
              ),
              const SizedBox(
                width: 25,
              ),
              const Icon(Icons.timer),
              const SizedBox(width: 5),
              InkWell(
                onTap: () async {
                  if (/*selectedTime == null*/ false) {
                    Fluttertoast.showToast(
                        msg: 'Please select start time first');
                  } else {
                    TimeOfDay? pickedtime =
                        await pickTime(context, selectedEndTime);
                    print('${pickedtime.toString()}____________erwer');
                    if (pickedtime != null) {
                      if (selectedTime != null && selectedEndDate != null) {
                        final startDateTime = DateTime(
                          selectedDate!.year,
                          selectedDate!.month,
                          selectedDate!.day,
                          selectedTime!.hour,
                          selectedTime!.minute,
                        );
                        final endDateTime = DateTime(
                          selectedEndDate!.year,
                          selectedEndDate!.month,
                          selectedEndDate!.day,
                          pickedtime.hour,
                          pickedtime.minute,
                        );

                        if (endDateTime.isBefore(startDateTime)) {
                          Fluttertoast.showToast(
                              msg: 'End time should be grater then Start Time');
                        } else {
                          setState(() {
                            selectedEndTime = pickedtime;
                            timeEndCtr.text =
                                pickedtime.format(context).toString();
                            getCharges();
                          });
                        }
                      } else if (selectedEndDate == null) {
                        Fluttertoast.showToast(msg: 'select end date first');
                      } else if (selectedTime == null) {
                        Fluttertoast.showToast(msg: 'select start date first');
                      } else {
                        setState(() {
                          selectedEndTime = pickedtime;
                          timeEndCtr.text =
                              pickedtime.format(context).toString();
                          getCharges();
                        });
                      }
                    }
                  }
                },
                child: Text(
                    selectedEndTime != null
                        ? "${selectedEndTime?.format(context)}"
                        : (timeEndCtr.text != ''
                            ? DateFormat("hh:mm a").format(
                                DateFormat("HH:mm:ss").parse(timeEndCtr.text))
                            : 'End Time'),
                    style: const TextStyle(fontSize: 16)),
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Icon(Icons.timelapse),
              const SizedBox(width: 5),
              InkWell(
                onTap: () {
                  // pickDuration();
                },
                child: Text(
                  "${totalHours ?? Duration} Hr.",
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              if (selectedDate == null ||
                  selectedEndDate == null ||
                  timeCtr.text.isEmpty ||
                  timeEndCtr.text.isEmpty) {
                Fluttertoast.showToast(msg: "Please Pick Date and Time First");
                return; // Prevents proceeding further
              }
              setState(() {
                currentContainer = 2;
              });
            },
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary,
              ),
              child: const Center(
                child: Text(
                  'Get Estimate',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _paymentMethod = 'Cash';

  Widget _buildConfirmContainer() {
    return Container(
      height: 400,
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Cab Image and Name
            Row(
              children: [
                Image.network(
                  chargeList?.cars?.carImagePath ?? '',
                  height: 50,
                  width: 50,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.car_rental),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '${chargeList?.cars?.carModel ?? ''} - ${chargeList?.type ?? ''}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoRow('From Date/Time:',
                '${chargeList?.fromDate ?? ''} ${chargeList?.fromTime ?? ''}'),
            const SizedBox(height: 10),
            _buildInfoRow('To Date/Time:',
                '${chargeList?.toDate ?? ''} ${chargeList?.toTime ?? ''}'),

            const SizedBox(height: 10),

            // Promocode Section
            // Promocode Section
            // Promocode Section
            promoList.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Have Promocode:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: DropdownButtonFormField<PromoData>(
                              value: selectedPromo,
                              isExpanded: true,
                              hint: const Text("Select PromoCode"),
                              items: promoList.map((promo) {
                                return DropdownMenuItem<PromoData>(
                                  value: promo,
                                  child: Text(
                                      "${promo.promocode ?? ''} (${promo.type ?? ''})"),
                                );
                              }).toList(),
                              onChanged: (PromoData? newValue) {
                                setState(() {
                                  selectedPromo = newValue;

                                  promoCode =
                                      selectedPromo?.promocode.toString();
                                  print("asdadasd ${promoCode}");
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: selectedPromo != null
                                  ? () {
                                      applyCode(selectedPromo?.promocode,
                                          selectedPromo?.amount);
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                              ),
                              child: const Text(
                                "Apply",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox.shrink(),

            const Divider(),

            // Charges Section
            buildChargeRow(
                'Total Hours', '${chargeList?.totalHours ?? ''} Hrs.'),
            buildChargeRow('Base Charge', '₹ ${chargeList?.baseAmount ?? ''}'),
            buildChargeRow(
                'Night Charge', '₹ ${chargeList?.nightCharge ?? ''}'),
            if (discount != null && discount.toString().isNotEmpty)
              buildChargeRow('PromoCode', '- ₹ ${discount.toString()}'),

            const Divider(),

            // Total Amount Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  '₹ ${finalAmt.toString()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Selected Payment Method:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Cash',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    leading: Radio<String>(
                      value: 'Cash',
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text(
                      'Razorpay',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    leading: Radio<String>(
                      value: 'Razorpay',
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value!;
                          print("dadasda $_paymentMethod");
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Confirm Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: () {
                if (_paymentMethod == "Cash") {
                  !isLoading ? confirmbooking() : const SizedBox();
                } else {
                  openCheckout(finalAmt.toString());
                }
                // Navigator.pop(context);
              },
              child: CustomButton(
                textt: !isLoading ? "Confirm" : "Please Wait ...",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildChargeRow(String title, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(amount),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.4,
            width: MediaQuery.of(context).size.width,
            child: lat == null
                ? Center(child: LoadingWidget2(context))
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(lat!), double.parse(long!)),
                      zoom: 13.5,
                    ),
                    markers: {
                      Marker(
                        visible: true,
                        draggable: true,
                        icon: BitmapDescriptor.defaultMarkerWithHue(90),
                        markerId: const MarkerId("currentLocation"),
                        position: LatLng(
                          double.parse(lat!),
                          double.parse(long!),
                        ),
                      ),
                      Marker(
                        markerId: const MarkerId("destination"),
                        position: destination,
                      ),
                    },
                    polylines: {
                      Polyline(
                        visible: true,
                        jointType: JointType.mitered,
                        polylineId: const PolylineId("route"),
                        points: polylineCoordinates,
                        color: Colors.blue,
                        width: 6,
                      ),
                    },
                    onMapCreated: (mapController) {
                      _controller.complete(mapController);
                    },
                  ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (currentContainer == 0)
                      ? _buildCarTypeContainer()
                      : (currentContainer == 1)
                          ? _buildScheduleContainer()
                          : _buildConfirmContainer()

                  // Container(
                  //   height: 300,
                  //   // padding: const EdgeInsets.all(5),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Icon(Icons.directions_car, color: Colors.blue),
                  //               SizedBox(width: 8),
                  //               Text(
                  //                 "CAR TYPE",
                  //                 style: TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.blue,
                  //                   fontSize: 16,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //       Expanded(
                  //         child: ListView.builder(
                  //           itemCount: vehcileList.length,
                  //           itemBuilder: (context, index) {
                  //             final option = vehcileList[index];
                  //             final isSelected = selectedIndex == index;
                  //             return GestureDetector(
                  //               onTap: () {
                  //                 setState(() {
                  //                   selectedIndex = index;
                  //                 });
                  //               },
                  //               child: Container(
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(15),
                  //                   color: isSelected
                  //                       ? Colors.blue[50]
                  //                       : Colors.transparent,
                  //                 ),
                  //                 padding:
                  //                     const EdgeInsets.symmetric(vertical: 10),
                  //                 child: Row(
                  //                   children: [
                  //                     Image.network(
                  //                       "${option.carImage}",
                  //                       height: 30,
                  //                       width: 50,
                  //                       fit: BoxFit.contain,
                  //                     ),
                  //                     const SizedBox(width: 16),
                  //                     Text(
                  //                       option.carModel.toString(),
                  //                       style: TextStyle(
                  //                         fontSize: 14,
                  //                         fontWeight: isSelected
                  //                             ? FontWeight.bold
                  //                             : FontWeight.normal,
                  //                         color: isSelected
                  //                             ? Colors.blue
                  //                             : Colors.black,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       ),
                  //
                  //       const SizedBox(height: 10),
                  //
                  //       // Manual/Auto Toggle
                  //       GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             isManual = !isManual;
                  //           });
                  //         },
                  //         child: Row(
                  //           children: [
                  //             Icon(Icons.settings, color: Colors.blue),
                  //             const SizedBox(width: 8),
                  //             Text(
                  //               isManual ? "Manual" : "Auto",
                  //               style: const TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 14,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
