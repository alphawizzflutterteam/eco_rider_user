import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/loadingwidget.dart';
import '../../Model/allBookingModel.dart';
import '../auth/custumScreen.dart';
import '../driverbooking/driverbookingScr.dart';




class HomeScr extends StatefulWidget {
  const HomeScr({Key? key}) : super(key: key);

  @override
  State<HomeScr> createState() => _HomeScrState();
}

class _HomeScrState extends State<HomeScr> {
  @override
  Widget build(BuildContext context) {
    return


        Scaffold(

appBar:


PreferredSize(
  preferredSize: Size.fromHeight(80),child:

Container(



  height: 80,width: MediaQuery.of(context).size.width,decoration: BoxDecoration(gradient: LinearGradient(colors:

[AppColors.primary,AppColors.primary],

)),
  child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
    SizedBox(width: 20,),
    Text("Home",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: AppColors.whiteTemp),),
    SizedBox(width: 20,),

  ]),
)



  ,),
          body:
          SingleChildScrollView(
            child: Column(children: [

              Container(
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width,
                child:

                lat==null?

                    Center(child:
                    LoadingWidget2(context),):

                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target:LatLng(
                        double.parse(lat??""), double.parse(long??"")),
                    zoom: 13.5,
                  ),
                  markers: {
                    Marker(
                      visible: true,
                      draggable:true,
                      icon:BitmapDescriptor.defaultMarkerWithHue(90),
                      markerId:  MarkerId("currentLocation"),
                      position: LatLng(
                          double.parse(lat??""), double.parse(long??"")),
                    ),
                    //  Marker(
                    //   markerId: MarkerId("source"),
                    //   position: sourceLocation,
                    // ),
                    Marker(
                      markerId: MarkerId("destination"),
                      position: destination,
                    ),
                  },
                  polylines: {
                    Polyline(
                      visible:true,
                      jointType: JointType.mitered,
                      polylineId: PolylineId("route"),
                      points: polylineCoordinates,
                      color:  Colors.blue,
                      width: 6,
                    ),
                  },
                  onMapCreated: (mapController) {
                    _controller.complete(mapController);
                  },
                ),
              ),

              SizedBox(height: 20,),


              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: TextFormField(
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
labelText:'Pickup Location' ,
                    hintStyle: TextStyle(fontSize: 13),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                        BorderSide(color: AppColors.primary, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                        const BorderSide(color: AppColors.primary, width: 2)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                        BorderSide(color: AppColors.primary, width: 2)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
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
              ),
              SizedBox(height: 20,),


              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: TextFormField(
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                        BorderSide(color: AppColors.primary, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                        const BorderSide(color: AppColors.primary, width: 2)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                        BorderSide(color: AppColors.primary, width: 2)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
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
              ),



            ]),
          )

          ,);
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
TextEditingController pickupLocationcontroller =TextEditingController();
TextEditingController droplocationcontroller =TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCurrentLocation();
  }


  bool isLoading=false;


  List<BookingModelList> bookingList =[];
  Future<void> getBooking() async {
    setState(() {
      isLoading=true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var  userId =prefs.getString('userId');

    var param ={

      'user_id': userId.toString(),

    };

    apiBaseHelper.postAPICall(getbookingurl,param).then((getDta){

      bool error =getDta['status'];
      String msg =getDta['message'];
      if(error==true){
        setState(() {
          bookingList= BookingModel.fromJson(getDta).data??[];

          setState(() {
            isLoading=false;
          });
        });
      }
      else{

        setState(() {
          isLoading=false;
        });
      }


    },);


  }

  String? lat;
  String? long;




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
            lat = currentLocation?.latitude.toString();
            long = currentLocation?.longitude.toString();

           destination = LatLng(double.parse(lat??""), double.parse(long??""));


          });
      });
      print("LOCATION===" +currentLocation.toString());
      //updateDriverLocation();

    } else if (status.isPermanentlyDenied) {


      openAppSettings();


    }



  }

  final Completer<GoogleMapController> _controller = Completer();
  List<LatLng> polylineCoordinates = [];
  static  LatLng destination=LatLng(double.parse("22.719568"), double.parse("75.857727"));


  void showPlacePicker(String val) async {
    LocationResult result = await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
                PlacePicker(


                    "AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM"))

    );

    // Check if the user picked a place
    if (result != null) {
      if(val=="pl"){

        setState(() {
          pickupLocationcontroller.text='${result.formattedAddress}';
          print(pickupLocationcontroller.text);
        });
      }else{
        setState(() {
          droplocationcontroller.text='${result.formattedAddress}';
          print(droplocationcontroller.text);

          Navigator.push(context, MaterialPageRoute(builder: (context) => bookingScr(pickupLocation: pickupLocationcontroller.text.toString(),droplocation: droplocationcontroller.text.toString()),));
        });

      }


    }
  }

}


