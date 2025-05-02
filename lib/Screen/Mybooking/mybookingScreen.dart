import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/loadingwidget.dart';
import '../../Model/allBookingModel.dart';
import '../auth/custumScreen.dart';
import '../homepage/homePage.dart';
import 'BookinDetails.dart';

class MyblookingScr extends StatefulWidget {
  const MyblookingScr({Key? key}) : super(key: key);

  @override
  State<MyblookingScr> createState() => _MyblookingScrState();
}

class _MyblookingScrState extends State<MyblookingScr> {
  // Widget _bookingDetails() {
  //   return Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Card(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   children: [
  //                     const Text(
  //                       'Booking ID ',
  //                       style: TextStyle(fontWeight: FontWeight.bold),
  //                     ),
  //                     const Text(
  //                       '0C7LGQ',
  //                       style: TextStyle(
  //                           color: Colors.green, fontWeight: FontWeight.bold),
  //                     ),
  //                     const Spacer(),
  //                     ElevatedButton(
  //                       onPressed: () {
  //                         showDialog(
  //                             context: context,
  //                             barrierDismissible: false,
  //                             builder: (BuildContext context) {
  //                               return AlertDialog(
  //                                 title: const Text("Confirm Logout"),
  //                                 content:
  //                                     const Text("Are you sure to Logout?"),
  //                                 actions: <Widget>[
  //                                   ElevatedButton(
  //                                     style: ElevatedButton.styleFrom(
  //                                         primary: AppColors.primary),
  //                                     child: const Text("YES"),
  //                                     onPressed: () async {
  //                                       // setState(() {
  //                                       //   sessionremove();
  //                                       // });
  //                                       // Navigator.pop(context);
  //                                       // // SystemNavigator.pop();
  //                                       // Navigator.pushReplacement(
  //                                       //     context,
  //                                       //     MaterialPageRoute(
  //                                       //       builder: (context) =>
  //                                       //       const LoginPage(),
  //                                       //     ));
  //                                     },
  //                                   ),
  //                                   ElevatedButton(
  //                                     style: ElevatedButton.styleFrom(
  //                                         primary: AppColors.primary),
  //                                     child: const Text("NO"),
  //                                     onPressed: () {
  //                                       Navigator.of(context).pop();
  //                                     },
  //                                   )
  //                                 ],
  //                               );
  //                             });
  //                       },
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: Colors.red,
  //                       ),
  //                       child: const Text('Cancel Booking'),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 12),
  //                 const Row(
  //                   children: [
  //                     Icon(Icons.calendar_today, size: 18),
  //                     SizedBox(width: 8),
  //                     Text('21/08/2024 at 4:40 AM'),
  //                     Spacer(),
  //                     Text('Estimated Fare ₹400.00'),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 8),
  //                 const Row(
  //                   children: [
  //                     Icon(Icons.timer, size: 18),
  //                     SizedBox(width: 8),
  //                     Text('2 hr(s)'),
  //                     Spacer(),
  //                     Icon(Icons.attach_money, size: 18),
  //                     SizedBox(width: 4),
  //                     Text('Cash'),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Row(
  //                   children: [
  //                     Container(
  //                       padding: const EdgeInsets.symmetric(
  //                           horizontal: 8, vertical: 4),
  //                       decoration: BoxDecoration(
  //                         color: Colors.orange,
  //                         borderRadius: BorderRadius.circular(12),
  //                       ),
  //                       child: const Text(
  //                         'Pending',
  //                         style: TextStyle(color: Colors.white),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 16),
  //                 const Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Icon(Icons.location_on, color: Colors.green),
  //                     SizedBox(width: 8),
  //                     Expanded(
  //                       child: Text(
  //                         '123, Park St, Mullick Bazar, Beniapukur, Kolkata, West Bengal 700017, India',
  //                         style: TextStyle(fontSize: 14),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 8),
  //                 const Row(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Icon(Icons.location_on, color: Colors.red),
  //                     SizedBox(width: 8),
  //                     Expanded(
  //                       child: Text(
  //                         '123, Park St, Mullick Bazar, Beniapukur, Kolkata, West Bengal 700017, India',
  //                         style: TextStyle(fontSize: 14),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 16),
  //                 const Divider(),
  //                 const SizedBox(height: 8),
  //                 const Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: [
  //                     Column(
  //                       children: [
  //                         Icon(Icons.directions_car, size: 40),
  //                         SizedBox(height: 4),
  //                         Text('Hatchback'),
  //                       ],
  //                     ),
  //                     Column(
  //                       children: [
  //                         Icon(Icons.map, size: 40),
  //                         SizedBox(height: 4),
  //                         Text('In-City (Round trip)'),
  //                       ],
  //                     ),
  //                     Column(
  //                       children: [
  //                         Icon(Icons.settings_rounded, size: 40),
  //                         SizedBox(height: 4),
  //                         Text('Manual'),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           )));
  // }

