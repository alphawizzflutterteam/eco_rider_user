import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eco_rider_user/Api%20services/api_services/apiConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/customeTost.dart';
import '../../Helper/loadingwidget.dart';
import '../../Model/cityModel.dart';
import '../../Model/getCarTypeModel.dart';
import '../../Model/getdurationDayModel.dart';
import '../../Widget/custom_app_button.dart';
import '../auth/custumScreen.dart';

class bookingScr extends StatefulWidget {
  const bookingScr({Key? key}) : super(key: key);

  @override
  State<bookingScr> createState() => _bookingScrState();
}

class _bookingScrState extends State<bookingScr> {

  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        bottomSheet:

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(

                onTap: () {



                    if(_selectvehiclecat==null){
                      customSnackbar(context,"Please Select Vehicle Category".toString() );
                      // getNotifivcation();

                    }
                    else if(selectcartypr==null){
                    customSnackbar(context,"Please Select Car Type".toString() );

                    }
                    else if(_selectecity==null){
                      customSnackbar(context,"Please Select City".toString() );

                    }
                    else if(selectCityCommaSaparated==null){
                      customSnackbar(context,"Please Select In City/Out City".toString() );

                    }

                    else if(fromdate==null){
                      customSnackbar(context,"Please Select From Date".toString() );

                    }
                    else if(todate==null){
                      customSnackbar(context,"Please Select To Date".toString() );

                    }
                    else if(selecthour==null){
                      customSnackbar(context,"Please Select Duration Selection".toString() );

                    }

                  else if(enterDurationController.text.isEmpty){
                  customSnackbar(context,"Please Enter How Many Duration".toString() );

                  }else{
                      driverbooking();

                    }

                },
                child:

                CustomButton(textt: "Submit",)


              ),
            ],
          ),
        ),
          body:



          Stack(
            children: [

              customdwithoutBackScr(context,"Driver booking"),

              Container(
                margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffF6F6F6),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                    child: Column(
                      children: [


                        SizedBox(height: 20,),
                        Row(children: [


                          Text('Select Vehicle Category',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                        ],),
                        SizedBox(height: 10,),


                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 2, color: AppColors.whiteTemp),
                          ),
                          child: DropdownButtonHideUnderline(

                            child:

                            DropdownButton2(

                              isExpanded: true,

                              hint: Text(
                                'Select Vehicle Category',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style:
                                TextStyle(color: AppColors.tabtextColor,fontSize: 15),
                              ), // Not necessary for Option 1
                              value: _selectvehiclecat,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectvehiclecat = newValue.toString();
                                  if(_selectvehiclecat=="Manual"){

                                    setState(() {
                                      selectcartypr=null;
                                      selectVehiclecatId="1";
                                    });
                                    print(selectVehiclecatId);



                                  }else{
                                    setState(() {
                                      selectcartypr=null;
                                      selectVehiclecatId="2";
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
                        SizedBox(height: 20,),
                        Row(children: [


                          Text('Select Car Type',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                        ],),
                        SizedBox(height: 10,),


                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 2, color: AppColors.whiteTemp),
                          ),
                          child: DropdownButtonHideUnderline(

                            child:

                            DropdownButton2(

                              isExpanded: true,

                              hint: Text(
                                'Select Car Type',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style:
                                TextStyle(color: AppColors.tabtextColor,fontSize: 15),
                              ), // Not necessary for Option 1
                              value: selectcartypr,
                              onChanged: (dynamic newValue) {
                                setState(() {
                                  selectcartypr = newValue;
                                  selectCartypeId=newValue.id;
                                  print(selectCartypeId);

                                });
                              },
                              items: carTypeModel?.data.map((dynamic location) {
                                return DropdownMenuItem(
                                  child: new Text(location.carModel.toString()),
                                  value: location,
                                );
                              }).toList(),
                            ),


                          ),
                        ),




                        SizedBox(height: 20,),
                        Row(children: [


                          Text('Select City',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                        ],),
                        SizedBox(height: 10,),


                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 2, color: AppColors.whiteTemp),
                          ),
                          child: DropdownButtonHideUnderline(

                            child:

                            DropdownButton2(

                              isExpanded: true,

                              hint: Text(
                                'Select City',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style:
                                TextStyle(color: AppColors.tabtextColor,fontSize: 15),
                              ), // Not necessary for Option 1
                              value: _selectecity,
                              onChanged: (dynamic newValue) {
                                setState(() {
                                  _selectecity = newValue;
                                  selectCityId=newValue.id;
                                  print(selectCityId);

                                });
                              },
                              items: cityModel?.data.map((dynamic location) {
                                return DropdownMenuItem(
                                  child: new Text(location.name.toString()),
                                  value: location,
                                );
                              }).toList(),
                            ),


                          ),
                        ),

                        SizedBox(height: 20,),
                        Row(children: [


                          Text('Select',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                        ],),
                        SizedBox(height: 10,),


                        Container(

                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 2, color: AppColors.whiteTemp),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(children: [


                              SizedBox(height: 20,),

                              Row(

                                children: [
SizedBox(width: 30,),


                                InkWell(
                                  onTap: () {

                                 setState(() {
                                   selectCityCommaSaparated='In City';
                                 });
                                  },
                                  child: Row(
                                    children: [
                                      Text('In City',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                                      SizedBox(width: 10,),


                                      Container(height: 25,

                                      width: 25,

                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),

border: Border.all(color: AppColors.primary,width: 1),

                                        ),


                                        child: Center(child:

                                        selectCityCommaSaparated=='In City'?
                                        Icon(Icons.check,color: AppColors.primary,):SizedBox()),
                                      )
                                    ],
                                  ),
                                ),


                                Spacer(),

                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectCityCommaSaparated='Out City';
                                    });

                                  },
                                  child: Row(
                                    children: [




                                      Text('Out City',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                                      SizedBox(width: 10,),


                                      Container(height: 25,

                                        width: 25,

                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),

                                          border: Border.all(color: AppColors.primary,width: 1),

                                        ),


                                        child: Center(child:

                                        selectCityCommaSaparated=='Out City'?
                                        Icon(Icons.check,color: AppColors.primary,):SizedBox()),
                                      )
                                    ],
                                  ),
                                ),

                                  SizedBox(width: 30,),
                              ],),

SizedBox(height: 20,),

                              Row(

                                children: [
                                  SizedBox(width: 17,),


                                  InkWell(
                                    onTap: () {

                                      setState(() {
                                        selectCityCommaSaparated='One Way';
                                      });


                                    },
                                    child: Row(
                                      children: [
                                        Text('One Way',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                                        SizedBox(width: 10,),


                                        Container(height: 25,

                                          width: 25,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),

                                            border: Border.all(color: AppColors.primary,width: 1),

                                          ),

                                          child: Center(child:

                                          selectCityCommaSaparated=='One Way'?
                                          Icon(Icons.check,color: AppColors.primary,):SizedBox()),
                                        )
                                      ],
                                    ),
                                  ),


                                  Spacer(),

                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectCityCommaSaparated='Two Way';
                                      });


                                    },
                                    child: Row(
                                      children: [
                                        Text('Two Way',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                                        SizedBox(width: 10,),


                                        Container(height: 25,

                                          width: 25,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),

                                            border: Border.all(color: AppColors.primary,width: 1),

                                          ),

                                          child: Center(child:

                                          selectCityCommaSaparated=='Two Way'?
                                          Icon(Icons.check,color: AppColors.primary,):SizedBox()),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 30,),
                                ],),
