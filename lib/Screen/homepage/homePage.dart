import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:place_picker/entities/location_result.dart';
// import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiConstants.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/loadingwidget.dart';
import '../../Model/CabTypeModel.dart';
import '../../Vehicl/SelectVehicle.dart';
import '../Mybooking/mybookingScreen.dart';
import '../auth/loginScreen.dart';
import '../faq/faqScreen.dart';
import '../notification/notification.dart';
import '../privecy/privecy.dart';
import '../profile/updateProfile.dart';
import '../support/customerSupport.dart';
import '../termcondition/termCondition.dart';
import '../tranjection/PaymentTransaction.dart';

class HomeScr extends StatefulWidget {
  const HomeScr({Key? key}) : super(key: key);

  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  int selectedIndex = 0;

  final List<RideOption> rideOptions = [
    RideOption('InCity Round', Icons.directions_car),
    RideOption('InCity One-Way', Icons.directions_car_outlined),
    RideOption('Multi Outstation', Icons.local_taxi),
    RideOption('Outstation', Icons.airport_shuttle),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                name ?? "$mobile",
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              accountEmail: Text(
                email ?? '',
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                  imagepath.toString() ?? "",
                ),
              ),
              decoration: const BoxDecoration(color: AppColors.primary),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdateProfile(),
                  ),
                );
              },
              child: tabProfile(context, "Setting"),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScr(),
                  ),
                );
              },
              child: tabProfile(context, "Notifications"),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentTransaction(),
                  ),
                );
              },
              child: tabProfile(context, "Payment"),
            ),
            // InkWell(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) =>
            //                 Tranjection(walletBalance: walletAmount),
            //           ));
            //     },
            //     child: tabProfile(context, "Wallet")),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyblookingScr(),
                      ));
                },
                child: tabProfile(context, "My Booking")),
            // InkWell(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => const ChangePasswordinHome(),
            //           ));
            //     },
            //     child: tabProfile(context, "Change Password")),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivecyScr(),
                      ));
                },
                child: tabProfile(context, 'Privacy Policy')),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsConditionScrr(),
                      ));
                },
                child: tabProfile(context, 'Term & Conditions')),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FaqsScrr(),
                  ),
                );
              },
              child: tabProfile(context, 'FAQs'),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SupportScr(),
                  ),
                );
              },
              child: tabProfile(context, 'Customer Support'),
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Logout"),
                        content: const Text("Are you sure to Logout?"),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.primary),
                            child: const Text(
                              "YES",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              setState(() {
                                sessionremove();
                              });
                              Navigator.pop(context);
                              // SystemNavigator.pop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.primary),
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
                    });
              },
              child: tabProfile(context, "Logout"),
            ),
            // InkWell(
            //   onTap: () {
            //     showDialog(
            //         context: context,
            //         barrierDismissible: false,
            //         builder: (BuildContext context) {
            //           return AlertDialog(
            //             title: const Text("Confirm Delete"),
            //             content:
            //                 const Text("Are you sure to Delete This Account?"),
            //             actions: <Widget>[
            //               ElevatedButton(
            //                 style: ElevatedButton.styleFrom(
            //                     primary: AppColors.primary),
            //                 child: const Text(
            //                   "YES",
            //                   style: TextStyle(color: Colors.white),
            //                 ),
            //                 onPressed: () async {
            //                   setState(() {
            //                     deleteAccount();
            //                   });
            //                   Navigator.pop(context);
            //                   // SystemNavigator.pop();
            //                   Navigator.pushReplacement(
            //                     context,
            //                     MaterialPageRoute(
            //                       builder: (context) => const LoginPage(),
            //                     ),
            //                   );
            //                 },
            //               ),
            //               ElevatedButton(
            //                 style: ElevatedButton.styleFrom(
            //                     primary: AppColors.primary),
            //                 child: const Text(
            //                   "NO",
            //                   style: TextStyle(color: Colors.white),
            //                 ),
            //                 onPressed: () {
            //                   Navigator.of(context).pop();
            //                 },
            //               ),
            //             ],
            //           );
            //         });
            //   },
            //   child: tabProfile(context, "Delete Account"),
            // ),
          ],
        ),
      ),
      // PreferredSize(
      //   preferredSize: const Size.fromHeight(80),
      //   child: Container(
      //     height: 50,
      //     width: MediaQuery.of(context).size.width,
      //     decoration: const BoxDecoration(
      //       gradient: LinearGradient(
      //         colors: [AppColors.primary, AppColors.primary],
      //       ),
      //     ),
      //     child: const Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Padding(
      //             padding: EdgeInsets.only(left: 10),
      //             child: Icon(
      //               Icons.menu,
      //               color: Colors.white,
      //             ),
      //           ),
      //           Text(
      //             "Home",
      //             style: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 18,
      //                 color: AppColors.whiteTemp),
      //           ),
      //           SizedBox(
      //             width: 20,
      //           ),
      //         ]),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  child: lat == null
                      ? Center(child: LoadingWidget2(context))
                      : GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              double.parse(lat ?? ""),
                              double.parse(long ?? ""),
                            ),
                            zoom: 13.5,
                          ),
                          markers: {
                            Marker(
                              visible: true,
                              draggable: true,
                              icon: BitmapDescriptor.defaultMarkerWithHue(90),
                              markerId: const MarkerId("currentLocation"),
                              position: LatLng(
                                double.parse(lat ?? ""),
                                double.parse(long ?? ""),
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
                Positioned(
                  top: 10,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "From......",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 300,
                              child: Text(
                                maxLines: 2,
                                currentAddres ?? "Fetching address...",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Where......",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlacePicker(
                                  apiKey: Platform.isAndroid
                                      ? "AIzaSyBWG0ZCi63QT7H6rDeP7FUTxP12GHhwrZM"
                                      : "AIzaSyBWG0ZCi63QT7H6rDeP7FUTxP12GHhwrZM",
                                  onPlacePicked: (result) {
                                    print(result.formattedAddress);
                                    setState(() {
                                      dropLocation =
                                          result.formattedAddress.toString();
                                      dropLat = result.geometry!.location.lat
                                          .toString();
                                      dropLong = result.geometry!.location.lng
                                          .toString();
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  initialPosition:
                                      const LatLng(22.719568, 75.857727),
                                  useCurrentLocation: true,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 300,
                                child: Text(
                                  dropLocation != null
                                      ? "$dropLocation"
                                      : "Drop Location",
                                  maxLines: 2,
                                  style: dropLocation != null
                                      ? const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)
                                      : const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 20,
              runSpacing: 20,
              children: List.generate(cabList.length, (index) {
                final option = cabList[index];
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      cabId = cabList[index].id.toString();
                      print("is cab $cabId");
                    });
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            isSelected ? Colors.green : Colors.grey[300],
                        child: Image.network(
                          "${option.image}",
                          height: 50,
                          width: 50,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        option.type.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: isSelected ? Colors.green : Colors.black,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: TextFormField(
            //     // readOnly: true,
            //     // onTap: () {
            //     //   showPlacePicker("pl");
            //     // },
            //     controller: pickupLocationcontroller,
            //     decoration: InputDecoration(
            //       prefixIcon: const Icon(
            //         Icons.location_on,
            //         color: AppColors.tabtextColor,
            //       ),
            //       hintText: 'Pickup Location',
            //       labelText: 'Pickup Location',
            //       hintStyle: const TextStyle(fontSize: 13),
            //       contentPadding: const EdgeInsets.symmetric(vertical: 5),
            //       focusedErrorBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(8),
            //           borderSide:
            //               const BorderSide(color: AppColors.primary, width: 2)),
            //       enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(8),
            //           borderSide:
            //               const BorderSide(color: AppColors.primary, width: 2)),
            //       errorBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(8),
            //           borderSide:
            //               const BorderSide(color: AppColors.primary, width: 2)),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: const BorderSide(color: AppColors.primary),
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     validator: (value) {
            //       if (value!.isEmpty) {
            //         return 'Please Enter Pickup Location';
            //       }
            //       return null; // Return null if the input is valid
            //     },
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: TextFormField(
            //     // readOnly: true,
            //     // onTap: () {
            //     //   showPlacePicker("dl");
            //     // },
            //     controller: droplocationcontroller,
            //     decoration: InputDecoration(
            //       prefixIcon: const Icon(
            //         Icons.location_on,
            //         color: AppColors.tabtextColor,
            //       ),
            //       hintText: 'Drop Location',
            //       labelText: "Drop Location`",
            //       hintStyle: const TextStyle(fontSize: 13),
            //       contentPadding: const EdgeInsets.symmetric(vertical: 5),
            //       focusedErrorBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(8),
            //           borderSide:
            //               const BorderSide(color: AppColors.primary, width: 2)),
            //       enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(8),
            //           borderSide:
            //               const BorderSide(color: AppColors.primary, width: 2)),
            //       errorBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(8),
            //           borderSide:
            //               const BorderSide(color: AppColors.primary, width: 2)),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: const BorderSide(color: AppColors.primary),
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //     validator: (value) {
            //       if (value!.isEmpty) {
            //         return 'Please Enter Drop Location';
            //       }
            //       return null; // Return null if the input is valid
            //     },
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            InkWell(
              onTap: () {
                if (dropLocation == null || dropLocation!.isEmpty) {
                  Fluttertoast.showToast(msg: "Please enter drop location");
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectVehicle(
                      cabId: cabId.toString(),
                      dropAddress: dropLocation!,
                      pickAddress: currentAddres ?? '',
                      dropLat: dropLat?.toString() ?? '',
                      dropLng: dropLong?.toString() ?? '',
                    ),
                  ),
                );
              },
              child: Container(
                width: 320,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primary,
                ),
                child: const Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
// Scaffold(
//
//
//   floatingActionButton:
//   FloatingActionButton(
//
//     backgroundColor: AppColors.primary,    onPressed: () {
//
// Navigator.push(context, MaterialPageRoute(builder: (context) => bookingScr(),));
//   },
//   child: Icon(Icons.add),
//   ),
//   body:
//
//
//
// RefreshIndicator(
//   color: AppColors.primary,
//   onRefresh: () async{
//
//
//     getBooking();
//
//   },
//   child:
//   !isLoading?
//
//   ListView.builder(
//     itemCount: 1,
//     itemBuilder: (context, index) {
//       return
//
//
//
//
//
//         Stack(
//           children: [
//
//             customdwithoutBackScr(context,"Booking management"),
//
//             Container(
//               margin:
//               EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
//
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               decoration: const BoxDecoration(
//                 color: Color(0xffF6F6F6),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30), topRight: Radius.circular(30),),
//               ),
//
//               child: SingleChildScrollView(
//                 child: Column(children: [
//
//
//                   const SizedBox(
//                     height: 20,
//                   ),
//
//                   Row(
//                     children: [
//                       Text('Current bookings',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
//                     ],
//                   ),
//
//                   const SizedBox(
//                     height: 20,
//                   ),
//
//
//                   bookingList.isEmpty?Container(
//
//                     height: MediaQuery.of(context).size.height/1.6,
//                     width: MediaQuery.of(context).size.width,
//                     child: Center(child: Text('Booking Not Found',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
//                   ):
//
//
//                   Container(
//                     height: MediaQuery.of(context).size.height/1.6,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       physics: AlwaysScrollableScrollPhysics(),
//                       itemCount: bookingList.length??0,
//                       itemBuilder: (context, index) {
//                         return
//
//                           Card(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           child: Container(
//                             height: 300,
//                             child:
//
//
//                           Padding(
//                             padding: const EdgeInsets.all(15),
//                             child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//
//
//                               Text('Booking Confirmation',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: AppColors.primary),),
// Divider(),
//
//                               Row(
//                                 children: [
//
//                                   Text('Booking Id - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                   Spacer(),
//
//                                   Text('${bookingList[index].bookingId}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                 ],
//                               ),                              SizedBox(height: 5,),
//
//                               Row(
//                                 children: [
//                                   Text('Pickup - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                   Spacer(),
//
//                                   Text('${bookingList[index].cityName}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//
//                                 ],
//                               ),                              SizedBox(height: 5,),
//
//                               Row(
//                                 children: [
//                                   Text('Booking Type - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                   Spacer(),
//
//                                   Text('${bookingList[index].area}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                 ],
//                               ),
//                               SizedBox(height: 5,),
//
//                               Row(
//                                 children: [
//                                   Text('Vehicle Type - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                   Spacer(),
//
//                                   Text('${bookingList[index].carModel}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                 ],
//                               ),
//
//                               SizedBox(height: 5,),
//
//                               Row(
//                                 children: [
//                                   Text('Duration - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                   Spacer(),
//                                   Text('${bookingList[index].bookingTypes}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                 ],
//                               ),
//                               SizedBox(height: 5,),
//
//                               Row(
//                                 children: [
//                                   Text('Status - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                   Spacer(),
//
//                                   Text('${bookingList[index].status}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                 ],
//                               ),
//
//                                   SizedBox(height: 5,),
//                                   Row(
//                                     children: [
//                                       Text('How Many ${bookingList[index].bookingTypes} - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                       Spacer(),
//
//                                       Text('${bookingList[index].bookingTime}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                     ],
//                                   ),
//                               SizedBox(height: 5,),
//
//                                   Row(
//                                     children: [
//                                       Text('Total Amount - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                       Spacer(),
//
//                                       Text('RS ${bookingList[index].amount}/-',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
//                                     ],
//                                   ),
//
//                             ]),
//                           )
//                             ,),
//
//                         );
//
//
//                       },),
//                   )
//                 ],
//                 ),
//               ),
//             ),
//
//
//           ],
//
//         );
//
//
//     },):
//
//
//
//     Container(
//
//     height: MediaQuery.of(context).size.height,
//   width: MediaQuery.of(context).size.width,
//   child: Center(child: LoadingWidget2(context),),
// ),
//
// ),
//
//
// );
  }

  String? cabId;

  Widget tabProfile(BuildContext context, String tabName) {
    return Container(
      height: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        const SizedBox(
          width: 15,
        ),
        Text(
          tabName,
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.tabtextColor,
              fontSize: 15),
        ),
        Spacer(),
        const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.blackTemp,
          size: 16,
        ),
        const SizedBox(
          width: 5,
        ),
      ]),
    );
  }

  TextEditingController pickupLocationcontroller = TextEditingController();
  TextEditingController droplocationcontroller = TextEditingController();

  Future<void> sessionremove() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("userId");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCurrentLocation();
    getuserdata();
    getTripType();
  }

  String? name;
  String? email;
  String? mobile;
  String? walletAmount;
  String? imagepath;
  bool isloading = false;

  getuserdata() async {
    setState(() {
      isloading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');

    var param = {
      'user_id': userId.toString(),
    };
    print("herer data ${param}");
    apiBaseHelper.postAPICall(getprofileurl, param).then(
      (getDta) {
        bool error = getDta['status'];
        String msg = getDta['message'];
        if (error == true) {
          setState(() {
            name = getDta['data']['username'] ?? mobile;
            email = getDta['data']['email'] ?? mobile;
            mobile = getDta['data']['mobile'] ?? mobile;
            imagepath = getDta['data']['image_path'] ?? "";
            walletAmount = getDta['data']['wallet_amount'] ?? "";

            setState(() {
              isloading = false;
            });
          });
        } else {
          setState(() {
            isloading = false;
          });
        }
      },
    );
  }

  List<CabData> cabList = [];

  getTripType() async {
    setState(() {
      isloading = true;
    });
    apiBaseHelper.getAPICall(getCabTypeurl).then(
      (getDta) {
        bool error = getDta['status'];
        if (error == true) {
          setState(() {
            cabList = CabTypeModel.fromJson(getDta).needHelp ?? [];
            setState(() {
              isloading = false;
            });
          });
        } else {
          setState(() {
            isloading = false;
          });
        }
      },
    );
  }

  deleteAccount() async {
    setState(() {
      isloading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    var param = {
      'user_id': userId.toString(),
    };
    apiBaseHelper.postAPICall(deleteAccounturl, param).then(
      (getDta) {
        bool error = getDta['status'];
        String msg = getDta['message'];
        if (error == true) {
          setState(() {
            isloading = false;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
          sessionremove();
        } else {
          setState(() {
            isloading = false;
          });
        }
      },
    );
  }

  bool isLoading = false;

  String? dropLat, dropLong, dropLocation;

  Position? currentLocation;
  String? currentAddres;
  //
  // Future getUserCurrentLocation() async {
  //   var status = await Permission.location.request();
  //   if (status.isDenied) {
  //   } else if (status.isGranted) {
  //     await Geolocator.getCurrentPosition(
  //             desiredAccuracy: LocationAccuracy.high)
  //         .then((position) {
  //       if (mounted)
  //         setState(() {
  //           currentLocation = position;
  //           lat = currentLocation?.latitude.toString();
  //           long = currentLocation?.longitude.toString();
  //           currentAddres = currentLocation?.accuracy.toString();
  //           destination =
  //               LatLng(double.parse(lat ?? ""), double.parse(long ?? ""));
  //         });
  //     });
  //     print("LOCATION===" + currentLocation.toString());
  //     //updateDriverLocation();
  //   } else if (status.isPermanentlyDenied) {
  //     openAppSettings();
  //   }
  // }

  Future<void> getUserCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print("checking permission here $permission");
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude.toString();
    long = position.longitude.toString();

    List<Placemark> placemark = await placemarkFromCoordinates(
        double.parse(lat!), double.parse(long!),
        localeIdentifier: "en");
    if (mounted) {
      setState(() {
        currentAddres =
            "${placemark[0].street}, ${placemark[0].subLocality}, ${placemark[0].locality}";
        lat = position.latitude.toString();
        long = position.longitude.toString();
        destination = LatLng(double.parse(lat ?? ""), double.parse(long ?? ""));
        print('Latitude============= $lat');
        print('Longitude************* $long');
        print('Current Addresssssss $currentAddres');
      });
    }
  }

  final Completer<GoogleMapController> _controller = Completer();
  List<LatLng> polylineCoordinates = [];
  static LatLng destination =
      LatLng(double.parse("22.719568"), double.parse("75.857727"));

  // void showPlacePicker(String val) async {
  //   LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) =>
  //           PlacePicker("AIzaSyBWG0ZCi63QT7H6rDeP7FUTxP12GHhwrZM")));
  //
  //   // Check if the user picked a place
  //   if (result != null) {
  //     if (val == "pl") {
  //       setState(() {
  //         pickupLocationcontroller.text = '${result.formattedAddress}';
  //         print(pickupLocationcontroller.text);
  //       });
  //     } else {
  //       setState(() {
  //         droplocationcontroller.text = '${result.formattedAddress}';
  //         print(droplocationcontroller.text);
  //
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => bookingScr(
  //                   pickupLocation: pickupLocationcontroller.text.toString(),
  //                   droplocation: droplocationcontroller.text.toString()),
  //             ));
  //       });
  //     }
  //   }
  // }
}

class RideOption {
  final String title;
  final IconData icon;

  RideOption(this.title, this.icon);
}
