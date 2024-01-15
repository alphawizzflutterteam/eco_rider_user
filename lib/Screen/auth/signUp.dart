import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eco_rider_user/Screen/auth/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/loadingwidget.dart';
import '../../Widget/custom_app_button.dart';
import '../../Helper/customeTost.dart';
import '../dashboard/dashboardScreen.dart';
import 'custumScreen.dart';
import 'forgetPassword.dart';
class SignUpScr extends StatefulWidget {
  const SignUpScr({super.key});

  @override
  State<SignUpScr> createState() => _SignUpScrState();
}

class _SignUpScrState extends State<SignUpScr> {

  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [


            customAuthDegine(context,"assets/images/sign up.png"),


            Container(
              margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.36),
              height: MediaQuery.of(context).size.height * 0.69,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30),),
              ),
              child:



              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 13,),
                    Row(
                      children: [
                        Text('Sign Up',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(height: 13,),
                    Text("There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",style: TextStyle(fontSize: 12,),),

                    SizedBox(
                      height: 25,
                    ),


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



                    TextFormField(

                      controller: registrationNoController,
                      decoration: InputDecoration(

                        prefixIcon: const Icon(
                          Icons.car_crash_outlined,
                          color: AppColors.tabtextColor,
                        ),

                        hintText: 'Registration No',

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
                          return 'Please Enter Registration No';
                        }
                        return null; // Return null if the input is valid
                      },


                    ),
                    SizedBox(height: 5,),


                    TextFormField(
                      onTap: () {

                        showPlacePicker();
                      },
readOnly: true,
                      controller: addressController,
                      decoration: InputDecoration(

                        prefixIcon: const Icon(
                          Icons.location_on,
                          color: AppColors.tabtextColor,
                        ),

                        hintText: 'Address',

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
                          return 'Please Enter Address';
                        }
                        return null; // Return null if the input is valid
                      },


                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      obscureText: _obscureText,
                      controller: passwordC,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,color: AppColors.primary,size:16 ,),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.tabtextColor,
                        ),

                        hintText: 'Password',

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
                          return 'Please Enter Password';
                        }
                        return null; // Return null if the input is valid
                      },


                    ),


                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      obscureText: _obscureText,
                      controller: confirmPasswordC,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,color: AppColors.primary,size:16 ,),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.tabtextColor,
                        ),

                        hintText: 'Confirm Password',

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
                          return 'Please Enter Password';
                        }
                        else if (value.toString()!=passwordC.text.toString()) {
                          return 'Confirm Password is Not Match';
                        }
                        return null; // Return null if the input is valid
                      },


                    ),




                    const SizedBox(
                      height: 50,
                    ),



                    InkWell(

                      onTap: () {
                        if(_formKey.currentState!.validate()){
                          signUp();
                          //  Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(),));

                        }
                      },
                      child:
                      !isLoading?
                      CustomButton(textt: "Sign Up",):

                      LoadingWidget(context),
                    ),
                    SizedBox(height: 50,),

                    InkWell(
                      onTap: () {

                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                          Text(" Log In",style: TextStyle(color: AppColors.primary,fontSize: 15,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),

                    SizedBox(height: 100,)

                  ],
                ),
              ),



            )
          ],
        ),
      ),
    );
  }

  TextEditingController ownernameController=TextEditingController();
  TextEditingController registrationNoController=TextEditingController();
  TextEditingController addressController=TextEditingController();

  void signUp(){
    setState(() {
      isLoading=true;
    });
    var param=
    {
    'user_fullname': ownernameController.text,
    'user_email':emailC.text,
    'user_phone': mobilecontroller.text,
    'gender': _selectvehiclecat.toString(),
    'address': addressController.text,
    'password': passwordC.text,
    'rc_number': registrationNoController.text,

    };
    apiBaseHelper.postAPICall(registrationurl, param).then((getData){
      bool error=getData['status'];
      String msg=getData['message'];

      if(error==true){


          customSnackbar(context,msg.toString());
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
          setState(() {
            isLoading=false;

        });

      }
      else{
        customSnackbar(context,msg.toString());
        setState(() {
          isLoading=false;
        });
      }
    });
  }

  TextEditingController mobilecontroller =TextEditingController();
  bool isLoading = false ;

  bool _obscureText = true;

  String? _selectvehiclecat;
  List selectvehicle_List=['Male','Female'];

  void showPlacePicker() async {
    LocationResult result = await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) =>
                PlacePicker(


                    "AIzaSyDPsdTq-a4AHYHSNvQsdAlZgWvRu11T9pM"))

    );

    // Check if the user picked a place
    if (result != null) {
      setState(() {
        addressController.text='${result.formattedAddress}';
        print(addressController.text);
      });
      setState(() {
        lat="${result.latLng!.latitude}";
        print(lat);

        lang="${result.latLng!.longitude}";
        print(lang);


      });
    }
  }
  var lat;
  var lang;
}