import 'package:eco_rider_user/Screen/auth/verifyOtp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/customeTost.dart';
import '../../Helper/loadingwidget.dart';
import '../../Widget/custom_app_button.dart';
import 'custumScreen.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            customAuthDegine(context, "assets/images/login.png"),
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
                    // const Row(
                    //   children: [
                    //     Text(
                    //       'Sign Up',
                    //       style: TextStyle(
                    //           fontSize: 20, fontWeight: FontWeight.bold),
                    //     ),
                    //   ],
                    // ),
                    const Row(
                      children: [
                        Text(
                          'Create New Account',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 45,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Radio(
                    //       value: 'Email',
                    //       groupValue: login,
                    //       onChanged: (value) {
                    //         updateLoginType(value ?? '');
                    //       },
                    //       activeColor: AppColors.primary,
                    //     ),
                    //     const Text(
                    //       "Email",
                    //       style: TextStyle(
                    //           color: AppColors.blackTemp, fontSize: 15),
                    //     ),
                    //     const SizedBox(
                    //       width: 25,
                    //     ),
                    //     Radio(
                    //       value: 'Mobile no.',
                    //       groupValue: login,
                    //       onChanged: (value) {
                    //         updateLoginType(value ?? '');
                    //       },
                    //       activeColor: AppColors.primary,
                    //     ),
                    //     const Text(
                    //       'Mobile No',
                    //       style: TextStyle(
                    //           color: AppColors.blackTemp, fontSize: 15),
                    //     )
                    //   ],
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // num == 1
                    //     ?
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
                          borderSide:
                              const BorderSide(color: AppColors.tabtextColor),
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
                    //     : TextFormField(
                    //         controller: emailC,
                    //         keyboardType: TextInputType.emailAddress,
                    //         decoration: InputDecoration(
                    //           prefixIcon: const Icon(
                    //             Icons.email,
                    //             color: AppColors.tabtextColor,
                    //           ),
                    //           hintText: 'Email',
                    //           hintStyle: TextStyle(fontSize: 13),
                    //           contentPadding:
                    //               const EdgeInsets.symmetric(vertical: 5),
                    //           focusedErrorBorder: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(25),
                    //               borderSide: BorderSide(
                    //                   color: AppColors.whiteTemp, width: 2)),
                    //           enabledBorder: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(25),
                    //               borderSide: const BorderSide(
                    //                   color: AppColors.whiteTemp, width: 2)),
                    //           errorBorder: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(25),
                    //               borderSide: BorderSide(
                    //                   color: AppColors.whiteTemp, width: 2)),
                    //           focusedBorder: OutlineInputBorder(
                    //             borderSide:
                    //                 BorderSide(color: AppColors.whiteTemp),
                    //             borderRadius: BorderRadius.circular(25),
                    //           ),
                    //         ),
                    //         validator: (value) {
                    //           if (value!.isEmpty) {
                    //             return 'Please Enter Email';
                    //           } else if (!value.contains('@') ||
                    //               !value.contains(".com")) {
                    //             return 'Please Enter Valid Email';
                    //           }
                    //           return null; // Return null if the input is valid
                    //         },
                    //       ),
                    // num == 1
                    //     ? SizedBox.shrink()
                    //     : const SizedBox(
                    //         height: 20,
                    //       ),
                    // num == 1
                    //     ? SizedBox.shrink()
                    //     : TextFormField(
                    //         obscureText: _obscureText,
                    //         controller: passwordC,
                    //         decoration: InputDecoration(
                    //           suffixIcon: IconButton(
                    //             icon: Icon(
                    //               _obscureText
                    //                   ? Icons.visibility
                    //                   : Icons.visibility_off,
                    //               color: AppColors.primary,
                    //               size: 16,
                    //             ),
                    //             onPressed: () {
                    //               setState(() {
                    //                 _obscureText = !_obscureText;
                    //               });
                    //             },
                    //           ),
                    //           prefixIcon: const Icon(
                    //             Icons.lock,
                    //             color: AppColors.tabtextColor,
                    //           ),
                    //           hintText: 'Password',
                    //           hintStyle: TextStyle(fontSize: 13),
                    //           contentPadding:
                    //               const EdgeInsets.symmetric(vertical: 5),
                    //           focusedErrorBorder: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(25),
                    //               borderSide: BorderSide(
                    //                   color: AppColors.whiteTemp, width: 2)),
                    //           enabledBorder: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(25),
                    //               borderSide: const BorderSide(
                    //                   color: AppColors.whiteTemp, width: 2)),
                    //           errorBorder: OutlineInputBorder(
                    //               borderRadius: BorderRadius.circular(25),
                    //               borderSide: BorderSide(
                    //                   color: AppColors.whiteTemp, width: 2)),
                    //           focusedBorder: OutlineInputBorder(
                    //             borderSide:
                    //                 BorderSide(color: AppColors.whiteTemp),
                    //             borderRadius: BorderRadius.circular(25),
                    //           ),
                    //         ),
                    //         validator: (value) {
                    //           if (value!.isEmpty) {
                    //             return 'Please Enter Password';
                    //           }
                    //           return null; // Return null if the input is valid
                    //         },
                    //       ),
                    // num == 1
                    //     ? SizedBox.shrink()
                    //     : const SizedBox(
                    //         height: 8,
                    //       ),
                    // num == 1
                    //     ? SizedBox.shrink()
                    //     : InkWell(
                    //         onTap: () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) =>
                    //                     const forgotPassword()),
                    //           );
                    //         },
                    //         child: Container(
                    //           alignment: Alignment.centerRight,
                    //           child: const Text(
                    //             'Forgot Password ?',
                    //             style: TextStyle(
                    //                 fontSize: 13,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: AppColors.primary),
                    //           ),
                    //         ),
                    //       ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          loginmobileApi();
                        }
                      },
                      child: !isLoading
                          ? CustomButton(
                              textt: "Send Otp",
                            )
                          : LoadingWidget(context),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  var fcmToken;
  getFCM() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    try {
      fcmToken = await _firebaseMessaging.getToken() ?? "";
    } on FirebaseException {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFCM();
  }

  String? isFrom;

  void loginmobileApi() {
    setState(() {
      isLoading = true;
    });
    var param = {
      'mobile': mobilecontroller.text.toString(),
    };
    apiBaseHelper.postAPICall(mobileCheck, param).then((getData) async {
      bool error = getData['status'];
      String msg = getData['message'].toString();
      print("mobile");
      if (error == true) {
        var otp = getData['otp'].toString();
        customSnackbar(context, msg.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyOtp(
              isLogin: true,
              Mobile: mobilecontroller.text,
              otp: otp.toString(),
              isFrom: "signup",
            ),
          ),
        );
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
  String login = 'Email';

  void updateLoginType(String value) {
    if (value == 'Email') {
      num = 0;
    } else {
      num = 1;
    }
    login = value;

    setState(() {});
  }

  int num = 0;

  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
}