  double rating = 4.0;
  TextEditingController desCon = TextEditingController();

  Future<void> rateDriver(String? driverId, bookingId) async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');
    var param = {
      "driver_id": driverId,
      "comments": desCon.text == "" ? "No Comments" : desCon.text,
      "booking_id": bookingId,
      "rating": rating.toString(),
      "user_id": userId.toString(),
    };
    apiBaseHelper.postAPICall(addReview, param).then(
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: !isLoading
            ?

            //   ListView.builder(
            // itemCount: 1,
            // itemBuilder: (context, index) {
            //   return Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Card(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(16),
            //       ),
            //       child: Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Container(
            //             width: double.infinity,
            //             decoration: const BoxDecoration(
            //               color: Colors.green,
            //               borderRadius:
            //                   BorderRadius.vertical(top: Radius.circular(16)),
            //             ),
            //             padding: const EdgeInsets.symmetric(vertical: 16),
            //             child: const Center(
            //               child: Text(
            //                 'BOOKING SET!',
            //                 style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 18,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ),
            //           ),
            //           const Padding(
            //             padding: EdgeInsets.all(16),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Row(
            //                   children: [
            //                     Text(
            //                       'Estimated Fare',
            //                       style: TextStyle(
            //                           fontSize: 16,
            //                           fontWeight: FontWeight.bold),
            //                     ),
            //                     Spacer(),
            //                     Text(
            //                       '₹400.00',
            //                       style: TextStyle(
            //                           fontSize: 18,
            //                           fontWeight: FontWeight.bold,
            //                           color: Colors.black),
            //                     ),
            //                     SizedBox(width: 4),
            //                     Icon(Icons.info_outline, size: 18),
            //                   ],
            //                 ),
            //                 SizedBox(height: 8),
            //                 Row(
            //                   children: [
            //                     Icon(Icons.warning_amber_rounded,
            //                         color: Colors.orange),
            //                     SizedBox(width: 4),
            //                     Text(
            //                       'Your Trip is not covered!',
            //                       style: TextStyle(
            //                           color: Colors.orange,
            //                           fontWeight: FontWeight.bold),
            //                     ),
            //                   ],
            //                 ),
            //                 SizedBox(height: 16),
            //                 Text(
            //                   'Trip Type: In-City (Round trip)',
            //                   style: TextStyle(fontWeight: FontWeight.bold),
            //                 ),
            //                 SizedBox(height: 12),
            //                 Row(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Icon(Icons.location_on, color: Colors.green),
            //                     SizedBox(width: 8),
            //                     Expanded(
            //                       child: Text(
            //                         '123, Park St, Mullick Bazar, Beniapukur, Kolkata, West Bengal 700017, India',
            //                         style: TextStyle(fontSize: 14),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 SizedBox(height: 8),
            //                 Row(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Icon(Icons.location_on, color: Colors.red),
            //                     SizedBox(width: 8),
            //                     Expanded(
            //                       child: Text(
            //                         '123, Park St, Mullick Bazar, Beniapukur, Kolkata, West Bengal 700017, India',
            //                         style: TextStyle(fontSize: 14),
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 SizedBox(height: 16),
            //                 Row(
            //                   children: [
            //                     Icon(Icons.calendar_today, size: 18),
            //                     SizedBox(width: 8),
            //                     Text(
            //                       '21/08/2024 at 4:40 AM',
            //                       style: TextStyle(fontSize: 14),
            //                     ),
            //                     Spacer(),
            //                     Icon(Icons.timer, size: 18),
            //                     SizedBox(width: 8),
            //                     Text(
            //                       '2 Hours',
            //                       style: TextStyle(fontSize: 14),
            //                     ),
            //                   ],
            //                 ),
            //                 SizedBox(height: 16),
            //                 Row(
            //                   children: [
            //                     Icon(Icons.directions_car, size: 20),
            //                     SizedBox(width: 8),
            //                     Text('Hatchback-Manual'),
            //                     Spacer(),
            //                     Icon(Icons.money, size: 20),
            //                     SizedBox(width: 8),
            //                     Text('Cash'),
            //                   ],
            //                 ),
            //                 SizedBox(height: 16),
            //                 Divider(),
            //                 SizedBox(height: 8),
            //                 Text(
            //                   '*Rate may change if the trip goes overtime.\n*Fare may vary depending on trip duration, car type and other factors.\n*Night charges may apply in addition for trips ending after 10:30 PM.',
            //                   style:
            //                       TextStyle(fontSize: 12, color: Colors.grey),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           Container(
            //             padding: const EdgeInsets.all(16),
            //             width: double.infinity,
            //             child: ElevatedButton(
            //               style: ElevatedButton.styleFrom(
            //                 backgroundColor: Colors.green,
            //                 padding: const EdgeInsets.symmetric(vertical: 14),
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(10),
            //                 ),
            //               ),
            //               onPressed: () {
            //                 _bookingDetails();
            //               },
            //               child: const Text(
            //                 'DONE',
            //                 style: TextStyle(
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.bold,
            //                     color: Colors.white),
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   );