SizedBox(height: 20,),

                            ],),
                          )
                        ),

                    SizedBox(height: 20,),

                    Row(children: [


                      Text('Date Selection',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                    ],),



                    SizedBox(height: 10,),


                    Container(
height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 2, color: AppColors.whiteTemp),
                      ),
                      child:


                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(children: [

                            Text('Date',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),

                            SizedBox(width: 3,),


                            InkWell(
                              onTap: () {


                                sselectDate(context,"from");
                              },
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),border: Border.all(width: 1,color: AppColors.faqanswerColor)),
                                height: 35,
                              width: 130,


                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [
fromdate!=null?
                                  Text('${fromdate}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),):
                                  Text('Select Start Date',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
SizedBox(width: 10,),
                                  Icon(Icons.calendar_month,color: AppColors.primary,)

                                ]),
                              ),

                              ),
                            ),
                            Spacer(),

                            Text('To',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),

              Spacer(),

                            InkWell(

                              onTap: () {

                                sselectDate(context,"to");
                              },
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),border: Border.all(width: 1,color: AppColors.faqanswerColor)),
                                height: 35,
                                width: 130,


                                child: Padding(
                                  padding: const EdgeInsets.all(3),
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                      children: [
todate!=null?
                                        Text('${todate}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),):
                                        Text('Select End Date',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                                        SizedBox(width: 10,),
                                        Icon(Icons.calendar_month,color: AppColors.primary,)

                                      ]),
                                ),

                              ),
                            ),
                          ],),
                        )
                    ),

                        SizedBox(height: 20,),

                        Row(


                          children: [


                          Text('Duration Selection',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),


                        ],),



                        SizedBox(height: 10,),


                        Container(

                          height: 60,
                          child: ListView.builder(
itemCount: durationList.length??0,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: AlwaysScrollableScrollPhysics(),

                            itemBuilder: (context, index) {

                            return


                              InkWell(
                                onTap: () {

                                  setState(() {
                                    enterDurationController.clear();
                                    selecthour=durationList[index].title.toString();
                                    dayByPrice=durationList[index].price;
                                  });

                                },
                                child:


                                Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Container(

                                    child: Row(
                                      children: [
                                        Text('${durationList[index].title}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                                        SizedBox(width: 2,),


                                        Container(height: 25,

                                          width: 25,

                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),

                                            border: Border.all(color: AppColors.primary,width: 1),

                                          ),

                                          child: Center(child:

                                          selecthour==durationList[index].title.toString()?
                                          Icon(Icons.check,color: AppColors.primary,):SizedBox()),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );



                          },),
                        ),


                        SizedBox(height: 20,),

                        Row(children: [


                          Text('Enter How Many ${selecthour??""}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                        ],),



                        SizedBox(height: 10,),




                        TextFormField(
                          maxLength: 2,
keyboardType: TextInputType.number,
                          onChanged: (value) {

                            totalamount=int.parse(value.toString())*int.parse(dayByPrice.toString());
                            setState(() {

                            });

                          },
                          controller: enterDurationController,
                          decoration: InputDecoration(
counterText: "",
                            prefixIcon: const Icon(
                              Icons.view_day_outlined,
                              color: AppColors.tabtextColor,
                            ),

                            hintText: 'Enter How Many ${selecthour??""}',

                            hintStyle: TextStyle(fontSize: 15),
                            contentPadding: const EdgeInsets.symmetric(vertical: 5),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                BorderSide(color: AppColors.whiteTemp, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                const BorderSide(color: AppColors.whiteTemp, width: 2)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide:
                                BorderSide(color: AppColors.whiteTemp, width: 2)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.whiteTemp),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),


                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter How Many ${selecthour??""}';
                            }
                            return null; // Return null if the input is valid
                          },


                        ),




                        SizedBox(height: 20,),

                        Row(children: [


                          Text('Pricing Information',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                        ],),
                        Row(children: [
                          Text('Calculate the pricing on the basis of',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                        ],),



                        SizedBox(height: 10,),

                        Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 2, color: AppColors.whiteTemp),
                            ),
                            child:


                            Padding(
                              padding: const EdgeInsets.all(8),
                              child:

                              Row(children: [


                                Text('Per ${selecthour??""} Price',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                                Spacer(),
                                Text('RS ${dayByPrice??"0"}/-',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.primary),),
                              ],),
                            )
                        ),

                        SizedBox(height: 20,),

                        // Row(children: [
                        //   Text('Rental Charges For Each Vehicle',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                        // ],),

                        Row(children: [
                          Text('Total Booking Amount',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.tabtextColor),),
                          Spacer(),
                          Text('RS ${totalamount??"0"}/-',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: AppColors.primary),),
                        ],),














                        SizedBox(height: 100,),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )

      ),
    );
  }


  CarTypeModel? carTypeModel;


  Future<void> getcarType(String carvehiclecatIdd) async {



    var param ={

      'type': '${carvehiclecatIdd}'

    };

    apiBaseHelper.postAPICall(getvehicletypeurl,param).then((getDta){
      bool error=getDta['status'];
      String msg =getDta['message'];

      if(error==true){
        setState(() {

          carTypeModel=CarTypeModel.fromJson(getDta);
          setState(() {
            isLoading=false;
          });
        });

      }
      else{
        customSnackbar(context, msg.toString());

        setState(() {
          isLoading=false;
        });
      }


    },);
  }

  CityModel?cityModel;
  Future<void> getCity() async {

    var headers = {
      'Cookie': 'ci_session=ef4cdcf5fae671b774c89a042e7086c10cd490e0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}apigetCity'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result=
   await response.stream.bytesToString();
      var finalResult=jsonDecode(result);
      if(finalResult['status']==true){

        setState(() {
          cityModel=CityModel.fromJson(finalResult);
        });

      }
      else{
        customSnackbar(context,finalResult['message'].toString() );
      }
    }
    else {
      print(response.reasonPhrase);
    }

  }

  List<DurationModelList> durationList=[];
  Future<void> getDurationDayList() async {

    var headers = {
      'Cookie': 'ci_session=ef4cdcf5fae671b774c89a042e7086c10cd490e0'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}apiVehicleDuration_Amount'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result=
      await response.stream.bytesToString();
      var finalResult=jsonDecode(result);
      if(finalResult['status']==true){

        setState(() {
          durationList=DurationDayModel.fromJson(finalResult).data??[];
        });


      }
      else{

        customSnackbar(context,finalResult['message'].toString() );

      }
    }
    else {


      print(response.reasonPhrase);
    }

  }

  bool isLoading=false;
