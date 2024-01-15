import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/loadingwidget.dart';
import '../../Model/getDriverModel.dart';
import '../../Widget/custom_app_button.dart';
import '../auth/custumScreen.dart';

class DriverDetailsScr extends StatefulWidget {
  const DriverDetailsScr({Key? key}) : super(key: key);

  @override
  State<DriverDetailsScr> createState() => _DriverDetailsScrState();
}

class _DriverDetailsScrState extends State<DriverDetailsScr> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotifivcation();
  }
  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
          body:

          !isLoading?

          Stack(
            children: [

              customdecorationFORScr(context,"Driver Details"),

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

//                         const SizedBox(
//                           height: 20,
//                         ),
//
//                         Row(children: [
//
//                           Text('Driver Name',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                         ],),
//                         SizedBox(height: 10,),
//                         TextFormField(
// readOnly: true,
//                           controller: driverController,
//                           decoration: InputDecoration(
//
//
//                             hintText: '  Driver Name',
//
//                             hintStyle: TextStyle(fontSize: 13),
//                             contentPadding: const EdgeInsets.symmetric(vertical: 5),
//                             focusedErrorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 const BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: AppColors.whiteTemp),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//
//
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please Enter Owner Name';
//                             }
//                             return null; // Return null if the input is valid
//                           },
//
//
//                         ),
//
//                         const SizedBox(
//                           height: 20,
//                         ),
//
//                         Row(children: [
//
//                           Text('Driver Id',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                         ],),
//                         SizedBox(height: 10,),
//                         TextFormField(
// readOnly: true,
//                           controller: driverIdController,
//                           decoration: InputDecoration(
//
//
//                             hintText: '  Driver Id',
//
//                             hintStyle: TextStyle(fontSize: 13),
//                             contentPadding: const EdgeInsets.symmetric(vertical: 5),
//                             focusedErrorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 const BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: AppColors.whiteTemp),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//
//
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please Enter Owner Name';
//                             }
//                             return null; // Return null if the input is valid
//                           },
//
//
//                         ),
//
//                         const SizedBox(
//                           height: 20,
//                         ),
//
//                         Row(children: [
//
//                           Text('Mobile Number',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                         ],),
//                         SizedBox(height: 10,),
//                         TextFormField(
// readOnly: true,
//                           controller: mobileNoController,
//                           decoration: InputDecoration(
//
//
//                             hintText: '  Mobile Number',
//
//                             hintStyle: TextStyle(fontSize: 13),
//                             contentPadding: const EdgeInsets.symmetric(vertical: 5),
//                             focusedErrorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 const BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: AppColors.whiteTemp),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//
//
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please Enter Owner Name';
//                             }
//                             return null; // Return null if the input is valid
//                           },
//
//
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//
//                         Row(children: [
//
//                           Text('Email',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                         ],),
//                         SizedBox(height: 10,),
//                         TextFormField(
// readOnly: true,
//                           controller: emailIdController,
//                           decoration: InputDecoration(
//
//
//                             hintText: '  Email',
//
//                             hintStyle: TextStyle(fontSize: 13),
//                             contentPadding: const EdgeInsets.symmetric(vertical: 5),
//                             focusedErrorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 const BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: AppColors.whiteTemp),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//
//
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please Enter Owner Name';
//                             }
//                             return null; // Return null if the input is valid
//                           },
//
//
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//
//                         Row(children: [
//
//                           Text('Report Time',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                         ],),
//                         SizedBox(height: 10,),
//                         TextFormField(
// readOnly: true,
//                           controller: repostTimeController,
//                           decoration: InputDecoration(
//
//
//
//                             hintText: '  Report Time',
//
//                             hintStyle: TextStyle(fontSize: 13),
//                             contentPadding: const EdgeInsets.symmetric(vertical: 5),
//                             focusedErrorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 const BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: AppColors.whiteTemp),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//
//
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please Enter Owner Name';
//                             }
//                             return null; // Return null if the input is valid
//                           },
//
//
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//
//                         Row(children: [
//
//                           Text('Pickup',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                         ],),
//                         SizedBox(height: 10,),
//                         TextFormField(
// readOnly: true,
//                           controller: PicController,
//                           decoration: InputDecoration(
//
//
//
//                             hintText: '  Pickup',
//
//                             hintStyle: TextStyle(fontSize: 13),
//                             contentPadding: const EdgeInsets.symmetric(vertical: 5),
//                             focusedErrorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 const BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: AppColors.whiteTemp),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//
//
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please Enter Owner Name';
//                             }
//                             return null; // Return null if the input is valid
//                           },
//
//
//                         ),
//
//                         const SizedBox(
//                           height: 20,
//                         ),
//
//                         Row(children: [
//
//                           Text('Drop',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
//                         ],),
//                         SizedBox(height: 10,),
//                         TextFormField(
// readOnly: true,
//                           controller: dropController,
//                           decoration: InputDecoration(
//
//
//
//                             hintText: '  Drop',
//
//                             hintStyle: TextStyle(fontSize: 13),
//                             contentPadding: const EdgeInsets.symmetric(vertical: 5),
//                             focusedErrorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 const BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(25),
//                                 borderSide:
//                                 BorderSide(color: AppColors.whiteTemp, width: 2)),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: AppColors.whiteTemp),
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                           ),
//
//
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'Please Enter Owner Name';
//                             }
//                             return null; // Return null if the input is valid
//                           },
//
//
//                         ),
//
//                         SizedBox(height: 30,)

                        const SizedBox(
                          height: 20,
                        ),

                        Row(
                          children: [
                            Text('Drivers',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),


                        DriverList.isEmpty?Container(

                          height: MediaQuery.of(context).size.height/1.6,
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: Text('Drivers Not Found',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),),
                        ):

                        ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: DriverList.length,
                        itemBuilder: (context, index) {
return
  Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Container(
height: 200,


      child:


    Padding(
      padding: const EdgeInsets.all(15),
      child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [



        Row(
          children: [

            Text('Booking Id - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
            Spacer(),

            Text('${DriverList[index].bookingId}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),

          ],
        ),                              SizedBox(height: 5,),

        Row(
          children: [
            Text('Driver Name - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
            Spacer(),

            Text('${DriverList[index].userName}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),

          ],
        ),                              SizedBox(height: 5,),

        Row(
          children: [
            Text('Email - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
            Spacer(),

            Text('${DriverList[index].email}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
          ],
        ),
        SizedBox(height: 5,),

        Row(
          children: [
            Text('Mobile Number - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
            Spacer(),

            Text('${DriverList[index].phone}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
          ],
        ),

        SizedBox(height: 5,),

        Row(
          children: [
            Text('Gender - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
            Spacer(),

            Text('${DriverList[index].gender}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
          ],
        ),
            SizedBox(height: 5,),

            Row(
              children: [
                Text('Reporting Date/Time - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                Spacer(),

                Text('${DriverList[index].reportingTime?.day}-${DriverList[index].reportingTime?.month}-${DriverList[index].reportingTime?.year}/${DriverList[index].reportingTime?.hour}:${DriverList[index].reportingTime?.minute}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
              ],
            ),

            SizedBox(height: 5,),

            Row(
              children: [
                Text('OTP - ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
                Spacer(),

                Text('${DriverList[index].bookingotp}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
              ],
            ),
      ]),
    )
      ,),

  );





                        },)
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
              :

          Container(

            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(child: LoadingWidget2(context),),
          ),

      ),
    );
  }


  bool isLoading=false;
List<GetDriverListModel> DriverList=[];
  Future<void> getNotifivcation() async {
    setState(() {
      isLoading=true;
    });



    final SharedPreferences prefs = await SharedPreferences.getInstance();
   var userId =prefs.getString('userId');
    var param ={

      'user_id': '${userId.toString()}'

    };

    apiBaseHelper.postAPICall(getDriverUrl,param).then((getDta){

      if(getDta['status']==true){
        setState(() {

          DriverList=GetDriverModel.fromJson(getDta).data??[];
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
  // final _formKey = GlobalKey<FormState>();
  //
  // TextEditingController driverController=TextEditingController();
  // TextEditingController driverIdController=TextEditingController();
  // TextEditingController mobileNoController=TextEditingController();
  // TextEditingController emailIdController=TextEditingController();
  // TextEditingController repostTimeController=TextEditingController();
  // TextEditingController PicController=TextEditingController();
  // TextEditingController dropController=TextEditingController();


}
