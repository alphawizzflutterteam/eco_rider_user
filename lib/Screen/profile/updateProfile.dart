import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eco_rider_user/Api%20services/api_services/apiConstants.dart';
import 'package:eco_rider_user/Screen/dashboard/dashboardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/loadingwidget.dart';
import '../../Widget/custom_app_button.dart';
import '../auth/custumScreen.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserdata();
  }
  @override
  Widget build(BuildContext context) {
    return   SafeArea(
      child: Scaffold(
        bottomSheet:   Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(

                onTap: () {


                  //
                  // if(_selectvehiclecat==null){
                  //   customSnackbar(context,"Please Select Vehicle Category".toString() );
                  //   // getNotifivcation();
                  //
                  // }
                  // else if(selectcartypr==null){
                  //   customSnackbar(context,"Please Select Car Type".toString() );
                  //
                  // }
                  // else if(_selectecity==null){
                  //   customSnackbar(context,"Please Select City".toString() );
                  //
                  // }
                  // else if(selectCityCommaSaparated==null){
                  //   customSnackbar(context,"Please Select In City/Out City".toString() );
                  //
                  // }
                  //
                  // else if(fromdate==null){
                  //   customSnackbar(context,"Please Select From Date".toString() );
                  //
                  // }
                  // else if(todate==null){
                  //   customSnackbar(context,"Please Select To Date".toString() );
                  //
                  // }
                  // else if(selecthour==null){
                  //   customSnackbar(context,"Please Select Duration Selection".toString() );
                  //
                  // }
                  //
                  // else if(enterDurationController.text.isEmpty){
                  //   customSnackbar(context,"Please Enter How Many Duration".toString() );
                  //
                  // }else{
                  //   driverbooking();
                  //
                  // }

                  updateProfile();

                },
                child:
                !isLoading?
                CustomButton(textt: "Update Profile",):

                LoadingWidget(context),
              ),
            ],
          ),
        ),
        body:

        Stack(
          children: [

            customdecorationFORScr(context,"Update Profile"),

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
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Column(
                    children: [


                      SizedBox(height: 20,),

                      userImg!=null?
                      InkWell(
                        onTap: () {


                          showAlertDialog(context,'profile');
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.primary,
                          radius: 55,child: CircleAvatar(

                          backgroundImage:


                          FileImage(File(userImg!.path)),
                          radius: 50,child: Center(child: Icon(Icons.camera_alt_outlined,color: Colors.black,),),),),
                      ):

InkWell(
  onTap: () {

    showAlertDialog(context,'profile');


  },
  child:   CircleAvatar(
    backgroundColor: AppColors.primary,
    radius: 55,child: CircleAvatar(

      backgroundImage:
      NetworkImage('${imagepath.toString()}'),
      radius: 50,child: Center(child: Icon(Icons.camera_alt_outlined,color: Colors.black,),),),

  ),
),
                      SizedBox(height: 20,),
                      TextFormField(

                        controller: ownernameController,
                        decoration: InputDecoration(

                          prefixIcon: const Icon(
                            Icons.person,
                            color: AppColors.tabtextColor,
                          ),

                          hintText: 'Owner Name',

                          hintStyle: TextStyle(fontSize: 13),
                          contentPadding: const EdgeInsets.symmetric(vertical: 5),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                              BorderSide(color: AppColors.whiteTemp, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                              const BorderSide(color: AppColors.whiteTemp, width: 2)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                              BorderSide(color: AppColors.whiteTemp, width: 2)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.whiteTemp),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),


                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Owner Name';
                          }
                          return null; // Return null if the input is valid
                        },


                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: emailC,
                        decoration: InputDecoration(

                          prefixIcon: const Icon(
                            Icons.email,
                            color: AppColors.tabtextColor,
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(fontSize: 13),
                          contentPadding: const EdgeInsets.symmetric(vertical: 5),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                              BorderSide(color: AppColors.whiteTemp, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                              const BorderSide(color: AppColors.whiteTemp, width: 2)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                              BorderSide(color: AppColors.whiteTemp, width: 2)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.whiteTemp),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Email';
                          }
                          else if (!value.contains('@')||!value.contains(".com")) {
                            return 'Please Enter Valid Email';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),

                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        maxLength: 10,
                        controller: mobilecontroller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: "",
                          prefixIcon: const Icon(
                            Icons.call,
                            color: AppColors.tabtextColor,
                          ),
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(fontSize: 13),
                          contentPadding: const EdgeInsets.symmetric(vertical: 5),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                              BorderSide(color: AppColors.whiteTemp, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                              const BorderSide(color: AppColors.whiteTemp, width: 2)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                              BorderSide(color: AppColors.whiteTemp, width: 2)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.whiteTemp),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Mobile Number';
                          }
                          else if (value.length<10) {
                            return 'Please Enter Valid Mobile Number';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),



                      const SizedBox(
                        height: 5,
                      ),




                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width/2),
                          border: Border.all(
                              width: 2, color: AppColors.whiteTemp),
                        ),
                        child: Container(


                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Icon(Icons.map,color: AppColors.tabtextColor,),
                              DropdownButtonHideUnderline(

                                child:

                                DropdownButton2(


                                  hint: SizedBox(
                                    width: MediaQuery.of(context).size.width/1.7,
                                    child: Text(
                                      'Select Gender',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style:
                                      TextStyle(color: AppColors.tabtextColor,fontSize: 13),
                                    ),
                                  ), // Not necessary for Option 1
                                  value: _selectvehiclecat,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectvehiclecat = newValue.toString();


                                    });
                                  },
                                  items: selectvehicle_List.map((location) {
                                    return DropdownMenuItem(
                                      child: new Text(location),
                                      value: location,
                                    );
                                  }).toList(),
                                ),


                              ),
                            ],
                          ),
                        ),
                      ),



                      SizedBox(height: 5,),





                          ]
                      ),
                )


              ),
            )
          ],
        ),
      ),
    );
  }
  bool isLoading=false;
  var getdataa;


  Future<void> getprivecy() async {


    setState(() {
      isLoading=true;
    });

    var headers = {
      'Cookie': 'ci_session=6c0fcaf4599389035573c1a4171e5a8fb5c97331'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}apiprivacy_policy'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result=
      await response.stream.bytesToString();
      var finalresult= jsonDecode(result);

      if(finalresult['status']==true){

        setState(() {
          getdataa=finalresult['data'][0]['description'];
          isLoading=false;
        });
      }
      else{

        setState(() {
          isLoading=false;
        });

      }
    }
    else {
      print(response.reasonPhrase);
    }
  }
  var imagepath;
  String? _selectvehiclecat;
  List selectvehicle_List=['Male','Female'];
  final emailC = TextEditingController();
  TextEditingController ownernameController=TextEditingController();
  TextEditingController mobilecontroller =TextEditingController();
  getuserdata() async {
    setState(() {
      isLoading=true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var  userId =prefs.getString('userId');

    var param ={

      'user_id': userId.toString(),

    };

    apiBaseHelper.postAPICall(getprofileurl,param).then((getDta){

      bool error =getDta['status'];
      String msg =getDta['message'];
      if(error==true){
        print("===my technic==== api===${getDta['data']['gender'].toString()}===============");
        String getGender = "${getDta['data']['gender'].toString()}";
        String capitalizedA = "${getGender[0].toUpperCase()}${getGender.substring(1)}";

        setState(() {
          print("===my technic=====convert==${capitalizedA}===============");
          _selectvehiclecat=capitalizedA.toString();
          ownernameController.text=getDta['data']['username'].toString();
          emailC.text=getDta['data']['email'].toString();
          mobilecontroller.text=getDta['data']['mobile'].toString();
          imagepath=getDta['data']['image_path'].toString();


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
  File? userImg;

  Future<void> pickImage(ImageSource source, String type) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxHeight: 100,
      maxWidth: 100,
      imageQuality: 50, // You can adjust the image quality here
    );

    if (pickedFile != null) {
      setState(() {
        if (type == 'profile') {
          userImg = File(pickedFile.path);
          print('============${userImg!.path}');

        }
      });
    }
  }

  showAlertDialog(BuildContext context, String type) {
    AlertDialog alert = AlertDialog(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 25),
          child: Container(
            height: 250,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 5,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Select Any One Option',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        print(type);
                        Navigator.of(context).pop();
                        pickImage(ImageSource.gallery, type);
                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(child: Text('Select From Gallery')),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        print(type);
                        Navigator.of(context).pop();
                        pickImage(ImageSource.camera, type);

                      },
                      child: Card(
                        elevation: 5,
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(child: Text('Select From Camera')),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Future<void> updateProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var  userId =prefs.getString('userId');
    var headers = {
      'Cookie': 'ci_session=954d3e2ef52b8cdb356371983e0cc1c32abf1538'
    };
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}update_userprofile'));
    request.fields.addAll({
      'user_id':userId.toString(),
      'user_fullname': ownernameController.text.toString(),
      'user_email': emailC.text.toString(),
      'gender': _selectvehiclecat.toString(),
    });
print(request.url);
print(request.fields);
    if(userImg!=null) {
      request.files.add(await http.MultipartFile.fromPath(
          'user_image', userImg!.path
      ));

      print(request.files);
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result=
  await response.stream.bytesToString();
      var finalresult=jsonDecode(result);

      if(finalresult['status']==true){
Fluttertoast.showToast(msg: "${finalresult['message'].toString()}");

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard(),));

      }
    }
    else {
    print(response.reasonPhrase);
    }
  }
}