var userId;
  Future<void> driverbooking() async {


    setState(() {
      isLoading=true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId =prefs.getString('userId');
    var param ={

      'user_id': userId.toString(),
      'vehical_type': selectVehiclecatId.toString(),
      'vehical': selectCartypeId.toString(),
      'city':selectCityId.toString(),
      'city_type': selectCityCommaSaparated.toString(),
      'start_date': fromdate.toString(),
      'end_date': todate.toString(),
      'duration': selecthour.toString(),
      'duration_time': enterDurationController.text.toString(),
      'total_amount': totalamount.toString(),
    'latitude':lat.toString(),
    'longitude':long.toString(),

    };

    apiBaseHelper.postAPICall(bookindurl,param).then((getDta){

      bool error =getDta['status'];
      String msg =getDta['message'];
      if(error==true){
        setState(() {

          customSnackbar(context,msg.toString() );
          setState(() {
            isLoading=false;
          });
        });
Navigator.pop(context);
      }
      else{
        customSnackbar(context,msg.toString() );

        setState(() {
          isLoading=false;
        });
      }


    },);
  }


var selectCityCommaSaparated;
String ?selecthour;
String ?dayByPrice;
  dynamic _selectecity;
  String? _selectvehiclecat;

  dynamic selectcartypr;
  List<String> selectvehicle_List = ['Manual','Automatic'];

  String? selectVehiclecatId;
  String? selectCartypeId;
  String? selectCityId;

  final _formKey = GlobalKey<FormState>();


  DateTime selectedDate = DateTime.now();
  Future<void> sselectDate(BuildContext context,String forrr) async {

    final DateTime? picked = await showDatePicker(

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)

      selectedDate = picked;

    if(forrr=="from") {
      fromdate =
          DateFormat('yyyy-MM-dd').format(selectedDate);
      print("==================${fromdate}");
      setState(() {

      });
    }else{
      todate =
          DateFormat('yyyy-MM-dd').format(selectedDate);
      print("==================${todate}");
      setState(() {

      });
    }


    setState(() {

    });
  }


int? totalamount;
  var fromdate;
  var todate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCurrentLocation();
    getCity();
    getDurationDayList();
  }
TextEditingController enterDurationController=TextEditingController();


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
      print("LOCATION===" +currentLocation.toString());
      //updateDriverLocation();

    } else if (status.isPermanentlyDenied) {


      openAppSettings();
    }



  }
}
