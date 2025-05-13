import 'dart:async';
import 'dart:convert';

import 'package:eco_rider_user/Screen/homepage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/Constants.dart';
import '../../Helper/Widget.dart';
import '../../Helper/loadingwidget.dart';
import '../../Model/ReasonModel.dart';
import '../../Model/allBookingModel.dart';
import '../../Widget/widgets.dart';

class BookingDetails extends StatefulWidget {
  BookingDataModel? model;

  BookingDetails({Key? key, this.model}) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setMarker();
    getUserCurrentLocation();
    fetchCancelReasons();
    getReason();
  }

  String? lat;
  String? long;
  Position? currentLocation;
  String? currentAddres;
  BitmapDescriptor? sourceIcon;

  List<LatLng> polylineCoordinates = [];

  LatLng destination = LatLng(22.719568, 75.857727);
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
        print('Current Addresssssss $currentAddres');
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

  final Completer<GoogleMapController> _controller = Completer();

  Future<void> cancellBooking() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    var param = {
      'booking_id': widget.model?.uneaqueId.toString(),
      'reason': selectedReason.toString()
    };

    apiBaseHelper.postAPICall(cancelBooking, param).then(
      (getDta) {
        bool error = getDta['status'];
        String msg = getDta['message'];
        if (error == true) {
          setState(() {
            setState(() {
              isLoading = false;
            });
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScr()));
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  Future<List<ReasonModel>> fetchCancelReasons() async {
    final response = await http.post(
      Uri.parse(
          'https://developmentalphawizz.com/eco_rider/api/payment/cancel_ride_reason'),
      body: {
        'type': 'user',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status']) {
        List reasons = data['data'];
        return reasons.map((e) => ReasonModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load reasons');
      }
    } else {
      throw Exception('Failed to connect to server');
    }
  }

  int indexReason = 0;
  // List<ReasonModel> reasons = [];

  PersistentBottomSheetController? persistentBottomSheetController1;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedReason;
  void showCancelReasonDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Cancel Reason'),
          content: reasonList.isEmpty
              ? const CircularProgressIndicator()
              : DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: "Reason",
                    border: OutlineInputBorder(),
                  ),
                  items: reasonList.map((ReasonModel reason) {
                    return DropdownMenuItem<String>(
                      value: reason.reason,
                      child: Text(reason.reason.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedReason = value;
                    print("sdakdakdaddajsd $selectedReason");
                  },
                ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColors.primary),
              child: const Text("YES", style: TextStyle(color: Colors.white)),
              onPressed: () {
                if (selectedReason != null) {
                  print('Selected reason: $selectedReason');
                  cancellBooking();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a reason')));
                }
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppColors.primary),
              child: const Text(
                "NO",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  TextEditingController reasonCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: const Text(
          "Booking Details",
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Container(
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
                        icon: sourceIcon ??
                            BitmapDescriptor.defaultMarkerWithHue(90),
                        markerId: const MarkerId("driverLocation"),
                        position: LatLng(
                          double.parse(widget.model?.driverLat ?? '0'),
                          double.parse(widget.model?.driverLong ?? '0'),
                        ),
                      ),
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
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Booking ID: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${widget.model?.uneaqueId}',
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          widget.model?.status == "complete"
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () {
                                    showCancelReasonDialog(context);
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 110,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red),
                                    child: const Center(
                                      child: Text(
                                        "Cancel Reason",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(widget.model?.status),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              _getStatusText(widget.model?.status,
                                  widget.model?.acceptReject ?? '0'),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 18),
                          const SizedBox(width: 8),
                          Text(
                              '${widget.model?.pickupDate} at ${widget.model?.pickupTime}'),
                          const Spacer(),
                          Text('Estimated Fare ₹ ${widget.model?.amount}'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.timer, size: 18),
                          const SizedBox(width: 8),
                          Text('${widget.model?.duration} (s)'),
                          const Spacer(),
                          Text('${widget.model?.paymentMedia}'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text('Night Charge'),
                              const Spacer(),
                              Text('₹ ${widget.model?.nightCharge}'),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text('Night Charge Per Hrs'),
                              const Spacer(),
                              Text('${widget.model?.nightChargePerHour} Hrs.'),
                            ],
                          ),
                          const SizedBox(height: 5),
                          widget.model?.promoDiscount == null ||
                                  widget.model?.promoDiscount == "" ||
                                  widget.model?.promoDiscount == "0"
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    const Text('Promo Discount'),
                                    const Spacer(),
                                    Text('- ${widget.model?.promoDiscount}'),
                                  ],
                                ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Text(
                                'Total Amount',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              const Spacer(),
                              Text(
                                '₹ ${widget.model?.amount}',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${widget.model?.pickupAddress}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on, color: Colors.red),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '${widget.model?.dropAddress}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Divider(),
                      const SizedBox(height: 5),
                      widget.model?.driverName == null ||
                              widget.model?.driverNumber == ""
                          ? const SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Driver Details: ",
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width / 1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Container(
                                            decoration: boxDecoration(
                                                radius: 12, color: Colors.grey),
                                            child: Image.network(
                                              widget.model?.driverImage ?? '',
                                              height: 50,
                                              width: 50,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Container(
                                                  color: Colors.grey[
                                                      300], // Placeholder background color
                                                  child: Icon(
                                                    Icons
                                                        .person, // Avatar fallback icon
                                                    size: 36,
                                                    color: Colors.grey[600],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 0),
                                            child: Row(
                                              children: [
                                                Text(
                                                    "${widget.model?.driverName}"),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Text(
                                                    "${widget.model?.driverNumber}"),
                                              ),
                                            ],
                                          ),
                                          widget.model?.driverRating == null
                                              ? const SizedBox()
                                              : Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 6,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    color: AppColors.primary,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        widget.model!
                                                            .driverRating!,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      const Icon(
                                                        Icons.star,
                                                        color:
                                                            AppColors.whiteTemp,
                                                        size: 14,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          launch(
                                              "tel://${widget.model?.driverNumber}");
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          width: 70,
                                          height: 30,
                                          decoration: boxDecoration(
                                              radius: 5,
                                              bgColor: AppColors.primary),
                                          child: Center(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.call,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              text("Call",
                                                  fontFamily: fontMedium,
                                                  fontSize: 12,
                                                  isCentered: true,
                                                  textColor: Colors.white),
                                            ],
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.network(
                                "${widget.model?.carImage}",
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(height: 4),
                              Text('${widget.model?.carModel}'),
                            ],
                          ),
                          Column(
                            children: [
                              Image.network(
                                "${widget.model?.tripImage}",
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(height: 4),
                              Text('${widget.model?.tripType}'),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/images/manual.png",
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(height: 4),
                              Text('${widget.model?.manualType}'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Processing':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      case 'Accepted':
        return Colors.blue;
      case 'complete':
        return Colors.green;
      default:
        return Colors.grey; // fallback color
    }
  }

  String _getStatusText(String? status, String acceptReject) {
    if (status == 'Processing' && acceptReject == '1') {
      return 'Accepted';
    } else if (status == 'Processing' && acceptReject == '6') {
      return 'Processing';
    } else if (status == 'Processing') {
      return 'Pending';
    } else if (status == 'Cancelled') {
      return 'Cancelled';
    } else if (status == 'Accepted') {
      return 'Accepted';
    } else if (status == 'complete') {
      return 'Completed';
    } else {
      return 'Pending';
    }

    // print('i m here ${status}');
    // switch (status) {
    //   case 'Processing':
    //     return 'Pending'; // showing 'Pending' instead of 'Processing'
    //   case 'Cancelled':
    //     return 'Cancelled';
    //   case 'Accepted':
    //     return 'Accepted';
    //   case 'complete':
    //     return 'Completed';
    //   default:
    //     return 'Unknown'; // fallback text
    // }
  }

  bool isLoading = false;

  List<ReasonModel> reasonList = [];
  Future<void> getReason() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');

    var param = {
      'type': 'user',
    };

    apiBaseHelper.postAPICall(cancelReason, param).then(
      (getDta) {
        bool error = getDta['status'];
        String msg = getDta['message'];
        if (error == true) {
          setState(() {
            for (var v in getDta['data']) {
              reasonList.add(ReasonModel.fromJson(v));
            }
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

  setMarker() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/driving.png');

    destination = LatLng(
        double.parse(widget.model?.dropLatitude ?? '22.719568'),
        double.parse(widget.model?.dropLongitude ?? '75.857727'));
  }
}
