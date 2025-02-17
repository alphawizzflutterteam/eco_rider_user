import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eco_rider_user/Api%20services/api_services/apiConstants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/customeTost.dart';
import '../../Model/cityModel.dart';
import '../../Model/getCarTypeModel.dart';
import '../../Model/getChargesModel.dart';
import '../../Model/getdurationDayModel.dart';
import '../../Widget/custom_app_button.dart';
import '../auth/custumScreen.dart';
import '../dashboard/dashboardScreen.dart';

class bookingScr extends StatefulWidget {
  String? pickupLocation;
  String? droplocation;
  bookingScr({Key? key, this.pickupLocation, this.droplocation})
      : super(key: key);

  @override
  State<bookingScr> createState() => _bookingScrState();
}

class _bookingScrState extends State<bookingScr> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Confirm Exit"),
                  content: Text("Are you sure you want to exit?"),
                  actions: <Widget>[
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: AppColors.primary),
                      child: const Text(
                        "YES",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: AppColors.primary),
                      child: const Text(
                        "NO",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
          return true;
        },
        child: Scaffold(
            bottomSheet: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        if (pickupLocationcontroller.text.isEmpty) {
                          customSnackbar(context,
                              "Please Select PickUp Location".toString());
                          // getNotifivcation();
                        } else if (droplocationcontroller.text.isEmpty) {
                          customSnackbar(context,
                              "Please Select Drop Location".toString());
                          // getNotifivcation();
                        } else if (_selectvehiclecat == null) {
                          customSnackbar(context,
                              "Please Select Vehicle Category".toString());
                          // getNotifivcation();
                        } else if (selectcartypr == null) {
                          customSnackbar(
                              context, "Please Select Car Type".toString());
                        }
                        // else if(_selectecity==null){
                        //   customSnackbar(context,"Please Select City".toString() );
                        //
                        // }

                        else if (selectincityoroutcity == null) {
                          customSnackbar(context,
                              "Please Select In City/Out City".toString());
                        } else if (selectonewayortwoway == null) {
                          customSnackbar(context,
                              "Please Select One Way/Two Way".toString());
                        } else if (fromdate == null) {
                          customSnackbar(
                              context, "Please Select Date".toString());
                        } else if (selectStrartTimeController.text.isEmpty) {
                          customSnackbar(
                              context, "Please Select Start Time".toString());
                        } else if (reportingTimecontroller.text.isEmpty) {
                          customSnackbar(context,
                              "Please Select Reporting Time".toString());
                        } else if (selecthour == null) {
                          customSnackbar(context,
                              "Please Select Duration Selection".toString());
                        } else if (enterDurationController.text.isEmpty) {
                          customSnackbar(context,
                              "Please Enter How Many Duration".toString());
                        } else {
                          !isLoading ? driverbooking() : SizedBox();
                        }
                      },
                      child: CustomButton(
                        textt: !isLoading ? "Submit" : "Please Wait ...",
                      )),
                ],
              ),
            ),
            body: Stack(
              children: [
                customdwithoutBackScr(context, "Driver booking"),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xffF6F6F6),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),

                          TextFormField(
                            readOnly: true,
                            onTap: () {
                              showPlacePicker("pl");
                            },
                            controller: pickupLocationcontroller,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.location_on,
                                color: AppColors.tabtextColor,
                              ),
                              hintText: 'Pickup Location',
                              labelText: 'Pickup Location',
                              hintStyle: TextStyle(fontSize: 13),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 5),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.primary, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primary),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Pickup Location';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          TextFormField(
                            readOnly: true,
                            onTap: () {
                              showPlacePicker("dl");
                            },
                            controller: droplocationcontroller,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.location_on,
                                color: AppColors.tabtextColor,
                              ),
                              hintText: 'Drop Location',
                              labelText: "Drop Location`",
                              hintStyle: TextStyle(fontSize: 13),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 5),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: AppColors.primary, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: AppColors.primary, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primary),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Drop Location';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              Text(
                                'Select Vehicle Category',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.tabtextColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 2, color: AppColors.whiteTemp),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,

                                hint: Text(
                                  'Select Vehicle Category',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: AppColors.tabtextColor,
                                      fontSize: 15),
                                ), // Not necessary for Option 1
                                value: _selectvehiclecat,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectcartypr = null;
                                    _selectvehiclecat = newValue.toString();
                                    if (_selectvehiclecat == "Manual") {
                                      setState(() {
                                        selectcartypr = null;
                                        selectVehiclecatId = "1";
                                      });
                                      print(selectVehiclecatId);
                                    } else {
                                      setState(() {
                                        selectcartypr = null;
                                        selectVehiclecatId = "2";
                                      });
                                      print(selectVehiclecatId);
                                    }
                                  });

                                  getcarType(selectVehiclecatId.toString());
                                },
                                items: selectvehicle_List.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Select Car Type',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.tabtextColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 2, color: AppColors.whiteTemp),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,

                                hint: Text(
                                  'Select Car Type',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: AppColors.tabtextColor,
                                      fontSize: 15),
                                ), // Not necessary for Option 1
                                value: selectcartypr,
                                onChanged: (dynamic newValue) {
                                  setState(() {
                                    selectcartypr = newValue;
                                    selectCartypeId = newValue.id;
                                    print(selectCartypeId);
                                  });
                                },
                                items:
                                    carTypeModel?.data.map((dynamic location) {
                                  return DropdownMenuItem(
                                    child:
                                        new Text(location.carModel.toString()),
                                    value: location,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),

                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'Select City',
                          //       style: TextStyle(
                          //           fontSize: 15,
                          //           fontWeight: FontWeight.bold,
                          //           color: AppColors.tabtextColor),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          //
                          // Container(
                          //   height: 50,
                          //   width: MediaQuery.of(context).size.width,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(12),
                          //     border: Border.all(
                          //         width: 2, color: AppColors.whiteTemp),
                          //   ),
                          //   child: DropdownButtonHideUnderline(
                          //     child: DropdownButton2(
                          //       isExpanded: true,
                          //
                          //       hint: Text(
                          //         'Select City',
                          //         overflow: TextOverflow.ellipsis,
                          //         maxLines: 1,
                          //         style: TextStyle(
                          //             color: AppColors.tabtextColor,
                          //             fontSize: 15),
                          //       ), // Not necessary for Option 1
                          //       value: _selectecity,
                          //       onChanged: (dynamic newValue) {
                          //         setState(() {
                          //           _selectecity = newValue;
                          //           selectCityId = newValue.id;
                          //           print(selectCityId);
                          //         });
                          //       },
                          //       items: cityModel?.data.map((dynamic location) {
                          //         return DropdownMenuItem(
                          //           child: new Text(location.name.toString()),
                          //           value: location,
                          //         );
                          //       }).toList(),
                          //     ),
                          //   ),
                          // ),

                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Select',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.tabtextColor),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 2, color: AppColors.whiteTemp),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 30,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectincityoroutcity = 'In City';
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                'In City',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.tabtextColor),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                      color: AppColors.primary,
                                                      width: 1),
                                                ),
                                                child: Center(
                                                    child:
                                                        selectincityoroutcity ==
                                                                'In City'
                                                            ? Icon(
                                                                Icons.check,
                                                                color: AppColors
                                                                    .primary,
                                                              )
                                                            : SizedBox()),
                                              )
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectincityoroutcity =
                                                  'Out City';
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                'Out City',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.tabtextColor),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                      color: AppColors.primary,
                                                      width: 1),
                                                ),
                                                child: Center(
                                                    child:
                                                        selectincityoroutcity ==
                                                                'Out City'
                                                            ? Icon(
                                                                Icons.check,
                                                                color: AppColors
                                                                    .primary,
                                                              )
                                                            : SizedBox()),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 17,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectonewayortwoway = 'One Way';
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                'One Way',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.tabtextColor),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                      color: AppColors.primary,
                                                      width: 1),
                                                ),
                                                child: Center(
                                                    child:
                                                        selectonewayortwoway ==
                                                                'One Way'
                                                            ? Icon(
                                                                Icons.check,
                                                                color: AppColors
                                                                    .primary,
                                                              )
                                                            : SizedBox()),
                                              )
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectonewayortwoway = 'Two Way';
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                'Two Way',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.tabtextColor),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  border: Border.all(
                                                      color: AppColors.primary,
                                                      width: 1),
                                                ),
                                                child: Center(
                                                    child:
                                                        selectonewayortwoway ==
                                                                'Two Way'
                                                            ? Icon(
                                                                Icons.check,
                                                                color: AppColors
                                                                    .primary,
                                                              )
                                                            : SizedBox()),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              )),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              Text(
                                'Date Selection',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.tabtextColor),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          InkWell(
                            onTap: () {
                              sselectDate(context, "from");
                            },
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 2, color: AppColors.whiteTemp),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      fromdate != null
                                          ? Text(
                                              '${fromdate}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.tabtextColor),
                                            )
                                          : Text(
                                              'Select Date',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.tabtextColor),
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.calendar_month,
                                        color: AppColors.primary,
                                      )
                                    ]),
                              ),
                            ),
                          ),

                          // Row(
                          //   children: [
                          //     Text(
                          //       'Date Selection',
                          //       style: TextStyle(
                          //           fontSize: 15,
                          //           fontWeight: FontWeight.bold,
                          //           color: AppColors.tabtextColor),
                          //     ),
                          //   ],
                          // ),
                          //
                          // SizedBox(
                          //   height: 10,
                          // ),
                          //
                          // Container(
                          //     height: 60,
                          //     width: MediaQuery.of(context).size.width,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(12),
                          //       border: Border.all(
                          //           width: 2, color: AppColors.whiteTemp),
                          //     ),
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8),
                          //       child: Row(
                          //         children: [
                          //           Text(
                          //             'Date',
                          //             style: TextStyle(
                          //                 fontSize: 10,
                          //                 fontWeight: FontWeight.bold,
                          //                 color: AppColors.tabtextColor),
                          //           ),
                          //           SizedBox(
                          //             width: 3,
                          //           ),
                          //           InkWell(
                          //             onTap: () {
                          //               sselectDate(context, "from");
                          //             },
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                   borderRadius:
                          //                       BorderRadius.circular(2),
                          //                   border: Border.all(
                          //                       width: 1,
                          //                       color:
                          //                           AppColors.faqanswerColor)),
                          //               height: 35,
                          //               width: 130,
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(3),
                          //                 child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                     children: [
                          //                       fromdate != null
                          //                           ? Text(
                          //                               '${fromdate}',
                          //                               style: TextStyle(
                          //                                   fontSize: 10,
                          //                                   fontWeight:
                          //                                       FontWeight.bold,
                          //                                   color: AppColors
                          //                                       .tabtextColor),
                          //                             )
                          //                           : Text(
                          //                               'Select Start Date',
                          //                               style: TextStyle(
                          //                                   fontSize: 10,
                          //                                   fontWeight:
                          //                                       FontWeight.bold,
                          //                                   color: AppColors
                          //                                       .tabtextColor),
                          //                             ),
                          //                       SizedBox(
                          //                         width: 10,
                          //                       ),
                          //                       Icon(
                          //                         Icons.calendar_month,
                          //                         color: AppColors.primary,
                          //                       )
                          //                     ]),
                          //               ),
                          //             ),
                          //           ),
                          //           Spacer(),
                          //           Text(
                          //             'To',
                          //             style: TextStyle(
                          //                 fontSize: 10,
                          //                 fontWeight: FontWeight.bold,
                          //                 color: AppColors.tabtextColor),
                          //           ),
                          //           Spacer(),
                          //           InkWell(
                          //             onTap: () {
                          //               sselectDate(context, "to");
                          //             },
                          //             child: Container(
                          //               decoration: BoxDecoration(
                          //                   borderRadius:
                          //                       BorderRadius.circular(2),
                          //                   border: Border.all(
                          //                       width: 1,
                          //                       color:
                          //                           AppColors.faqanswerColor)),
                          //               height: 35,
                          //               width: 130,
                          //               child: Padding(
                          //                 padding: const EdgeInsets.all(3),
                          //                 child: Row(
                          //                     mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                     children: [
                          //                       todate != null
                          //                           ? Text(
                          //                               '${todate}',
                          //                               style: TextStyle(
                          //                                   fontSize: 10,
                          //                                   fontWeight:
                          //                                       FontWeight.bold,
                          //                                   color: AppColors
                          //                                       .tabtextColor),
                          //                             )
                          //                           : Text(
                          //                               'Select End Date',
                          //                               style: TextStyle(
                          //                                   fontSize: 10,
                          //                                   fontWeight:
                          //                                       FontWeight.bold,
                          //                                   color: AppColors
                          //                                       .tabtextColor),
                          //                             ),
                          //                       SizedBox(
                          //                         width: 10,
                          //                       ),
                          //                       Icon(
                          //                         Icons.calendar_month,
                          //                         color: AppColors.primary,
                          //                       )
                          //                     ]),
                          //               ),
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     )),
                          //
                          // SizedBox(
                          //   height: 20,
                          // ),

                          Row(
                            children: [
                              Text(
                                'Start Time',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.tabtextColor),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          InkWell(
                            onTap: () {
                              selectTimeEE(context, "st");
                            },
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 2, color: AppColors.whiteTemp),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      selectStrartTimeController.text.isNotEmpty
                                          ? Text(
                                              '${selectStrartTimeController.text.toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.tabtextColor),
                                            )
                                          : Text(
                                              'Select Start Time',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.tabtextColor),
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.watch_later_outlined,
                                        color: AppColors.primary,
                                      )
                                    ]),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              Text(
                                'End Time',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.tabtextColor),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          InkWell(
                            onTap: () {
                              selectTimeEE(context, "et");
                            },
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 2, color: AppColors.whiteTemp),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      selectendTimeController.text.isNotEmpty
                                          ? Text(
                                              '${selectendTimeController.text.toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.tabtextColor),
                                            )
                                          : Text(
                                              'Select End Time',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.tabtextColor),
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.watch_later_outlined,
                                        color: AppColors.primary,
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              Text(
                                'Reporting Time',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.tabtextColor),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          InkWell(
                            onTap: () {
                              selectTimeEE(context, "rt");
                            },
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 2, color: AppColors.whiteTemp),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      reportingTimecontroller.text.isNotEmpty
                                          ? Text(
                                              '${reportingTimecontroller.text.toString()}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.tabtextColor),
                                            )
                                          : Text(
                                              'Select Reporting Time',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.tabtextColor),
                                            ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.watch_later_outlined,
                                        color: AppColors.primary,
                                      )
                                    ]),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              Text(
                                'Duration Selection',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.tabtextColor),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Container(
                            height: 60,
                            child: ListView.builder(
                              itemCount: durationList.length ?? 0,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      totalamount = null;
                                      enterDurationController.clear();
                                      selecthour =
                                          durationList[index].title.toString();
                                      dayByPrice = durationList[index].price;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            '${durationList[index].title}',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.tabtextColor),
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              border: Border.all(
                                                  color: AppColors.primary,
                                                  width: 1),
                                            ),
                                            child: Center(
                                                child: selecthour ==
                                                        durationList[index]
                                                            .title
                                                            .toString()
                                                    ? Icon(
                                                        Icons.check,
                                                        color:
                                                            AppColors.primary,
                                                      )
                                                    : SizedBox()),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              Text(
                                'Enter How Many ${selecthour ?? ""}',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.tabtextColor),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          TextFormField(
                            maxLength: 2,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              totalamount = int.parse(value.toString()) *
                                  int.parse(dayByPrice.toString());
                              setState(() {});
                            },
                            controller: enterDurationController,
                            decoration: InputDecoration(
                              counterText: "",
                              prefixIcon: const Icon(
                                Icons.view_day_outlined,
                                color: AppColors.tabtextColor,
                              ),
                              hintText: 'Enter How Many ${selecthour ?? ""}',
                              hintStyle: TextStyle(fontSize: 15),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 5),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: AppColors.whiteTemp, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                      color: AppColors.whiteTemp, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                      color: AppColors.whiteTemp, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.whiteTemp),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter How Many ${selecthour ?? ""}';
                              }
                              return null; // Return null if the input is valid
                            },
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          Row(
                            children: [
                              Text(
                                'Pricing Information',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.tabtextColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Calculate the pricing on the basis of',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.tabtextColor),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 2, color: AppColors.whiteTemp),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Text(
                                      '${selecthour ?? ""} Price',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.tabtextColor),
                                    ),
                                    Spacer(),
                                    Text(
                                      'RS ${dayByPrice ?? "0"}/-',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary),
                                    ),
                                  ],
                                ),
                              )),

                          SizedBox(
                            height: 20,
                          ),

                          // Row(children: [
                          //   Text('Rental Charges For Each Vehicle',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                          // ],),

                          Row(
                            children: [
                              Text(
                                'Total Booking Amount',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.tabtextColor),
                              ),
                              Spacer(),
                              Text(
                                'RS ${totalamount ?? "0"}/-',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  CarTypeModel? carTypeModel;

  Future<void> getcarType(String carvehiclecatIdd) async {
    var param = {'type': '${carvehiclecatIdd}'};

    apiBaseHelper.postAPICall(getvehicletypeurl, param).then(
      (getDta) {
        bool error = getDta['status'];
        String msg = getDta['message'];

        if (error == true) {
          setState(() {
            carTypeModel = CarTypeModel.fromJson(getDta);
            setState(() {
              isLoading = false;
            });
          });
        } else {
          customSnackbar(context, msg.toString());

          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  CityModel? cityModel;
  Future<void> getCity() async {
    var headers = {
      'Cookie': 'ci_session=ef4cdcf5fae671b774c89a042e7086c10cd490e0'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}apigetCity'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['status'] == true) {
        setState(() {
          cityModel = CityModel.fromJson(finalResult);
        });
      } else {
        customSnackbar(context, finalResult['message'].toString());
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  GetChargesModel? getChargesModel;
  Future<void> getNightCharge() async {
    var headers = {
      'Cookie': 'ci_session=fd53547b3ce33a62d78d20537c1b66c6a7823105'
    };
    var request =
        http.MultipartRequest('GET', Uri.parse('${baseUrl}get_settings'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['status'] == true) {
        setState(() {
          getChargesModel = GetChargesModel.fromJson(finalResult);
        });
      } else {}
    } else {
      print(response.reasonPhrase);
    }
  }

  List<DurationModelList> durationList = [];
  Future<void> getDurationDayList() async {
    var headers = {
      'Cookie': 'ci_session=ef4cdcf5fae671b774c89a042e7086c10cd490e0'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}apiVehicleDuration_Amount'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      if (finalResult['status'] == true) {
        setState(() {
          durationList = DurationDayModel.fromJson(finalResult).data ?? [];
        });
      } else {
        customSnackbar(context, finalResult['message'].toString());
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  bool isLoading = false;
  var userId;
  Future<void> driverbooking() async {
    setState(() {
      isLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    var param = {
      'user_id': userId.toString(),
      'vehical_type': selectVehiclecatId.toString(),
      'vehical': selectCartypeId.toString(),
      // 'city': selectCityId.toString(),
      'pickup_address': pickupLocationcontroller.text.toString(),
      'drop_address': droplocationcontroller.text.toString(),
      // 'city_type': pickupLocationcontroller.text.toString(),
      'in_out_city': selectincityoroutcity.toString(),
      'one_tow_way': selectonewayortwoway.toString(),
      'start_date': fromdate.toString(),
      'end_date': todate.toString(),
      'reporting_time': reportingTimecontroller.text.toString(),
      'pickup_date': fromdate.toString(),
      'pickup_time': selectStrartTimeController.text.toString(),
      'duration': selectincityoroutcity == "In City" ? "Hourly" : "Directly",
      'total_amount': totalamount.toString(),
      'latitude': lat.toString(),
      'longitude': long.toString(),
    };

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
                builder: (context) => Dashboard(),
              ));
        } else {
          customSnackbar(context, msg.toString());

          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  var selectincityoroutcity;
  var selectonewayortwoway;
  String? selecthour;
  String? dayByPrice;
  dynamic _selectecity;
  String? _selectvehiclecat;

  dynamic selectcartypr;
  List<String> selectvehicle_List = ['Manual', 'Automatic'];

  String? selectVehiclecatId;
  String? selectCartypeId;
  String? selectCityId;

  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  Future<void> sselectDate(BuildContext context, String forrr) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) selectedDate = picked;

    if (forrr == "from") {
      fromdate = DateFormat('yyyy-MM-dd').format(selectedDate);
      print("==================${fromdate}");
      setState(() {});
    } else {
      todate = DateFormat('yyyy-MM-dd').format(selectedDate);
      print("==================${todate}");
      setState(() {});
    }

    setState(() {});
  }

  int? totalamount;
  var fromdate;
  var todate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCurrentLocation();
    // getCity();
    getNightCharge();
    getDurationDayList();
    pickupLocationcontroller.text = widget.pickupLocation.toString();
    droplocationcontroller.text = widget.droplocation.toString();
  }

  TextEditingController enterDurationController = TextEditingController();
  TextEditingController reportingTimecontroller = TextEditingController();

  var lat;
  var long;

  Position? currentLocation;

  Future getUserCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
    } else if (status.isGranted) {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((position) {
        if (mounted)
          setState(() {
            currentLocation = position;
            lat = currentLocation?.latitude;
            long = currentLocation?.longitude;
          });
      });
      print("LOCATION===" + currentLocation.toString());
      //updateDriverLocation();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  TextEditingController pickupLocationcontroller = TextEditingController();
  TextEditingController droplocationcontroller = TextEditingController();
  TextEditingController selectStrartTimeController = TextEditingController();
  TextEditingController selectendTimeController = TextEditingController();

  Future<void> selectTimeEE(BuildContext context, String val) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext? context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (val == "rt") {
        reportingTimecontroller.text = formatTime(picked);

        setState(() {});
        print(
            "===my technic=======${reportingTimecontroller.text}===============");
      } else if (val == "st") {
        selectStrartTimeController.text = formatTime(picked);

        setState(() {});
        print(
            "===my technic=======${selectStrartTimeController.text}===============");
      } else {
        selectendTimeController.text = formatTime(picked);

        setState(() {});
        print(
            "===my technic=======${selectendTimeController.text}===============");
      }
    }
  }

  String formatTime(TimeOfDay time) {
    int hour = time.hourOfPeriod ?? 0;
    int minute = time.minute ?? 0;
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:${minute.toString().padLeft(2, '0')} $period';
  }

  void showPlacePicker(String val) async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            PlacePicker("AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM")));

    // Check if the user picked a place
    if (result != null) {
      if (val == "pl") {
        setState(() {
          pickupLocationcontroller.text = '${result.formattedAddress}';
          print(pickupLocationcontroller.text);
        });
      } else {
        setState(() {
          droplocationcontroller.text = '${result.formattedAddress}';
          print(droplocationcontroller.text);
        });
      }
    }
  }
}
