import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eco_rider_user/Screen/auth/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:place_picker/entities/location_result.dart';
// import 'package:place_picker/widgets/place_picker.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/customeTost.dart';
import '../../Helper/loadingwidget.dart';
import '../../Widget/custom_app_button.dart';
import 'custumScreen.dart';

class SignUpScr extends StatefulWidget {
  String? mobile;
  SignUpScr({super.key, this.mobile});

  @override
  State<SignUpScr> createState() => _SignUpScrState();
}

class _SignUpScrState extends State<SignUpScr> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool uploadadhar = false;
  File? licenseFrontImg;
  File? licenseBackImg;

  Future<void> pickImage(ImageSource source, String type) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxHeight: 100,
      maxWidth: 100,
      imageQuality: 50, // You can adjust the image quality here
    );

    if (pickedFile != null) {
      setState(() {
        if (type == 'aadharfront') {
          licenseFrontImg = File(pickedFile.path);
          print(licenseFrontImg);
        } else if (type == 'aadharback') {
          licenseBackImg = File(pickedFile.path);
          print(licenseBackImg);
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
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 5,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
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
                          child:
                              const Center(child: Text('Select From Gallery')),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mobilecontroller.text = widget.mobile.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            customAuthDegine(context, "assets/images/sign up.png"),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.36),
              height: MediaQuery.of(context).size.height * 0.69,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 13,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    const SizedBox(
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
                        hintStyle: const TextStyle(fontSize: 13),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: AppColors.whiteTemp, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: AppColors.whiteTemp, width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: AppColors.whiteTemp, width: 2)),
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
                    SizedBox(
                      height: 5,
                    ),
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
                            borderSide: BorderSide(
                                color: AppColors.whiteTemp, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: AppColors.whiteTemp, width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: AppColors.whiteTemp, width: 2)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.whiteTemp),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!value.contains('@') ||
                            !value.contains(".com")) {
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
                      readOnly: true,
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
                            borderSide: BorderSide(
                                color: AppColors.whiteTemp, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: AppColors.whiteTemp, width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                color: AppColors.whiteTemp, width: 2)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.whiteTemp),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Mobile Number';
                        } else if (value.length < 10) {
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
                        borderRadius: BorderRadius.circular(
                            MediaQuery.of(context).size.width / 2),
                        border:
                            Border.all(width: 2, color: AppColors.whiteTemp),
                      ),
                      child: Container(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.map,
                              color: AppColors.tabtextColor,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  child: const Text(
                                    'Select Gender',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: AppColors.tabtextColor,
                                        fontSize: 13),
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
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      controller: registrationNoController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.car_crash_outlined,
                          color: AppColors.tabtextColor,
                        ),
                        hintText: 'License No.',
                        hintStyle: const TextStyle(fontSize: 13),
                        contentPadding: const EdgeInsets.symmetric(vertical: 5),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: AppColors.whiteTemp, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: AppColors.whiteTemp, width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                                color: AppColors.whiteTemp, width: 2)),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.whiteTemp),
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
                    SizedBox(
                      height: 5,
                    ),
                    !uploadadhar
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                uploadadhar = true;
                              });
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 2),
                                border: Border.all(
                                    width: 2, color: AppColors.whiteTemp),
                              ),
                              child: Container(
                                child: const Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.add_card,
                                      color: AppColors.tabtextColor,
                                    ),
                                    SizedBox(
                                      width: 13,
                                    ),
                                    Text(
                                      'Upload Aadhar',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.faqanswerColor),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.file_upload_outlined,
                                      color: AppColors.tabtextColor,
                                      size: 22,
                                    ),
                                    SizedBox(
                                      width: 13,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  showAlertDialog(context, 'aadharfront');
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1,
                                            color: AppColors.tabtextColor),
                                      ),
                                      child: Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: licenseFrontImg == null
                                                ? Image.asset(
                                                    'assets/images/adhar.png',
                                                    height: 150.0,
                                                    width: 100.0,
                                                  )
                                                : Image.file(licenseFrontImg!)),
                                      ),
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.2,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: AppColors.primary),
                                          child: const Center(
                                            child: Text(
                                              'Upload License',
                                              style: TextStyle(
                                                  color: AppColors.tabtextColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        const Row(
                                          children: [
                                            Text(
                                              '  Front Image',
                                              style: TextStyle(
                                                  color: AppColors.tabtextColor,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  showAlertDialog(context, 'aadharback');
                                },
                                child: Row(
                                  children: [
                                    Container(
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1,
                                            color: AppColors.tabtextColor),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: licenseBackImg == null
                                              ? Image.asset(
                                                  'assets/images/adhar.png',
                                                  height: 150.0,
                                                  width: 100.0,
                                                )
                                              : Image.file(licenseBackImg!),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.2,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: AppColors.primary),
                                          child: const Center(
                                            child: Text(
                                              'Upload License',
                                              style: TextStyle(
                                                  color: AppColors.tabtextColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        const Row(
                                          children: [
                                            Text(
                                              '  Back Image',
                                              style: TextStyle(
                                                  color: AppColors.tabtextColor,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                    // TextFormField(
                    //   onTap: () {
                    //     showPlacePicker();
                    //   },
                    //   readOnly: true,
                    //   controller: addressController,
                    //   decoration: InputDecoration(
                    //     prefixIcon: const Icon(
                    //       Icons.location_on,
                    //       color: AppColors.tabtextColor,
                    //     ),
                    //     hintText: 'Address',
                    //     hintStyle: TextStyle(fontSize: 13),
                    //     contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    //     focusedErrorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //         borderSide: BorderSide(
                    //             color: AppColors.whiteTemp, width: 2)),
                    //     enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //         borderSide: const BorderSide(
                    //             color: AppColors.whiteTemp, width: 2)),
                    //     errorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //         borderSide: BorderSide(
                    //             color: AppColors.whiteTemp, width: 2)),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: AppColors.whiteTemp),
                    //       borderRadius: BorderRadius.circular(25),
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Please Enter Address';
                    //     }
                    //     return null; // Return null if the input is valid
                    //   },
                    // ),
                    // TextFormField(
                    //   controller: addressController,
                    //   decoration: InputDecoration(
                    //     prefixIcon: const Icon(
                    //       Icons.location_on,
                    //       color: AppColors.tabtextColor,
                    //     ),
                    //     hintText: 'Address',
                    //     hintStyle: TextStyle(fontSize: 13),
                    //     contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    //     focusedErrorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //         borderSide: BorderSide(
                    //             color: AppColors.whiteTemp, width: 2)),
                    //     enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //         borderSide: const BorderSide(
                    //             color: AppColors.whiteTemp, width: 2)),
                    //     errorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //         borderSide: BorderSide(
                    //             color: AppColors.whiteTemp, width: 2)),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: AppColors.whiteTemp),
                    //       borderRadius: BorderRadius.circular(25),
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Please Enter Address';
                    //     }
                    //     return null; // Return null if the input is valid
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // TextFormField(
                    //   obscureText: _obscureText,
                    //   controller: passwordC,
                    //   decoration: InputDecoration(
                    //     suffixIcon: IconButton(
                    //       icon: Icon(
                    //         _obscureText
                    //             ? Icons.visibility
                    //             : Icons.visibility_off,
                    //         color: AppColors.primary,
                    //         size: 16,
                    //       ),
                    //       onPressed: () {
                    //         setState(() {
                    //           _obscureText = !_obscureText;
                    //         });
                    //       },
                    //     ),
                    //     prefixIcon: const Icon(
                    //       Icons.lock,
                    //       color: AppColors.tabtextColor,
                    //     ),
                    //     hintText: 'Password',
                    //     hintStyle: TextStyle(fontSize: 13),
                    //     contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    //     focusedErrorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //         borderSide: BorderSide(
                    //             color: AppColors.whiteTemp, width: 2)),
                    //     enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //         borderSide: const BorderSide(
                    //             color: AppColors.whiteTemp, width: 2)),
                    //     errorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //         borderSide: BorderSide(
                    //             color: AppColors.whiteTemp, width: 2)),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: AppColors.whiteTemp),
                    //       borderRadius: BorderRadius.circular(25),
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Please Enter Password';
                    //     }
                    //     return null; // Return null if the input is valid
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // TextFormField(
                    //   obscureText: _obscureText,
                    //   controller: confirmPasswordC,
                    //   decoration: InputDecoration(
                    //     suffixIcon: IconButton(
                    //       icon: Icon(
                    //         _obscureText
                    //             ? Icons.visibility
                    //             : Icons.visibility_off,
                    //         color: AppColors.primary,
                    //         size: 16,
                    //       ),
                    //       onPressed: () {
                    //         setState(() {
                    //           _obscureText = !_obscureText;
                    //         });
                    //       },
                    //     ),
                    //     prefixIcon: const Icon(
                    //       Icons.lock,
                    //       color: AppColors.tabtextColor,
                    //     ),
                    //     hintText: 'Confirm Password',
                    //     hintStyle: TextStyle(fontSize: 13),
                    //     contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    //     focusedErrorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //         borderSide: BorderSide(
                    //             color: AppColors.whiteTemp, width: 2)),
                    //     enabledBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //         borderSide: const BorderSide(
                    //             color: AppColors.whiteTemp, width: 2)),
                    //     errorBorder: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(25),
                    //         borderSide: BorderSide(
                    //             color: AppColors.whiteTemp, width: 2)),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: AppColors.whiteTemp),
                    //       borderRadius: BorderRadius.circular(25),
                    //     ),
                    //   ),
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Please Enter Password';
                    //     } else if (value.toString() !=
                    //         passwordC.text.toString()) {
                    //       return 'Confirm Password is Not Match';
                    //     }
                    //     return null; // Return null if the input is valid
                    //   },
                    // ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (licenseFrontImg == null) {
                            customSnackbar(
                                context, "Please Upload License Front Image");
                          } else if (licenseBackImg == null) {
                            customSnackbar(
                                context, "Please Upload License Back Image");
                          }
                          signUp();
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: !isLoading
                          ? CustomButton(
                              textt: "Continue",
                            )
                          : LoadingWidget(context),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " Log In",
                            style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextEditingController ownernameController = TextEditingController();
  TextEditingController registrationNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void signUp() {
    setState(() {
      isLoading = true;
    });
    var param = {
      'user_fullname': ownernameController.text,
      'user_email': emailC.text,
      'user_phone': mobilecontroller.text,
      'gender': _selectvehiclecat.toString(),
      'address': addressController.text,
      'password': passwordC.text,
      'rc_number': registrationNoController.text,
    };

    List<Map<String, dynamic>> imagefile = [
      {"key": "license_front_image", "filePath": licenseFrontImg!.path},
      {"key": "license_back_image", "filePath": licenseBackImg!.path},
    ];
    print("sign up par $param image here $imagefile");
    apiBaseHelper
        .postMultipartAPICall(registrationurl, param, imagefile)
        .then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error == true) {
        customSnackbar(context, msg.toString());
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
        setState(() {
          isLoading = false;
        });
      } else {
        customSnackbar(context, msg.toString());
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  TextEditingController mobilecontroller = TextEditingController();
  bool isLoading = false;

  bool _obscureText = true;

  String? _selectvehiclecat;
  List selectvehicle_List = ['Male', 'Female'];

  // void showPlacePicker() async {
  //   LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
  //       builder: (context) =>
  //           PlacePicker("AIzaSyBWG0ZCi63QT7H6rDeP7FUTxP12GHhwrZM")));
  //
  //   // Check if the user picked a place,
  //   if (result != null) {
  //     setState(() {
  //       addressController.text = '${result.formattedAddress}';
  //       print(addressController.text);
  //     });
  //     setState(() {
  //       lat = "${result.latLng!.latitude}";
  //       print(lat);
  //
  //       lang = "${result.latLng!.longitude}";
  //       print(lang);
  //     });
  //   }
  // }

  var lat;
  var lang;
}
