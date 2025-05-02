import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:eco_rider_user/Api%20services/api_services/apiConstants.dart';
import 'package:eco_rider_user/Screen/homepage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/loadingwidget.dart';
import '../../Widget/custom_app_button.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.primary,
        title: const Text(
          "My Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            userImg != null
                ? InkWell(
                    onTap: () {
                      showAlertDialog(context, 'profile');
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 75,
                      child: CircleAvatar(
                        backgroundImage: FileImage(File(userImg!.path)),
                        radius: 70,
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      showAlertDialog(context, 'profile');
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 75,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          imagepath.toString(),
                        ),
                        radius: 70,
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 20,
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
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(color: AppColors.tabtextColor, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(color: AppColors.tabtextColor, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(color: AppColors.tabtextColor, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.tabtextColor),
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
            const SizedBox(
              height: 9,
            ),
            TextFormField(
              controller: emailC,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.email,
                  color: AppColors.tabtextColor,
                ),
                hintText: 'Email',
                hintStyle: const TextStyle(fontSize: 13),
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(color: AppColors.tabtextColor, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      const BorderSide(color: AppColors.tabtextColor, width: 1),
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: AppColors.tabtextColor, width: 1)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.tabtextColor),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Email';
                } else if (!value.contains('@') || !value.contains(".com")) {
                  return 'Please Enter Valid Email';
                }
                return null; // Return null if the input is valid
              },
            ),
            const SizedBox(
              height: 9,
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
                hintStyle: const TextStyle(fontSize: 13),
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: AppColors.tabtextColor, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: AppColors.tabtextColor, width: 1)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                        color: AppColors.tabtextColor, width: 1)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.tabtextColor),
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
              height: 9,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width / 2),
                border: Border.all(width: 1, color: AppColors.blackTemp),
              ),
              child: Container(
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.map,
                      color: AppColors.tabtextColor,
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.7,
                          child: const Text(
                            'Select Gender',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: AppColors.tabtextColor, fontSize: 13),
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
                            value: location,
                            child: Text(location),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // TextFormField(
            //   controller: registrationCtr,
            //   decoration: InputDecoration(
            //     prefixIcon: const Icon(
            //       Icons.app_registration,
            //       color: AppColors.tabtextColor,
            //     ),
            //     hintText: 'License No.',
            //     hintStyle: const TextStyle(fontSize: 13),
            //     contentPadding: const EdgeInsets.symmetric(vertical: 5),
            //     focusedErrorBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(15),
            //         borderSide: const BorderSide(
            //             color: AppColors.tabtextColor, width: 1)),
            //     enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(15),
            //         borderSide: const BorderSide(
            //             color: AppColors.tabtextColor, width: 1)),
            //     errorBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(15),
            //         borderSide: const BorderSide(
            //             color: AppColors.tabtextColor, width: 1)),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: const BorderSide(color: AppColors.tabtextColor),
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //   ),
            //   validator: (value) {
            //     if (value!.isEmpty) {
            //       return 'Please Enter Email';
            //     } else if (!value.contains('@') || !value.contains(".com")) {
            //       return 'Please Enter Valid Email';
            //     }
            //     return null; // Return null if the input is valid
            //   },
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 5, right: 5),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         "License Front Image",
            //         style: TextStyle(fontWeight: FontWeight.w600),
            //       ),
            //       Text(
            //         "License Back Image",
            //         style: TextStyle(fontWeight: FontWeight.w600),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         showAlertDialog(context, 'license_front');
            //       },
            //       child: Container(
            //         height: 150,
            //         width: 150,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           border: Border.all(color: Colors.black),
            //         ),
            //         child: licenseFrontImg != null
            //             ? Image.file(
            //                 File(licenseFrontImg!.path),
            //                 fit: BoxFit.cover,
            //               )
            //             : Image.network(
            //                 "https://developmentalphawizz.com/eco_rider/upload/customer_profiles/$licenseFront",
            //                 fit: BoxFit.cover,
            //               ),
            //       ),
            //     ),
            //     InkWell(
            //       onTap: () {
            //         showAlertDialog(context, 'license_back');
            //       },
            //       child: Container(
            //         height: 150,
            //         width: 150,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           border: Border.all(color: Colors.black),
            //         ),
            //         child: licenseBackImg != null
            //             ? Image.file(
            //                 File(licenseBackImg!.path),
            //                 fit: BoxFit.cover,
            //               )
            //             : Image.network(
            //                 "https://developmentalphawizz.com/eco_rider/upload/customer_profiles/$licesneBack",
            //                 fit: BoxFit.cover,
            //               ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      updateProfile();
                    },
                    child: !isLoading
                        ? CustomButton(
                            textt: "Update Profile",
                          )
                        : LoadingWidget(context),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ]),
        ),
      ),
    );
  }

  bool isLoading = false;
  var getdataa;

  Future<void> getprivecy() async {
    setState(() {
      isLoading = true;
    });

    var headers = {
      'Cookie': 'ci_session=6c0fcaf4599389035573c1a4171e5a8fb5c97331'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}apiprivacy_policy'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);

      if (finalresult['status'] == true) {
        setState(() {
          getdataa = finalresult['data'][0]['description'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  var imagepath, licenseFront, licesneBack;
  String? _selectvehiclecat;
  List selectvehicle_List = ['Male', 'Female'];
  final emailC = TextEditingController();
  TextEditingController ownernameController = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  TextEditingController registrationCtr = TextEditingController();
  getuserdata() async {
    setState(() {
      isLoading = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('userId');

    var param = {
      'user_id': userId.toString(),
    };
    print("get data $param");
    apiBaseHelper.postAPICall(getprofileurl, param).then(
      (getDta) {
        bool error = getDta['status'];
        String msg = getDta['message'];
        if (error == true) {
          print(
              "===my technic==== api===${getDta['data']['gender'].toString()}===============");
          String getGender = getDta['data']['gender'] ?? "";
          String capitalizedA =
              "${getGender[0].toUpperCase()}${getGender.substring(1)}";

          setState(() {
            print("===my technic=====convert==$capitalizedA===============");
            _selectvehiclecat = capitalizedA ?? "";
            ownernameController.text = getDta['data']['username'] ?? "";
            emailC.text = getDta['data']['email'] ?? "";
            registrationCtr.text = getDta['data']['rc_number'] ?? "";
            mobilecontroller.text = getDta['data']['mobile'] ?? "";
            imagepath = getDta['data']['image_path'] ?? "";
            licenseFront = getDta['data']['license_front_image'] ?? "";
            licesneBack = getDta['data']['license_back_image'] ?? "";
            setState(() {
              isLoading = false;
            });
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      },
    );
  }

  File? userImg, licenseFrontImg, licenseBackImg;

  Future<void> pickImage(ImageSource source, String type) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
      maxHeight: 100,
      maxWidth: 100,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      setState(() {
        if (type == 'profile') {
          userImg = File(pickedFile.path);
          print('============${userImg!.path}');
        }
        if (type == 'license_front') {
          licenseFrontImg = File(pickedFile.path);
          print('============${licenseFrontImg!.path}');
        }
        if (type == 'license_back') {
          licenseBackImg = File(pickedFile.path);
          print('============${licenseBackImg!.path}');
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
                    const SizedBox(
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
                    const SizedBox(
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
                          child:
                              const Center(child: Text('Select From Camera')),
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
    var userId = prefs.getString('userId');
    var headers = {
      'Cookie': 'ci_session=954d3e2ef52b8cdb356371983e0cc1c32abf1538'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${baseUrl}update_userprofile'));
    request.fields.addAll({
      'user_id': userId.toString(),
      'user_fullname': ownernameController.text.toString(),
      'user_email': emailC.text.toString(),
      'gender': _selectvehiclecat.toString(),
      'rc_number': registrationCtr.text,
    });
    print(request.url);
    print(request.fields);
    if (userImg != null) {
      request.files
          .add(await http.MultipartFile.fromPath('user_image', userImg!.path));

      print(request.files);
    }
    if (userImg != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'license_front_image', userImg!.path));

      print(request.files);
    }
    if (userImg != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'license_back_image', userImg!.path));

      print(request.files);
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalresult = jsonDecode(result);

      if (finalresult['status'] == true) {
        Fluttertoast.showToast(msg: finalresult['message'].toString());

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScr(),
          ),
        );
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
