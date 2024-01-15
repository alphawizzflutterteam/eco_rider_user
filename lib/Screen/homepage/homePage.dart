import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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


  floatingActionButton:
  FloatingActionButton(

    backgroundColor: AppColors.primary,    onPressed: () {

Navigator.push(context, MaterialPageRoute(builder: (context) => bookingScr(),));
  },
  child: Icon(Icons.add),
  ),
  body:



RefreshIndicator(
  color: AppColors.primary,
  onRefresh: () async{


    getBooking();

  },
  child:
  !isLoading?

  ListView.builder(
    itemCount: 1,
    itemBuilder: (context, index) {
      return





        Stack(
          children: [

            customdwithoutBackScr(context,"Booking management"),

            Container(
              margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),

              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30),),
              ),

              child: SingleChildScrollView(
                child: Column(children: [


                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      Text('Current bookings',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),


                  bookingList.isEmpty?Container(

                    height: MediaQuery.of(context).size.height/1.6,
                    width: MediaQuery.of(context).size.width,
                    child: Center(child: Text('Booking Not Found',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                  ):


                  Container(
                    height: MediaQuery.of(context).size.height/1.6,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: bookingList.length??0,
                      itemBuilder: (context, index) {
                        return

                          Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            height: 300,
                            child:


                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [


                              Text('Booking Confirmation',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: AppColors.primary),),
Divider(),

                              Row(
                                children: [

                                  Text('Booking Id - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  Spacer(),

                                  Text('${bookingList[index].bookingId}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                ],
                              ),                              SizedBox(height: 5,),

                              Row(
                                children: [
                                  Text('Pickup - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  Spacer(),

                                  Text('${bookingList[index].cityName}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),

                                ],
                              ),                              SizedBox(height: 5,),

                              Row(
                                children: [
                                  Text('Booking Type - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  Spacer(),

                                  Text('${bookingList[index].area}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                ],
                              ),
                              SizedBox(height: 5,),

                              Row(
                                children: [
                                  Text('Vehicle Type - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  Spacer(),

                                  Text('${bookingList[index].carModel}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                ],
                              ),

                              SizedBox(height: 5,),

                              Row(
                                children: [
                                  Text('Duration - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  Spacer(),
                                  Text('${bookingList[index].bookingTypes}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                ],
                              ),
                              SizedBox(height: 5,),

                              Row(
                                children: [
                                  Text('Status - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                  Spacer(),

                                  Text('${bookingList[index].status}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                ],
                              ),

                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      Text('How Many ${bookingList[index].bookingTypes} - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                      Spacer(),

                                      Text('${bookingList[index].bookingTime}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                              SizedBox(height: 5,),

                                  Row(
                                    children: [
                                      Text('Total Amount - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                      Spacer(),

                                      Text('RS ${bookingList[index].amount}/-',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                                    ],
                                  ),

                            ]),
                          )
                            ,),

                        );


                      },),
                  )
                ],
                ),
              ),
            ),


          ],

        );


    },):



    Container(

    height: MediaQuery.of(context).size.height,
  width: MediaQuery.of(context).size.width,
  child: Center(child: LoadingWidget2(context),),
),

),


);



  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooking();
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


  }