            ///old code
            Stack(
                children: [
                  customdwithoutBackScr(context, "Booking management"),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.10),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Color(0xffF6F6F6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: RefreshIndicator(
                      color: AppColors.blackTemp,
                      onRefresh: () async {
                        getBooking();
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            upcomingBookingList.isEmpty
                                ? Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.6,
                                    width: MediaQuery.of(context).size.width,
                                    child: const Center(
                                      child: Text(
                                        'Booking Not Found',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height /
                                        1.2,
                                    child: ListView.builder(
                                      itemCount:
                                          upcomingBookingList.length ?? 0,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BookingDetails(
                                                        model:
                                                            upcomingBookingList[
                                                                index]),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Booking Id: ${upcomingBookingList[index].uneaqueId}',
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Spacer(),
                                                          upcomingBookingList[
                                                                          index]
                                                                      .status ==
                                                                  "complete"
                                                              ? SizedBox()
                                                              : Container(
                                                                  height: 30,
                                                                  width: 80,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: AppColors
                                                                          .primary),
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OTP: ${upcomingBookingList[index].startOtp}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                          const SizedBox(
                                                              width: 4),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'Estimated Fare',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            '₹ ${upcomingBookingList[index].amount}',
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          const SizedBox(
                                                              width: 4),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Trip Type: ${upcomingBookingList[index].tripType}',
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        4),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: _getStatusColor(
                                                                  upcomingBookingList[
                                                                          index]
                                                                      .status),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Text(
                                                              _getStatusText(
                                                                  upcomingBookingList[
                                                                          index]
                                                                      .status),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 12),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Icon(
                                                              Icons.location_on,
                                                              color:
                                                                  Colors.green),
                                                          const SizedBox(
                                                              width: 8),
                                                          Expanded(
                                                            child: Text(
                                                              '${upcomingBookingList[index].pickupAddress}',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          14),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Icon(
                                                              Icons.location_on,
                                                              color:
                                                                  Colors.red),
                                                          SizedBox(width: 8),
                                                          Expanded(
                                                            child: Text(
                                                              '${upcomingBookingList[index].dropAddress}',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          14),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 16),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons
                                                                  .calendar_today,
                                                              size: 18),
                                                          SizedBox(width: 8),
                                                          Text(
                                                            '${upcomingBookingList[index].pickupDate} ${upcomingBookingList[index].pickupTime}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                          Spacer(),
                                                          const Icon(
                                                              Icons.timer,
                                                              size: 18),
                                                          const SizedBox(
                                                              width: 8),
                                                          Text(
                                                            '${upcomingBookingList[index].duration}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      Row(
                                                        children: [
                                                          Image.network(
                                                            "${upcomingBookingList[index].carImage}",
                                                            height: 50,
                                                            width: 50,
                                                          ),
                                                          // const Icon(Icon.directions_car, size: 20),
                                                          const SizedBox(
                                                              width: 8),
                                                          Text(
                                                              '${upcomingBookingList[index].carModel} - ${upcomingBookingList[index].manualType}'),
                                                          const Spacer(),
                                                          const Icon(
                                                              Icons.payment,
                                                              size: 20),
                                                          const SizedBox(
                                                              width: 8),
                                                          Text(
                                                              '${upcomingBookingList[index].paymentMedia}'),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                upcomingBookingList[index]
                                                            .status ==
                                                        "complete"
                                                    ? Container(
                                                        // height: 50,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                right: 10,
                                                                bottom: 10),
                                                        width: 300,
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.green,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        14),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: const Text(
                                                                        "Add Review"),
                                                                    content:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          10),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          // const Text(
                                                                          //   "Rate Vendor",
                                                                          //   style:
                                                                          //       TextStyle(
                                                                          //     fontSize:
                                                                          //         14.0,
                                                                          //     fontWeight:
                                                                          //         FontWeight.bold,
                                                                          //     color: Colors
                                                                          //         .black,
                                                                          //   ),
                                                                          // ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          const Divider(),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          RatingBar(
                                                                            initialRating:
                                                                                rating,
                                                                            direction:
                                                                                Axis.horizontal,
                                                                            allowHalfRating:
                                                                                true,
                                                                            itemCount:
                                                                                5,
                                                                            itemSize:
                                                                                36,
                                                                            ratingWidget:
                                                                                RatingWidget(
                                                                              full: const Icon(
                                                                                Icons.star,
                                                                                color: Colors.orange,
                                                                              ),
                                                                              half: const Icon(
                                                                                Icons.star_half_rounded,
                                                                                color: Colors.grey,
                                                                              ),
                                                                              empty: const Icon(
                                                                                Icons.star_border_rounded,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                            itemPadding:
                                                                                EdgeInsets.zero,
                                                                            onRatingUpdate:
                                                                                (rating1) {
                                                                              print(rating1);
                                                                              setState(() {
                                                                                rating = rating1;
                                                                              });
                                                                            },
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          TextFormField(
                                                                            controller:
                                                                                desCon,
                                                                            keyboardType:
                                                                                TextInputType.text,
                                                                            // validator: (value) {
                                                                            //   if (value == null || value.isEmpty) {
                                                                            //     return 'Please enter your mobile number';
                                                                            //   } else if (value.length < 10 || value.length > 10) {
                                                                            //     return "Mobile number must be 10 digits";
                                                                            //   }
                                                                            //   return null;
                                                                            // },
                                                                            decoration:
                                                                                InputDecoration(
                                                                              // prefixIcon: const Icon(Icons.call_outlined),
                                                                              counterText: "",
                                                                              isDense: true,
                                                                              hintText: 'Write Comment',
                                                                              hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                                                                              border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(5),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          // EntryField(
                                                                          //   controller: desCon,
                                                                          //   keyboardType: TextInputType.name,
                                                                          //   label: "Write Comment",
                                                                          // ),
                                                                          const SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              rateDriver(upcomingBookingList[index].driverId.toString(), upcomingBookingList[index].uneaqueId.toString());
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: 48,
                                                                              decoration: BoxDecoration(
                                                                                color: AppColors.primary,
                                                                                borderRadius: const BorderRadius.all(
                                                                                  Radius.circular(25.0),
                                                                                ),
                                                                                boxShadow: <BoxShadow>[
                                                                                  BoxShadow(color: AppColors.primary.withOpacity(0.5), offset: const Offset(1.1, 1.1), blurRadius: 10.0),
                                                                                ],
                                                                              ),
                                                                              child: const Center(
                                                                                child: Text(
                                                                                  "Rate Bookings",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontWeight: FontWeight.w600,
                                                                                    fontSize: 18,
                                                                                    letterSpacing: 0.0,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          child: const Text(
                                                            'Rate Driver',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox()
                                              ],
                                            ),
                                          ),
                                        );

                                        ///old code
                                        //   Stack(
                                        //   children: [
                                        //     customdwithoutBackScr(context, "Booking management"),
                                        //     Container(
                                        //       margin: EdgeInsets.only(
                                        //           top: MediaQuery.of(context).size.height * 0.15),
                                        //       height: MediaQuery.of(context).size.height,
                                        //       width: MediaQuery.of(context).size.width,
                                        //       padding: const EdgeInsets.symmetric(horizontal: 20),
                                        //       decoration: const BoxDecoration(
                                        //         color: Color(0xffF6F6F6),
                                        //         borderRadius: BorderRadius.only(
                                        //           topLeft: Radius.circular(30),
                                        //           topRight: Radius.circular(30),
                                        //         ),
                                        //       ),
                                        //       child: SingleChildScrollView(
                                        //         child: Column(
                                        //           children: [
                                        //             const SizedBox(
                                        //               height: 20,
                                        //             ),
                                        //             Row(
                                        //               children: [
                                        //                 Text(
                                        //                   'Current bookings',
                                        //                   style: TextStyle(
                                        //                       fontSize: 17,
                                        //                       fontWeight: FontWeight.w500),
                                        //                 ),
                                        //               ],
                                        //             ),
                                        //             const SizedBox(
                                        //               height: 20,
                                        //             ),
                                        //             bookingList.isEmpty
                                        //                 ? Container(
                                        //                     height:
                                        //                         MediaQuery.of(context).size.height /
                                        //                             1.6,
                                        //                     width:
                                        //                         MediaQuery.of(context).size.width,
                                        //                     child: Center(
                                        //                       child: Text(
                                        //                         'Booking Not Found',
                                        //                         style: TextStyle(
                                        //                             fontSize: 15,
                                        //                             fontWeight: FontWeight.bold),
                                        //                       ),
                                        //                     ),
                                        //                   )
                                        //                 : Container(
                                        //                     height:
                                        //                         MediaQuery.of(context).size.height /
                                        //                             1.6,
                                        //                     child: ListView.builder(
                                        //                       shrinkWrap: true,
                                        //                       physics:
                                        //                           AlwaysScrollableScrollPhysics(),
                                        //                       itemCount: bookingList.length ?? 0,
                                        //                       itemBuilder: (context, index) {
                                        //                         return Padding(
                                        //                           padding: const EdgeInsets.only(
                                        //                               bottom: 20),
                                        //                           child: Card(
                                        //                             shape: RoundedRectangleBorder(
                                        //                               borderRadius:
                                        //                                   BorderRadius.circular(
                                        //                                       12.0),
                                        //                             ),
                                        //                             child: Container(
                                        //                               // height: 300,
                                        //                               child: Padding(
                                        //                                 padding:
                                        //                                     const EdgeInsets.all(
                                        //                                         15),
                                        //                                 child: Column(
                                        //                                     mainAxisAlignment:
                                        //                                         MainAxisAlignment
                                        //                                             .spaceEvenly,
                                        //                                     children: [
                                        //                                       Text(
                                        //                                         'Booking Confirmation',
                                        //                                         style: TextStyle(
                                        //                                             fontSize: 17,
                                        //                                             fontWeight:
                                        //                                                 FontWeight
                                        //                                                     .w500,
                                        //                                             color: AppColors
                                        //                                                 .primary),
                                        //                                       ),
                                        //                                       Divider(),
                                        //                                       Row(
                                        //                                         children: [
                                        //                                           Text(
                                        //                                             'Booking Id - ',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                           Spacer(),
                                        //                                           Text(
                                        //                                             '${bookingList[index].bookingId}',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                         ],
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       Row(
                                        //                                         children: [
                                        //                                           Text(
                                        //                                             'Pickup Address - ',
                                        //                                             style:
                                        //                                                 TextStyle(
                                        //                                               fontSize: 15,
                                        //                                               fontWeight:
                                        //                                                   FontWeight
                                        //                                                       .w500,
                                        //                                             ),
                                        //                                           ),
                                        //                                           Spacer(),
                                        //                                           SizedBox(
                                        //                                               width: MediaQuery.of(
                                        //                                                           context)
                                        //                                                       .size
                                        //                                                       .width /
                                        //                                                   2.5,
                                        //                                               child: Text(
                                        //                                                 '${bookingList[index].pickupAddress}',
                                        //                                                 style:
                                        //                                                     TextStyle(
                                        //                                                   fontSize:
                                        //                                                       15,
                                        //                                                   fontWeight:
                                        //                                                       FontWeight
                                        //                                                           .w500,
                                        //                                                 ),
                                        //                                                 overflow:
                                        //                                                     TextOverflow
                                        //                                                         .ellipsis,
                                        //                                                 maxLines: 3,
                                        //                                               )),
                                        //                                         ],
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       Row(
                                        //                                         children: [
                                        //                                           Text(
                                        //                                             'Drap Address - ',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                           Spacer(),
                                        //                                           SizedBox(
                                        //                                               width: MediaQuery.of(
                                        //                                                           context)
                                        //                                                       .size
                                        //                                                       .width /
                                        //                                                   2.5,
                                        //                                               child: Text(
                                        //                                                 '${bookingList[index].dropAddress}',
                                        //                                                 style:
                                        //                                                     TextStyle(
                                        //                                                   fontSize:
                                        //                                                       15,
                                        //                                                   fontWeight:
                                        //                                                       FontWeight
                                        //                                                           .w500,
                                        //                                                 ),
                                        //                                                 overflow:
                                        //                                                     TextOverflow
                                        //                                                         .ellipsis,
                                        //                                                 maxLines: 3,
                                        //                                               )),
                                        //                                         ],
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       Row(
                                        //                                         children: [
                                        //                                           Text(
                                        //                                             'Reporting Time - ',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                           Spacer(),
                                        //                                           Text(
                                        //                                             '${bookingList[index].reporting}',
                                        //                                             style:
                                        //                                                 TextStyle(
                                        //                                               fontSize: 15,
                                        //                                               fontWeight:
                                        //                                                   FontWeight
                                        //                                                       .w500,
                                        //                                             ),
                                        //                                             overflow:
                                        //                                                 TextOverflow
                                        //                                                     .ellipsis,
                                        //                                             maxLines: 1,
                                        //                                           ),
                                        //                                         ],
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       Row(
                                        //                                         children: [
                                        //                                           Text(
                                        //                                             'Vehicle Category - ',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                           Spacer(),
                                        //                                           Text(
                                        //                                             '${bookingList[index].vehicleType}',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                         ],
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       Row(
                                        //                                         children: [
                                        //                                           Text(
                                        //                                             'Car Type - ',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                           Spacer(),
                                        //                                           Text(
                                        //                                             '${bookingList[index].carModel}',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                         ],
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       Row(
                                        //                                         children: [
                                        //                                           Text(
                                        //                                             'In City/Out City - ',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                           Spacer(),
                                        //                                           Text(
                                        //                                             '${bookingList[index].inOutCity}',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                         ],
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       Row(
                                        //                                         children: [
                                        //                                           Text(
                                        //                                             'One Way/Two Way - ',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                           Spacer(),
                                        //                                           Text(
                                        //                                             '${bookingList[index].oneTowWay}',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                         ],
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       Row(
                                        //                                         children: [
                                        //                                           Text(
                                        //                                             'Booking Date - ',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                           Spacer(),
                                        //                                           Text(
                                        //                                             '${bookingList[index].pickupDate}',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                         ],
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       Row(
                                        //                                         children: [
                                        //                                           Text(
                                        //                                             'Pickup Time - ',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                           Spacer(),
                                        //                                           Text(
                                        //                                             '${bookingList[index].pickupTime}',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                         ],
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       Row(
                                        //                                         children: [
                                        //                                           Text(
                                        //                                             'Duration - ',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                           Spacer(),
                                        //                                           Text(
                                        //                                             '${bookingList[index].bookingTypes}',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                         ],
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       Row(
                                        //                                         children: [
                                        //                                           Text(
                                        //                                             'How Many ${bookingList[index].bookingTypes} - ',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                           Spacer(),
                                        //                                           Text(
                                        //                                             '${bookingList[index].bookingTime}',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                         ],
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       Row(
                                        //                                         children: [
                                        //                                           Text(
                                        //                                             'Total Amount - ',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                           Spacer(),
                                        //                                           Text(
                                        //                                             'RS ${bookingList[index].amount}/-',
                                        //                                             style: TextStyle(
                                        //                                                 fontSize:
                                        //                                                     15,
                                        //                                                 fontWeight:
                                        //                                                     FontWeight
                                        //                                                         .w500),
                                        //                                           ),
                                        //                                         ],
                                        //                                       ),
                                        //                                       SizedBox(
                                        //                                         height: 5,
                                        //                                       ),
                                        //                                       Container(
                                        //                                         height: 50,
                                        //                                         width:
                                        //                                             MediaQuery.of(
                                        //                                                     context)
                                        //                                                 .size
                                        //                                                 .width,
                                        //                                         decoration: BoxDecoration(
                                        //                                             borderRadius:
                                        //                                                 BorderRadius
                                        //                                                     .circular(
                                        //                                                         10),
                                        //                                             border: Border.all(
                                        //                                                 color: AppColors
                                        //                                                     .primary)),
                                        //                                         child: Padding(
                                        //                                           padding:
                                        //                                               const EdgeInsets
                                        //                                                   .all(5),
                                        //                                           child: Row(
                                        //                                             children: [
                                        //                                               Text(
                                        //                                                 'Status - ',
                                        //                                                 style: TextStyle(
                                        //                                                     fontSize:
                                        //                                                         15,
                                        //                                                     fontWeight:
                                        //                                                         FontWeight.w500),
                                        //                                               ),
                                        //                                               Spacer(),
                                        //                                               bookingList[index]
                                        //                                                           .status ==
                                        //                                                       "Pending"
                                        //                                                   ? Text(
                                        //                                                       '${bookingList[index].status}',
                                        //                                                       style: TextStyle(
                                        //                                                           fontSize: 15,
                                        //                                                           fontWeight: FontWeight.w500,
                                        //                                                           color: Colors.yellow),
                                        //                                                     )
                                        //                                                   : Text(
                                        //                                                       '${bookingList[index].status}',
                                        //                                                       style: TextStyle(
                                        //                                                           fontSize: 15,
                                        //                                                           fontWeight: FontWeight.w500,
                                        //                                                           color: Colors.green),
                                        //                                                     ),
                                        //                                             ],
                                        //                                           ),
                                        //                                         ),
                                        //                                       ),
                                        //                                     ]),
                                        //                               ),
                                        //                             ),
                                        //                           ),
                                        //                         );
                                        //                       },
                                        //                     ),
                                        //                   )
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            // },
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: LoadingWidget2(context),
                ),
              ),
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

  String _getStatusText(String? status) {
    print('i m here ${status}');
    switch (status) {
      case 'Processing':
        return 'Pending'; // showing 'Pending' instead of 'Processing'
      case 'Cancelled':
        return 'Cancelled';
      case 'Accepted':
        return 'Accepted';
      case 'complete':
        return 'Completed';
      default:
        return 'Unknown'; // fallback text
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooking();
  }

  bool isLoading = false;

  List<BookingDataModel> upcomingBookingList = [];
  List<BookingDataModel> pastBookingList = [];

  Future<void> getBooking() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');

    var param = {
      'user_id': userId.toString(),
    };

    apiBaseHelper.postAPICall(getbookingurl, param).then(
      (getDta) {
        bool error = getDta['status'];
        String msg = getDta['message'];
        if (error == true) {
          setState(() {
            BookingModel bookingModel = BookingModel.fromJson(getDta);
            upcomingBookingList = bookingModel.data?.upcomingbooking ?? [];
            pastBookingList = bookingModel.data?.pastbooking ?? [];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }
}
