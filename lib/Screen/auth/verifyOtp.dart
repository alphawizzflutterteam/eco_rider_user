import 'package:eco_rider_user/Screen/auth/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Api services/api_services/apiBasehelper.dart';
import '../../Api services/api_services/apiStrings.dart';
import '../../Helper/Colors.dart';
import '../../Helper/customeTost.dart';
import '../../Helper/loadingwidget.dart';
import '../../Widget/custom_app_button.dart';
import '../homepage/homePage.dart';
import 'changepassword.dart';
import 'custumScreen.dart';

class VerifyOtp extends StatefulWidget {
  bool? isLogin;
  String? otp;
  String? Mobile;
  String? isFrom;

  VerifyOtp({super.key, this.otp, this.Mobile, this.isLogin, this.isFrom});
  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          customAuthDegineforverifie(
            context,
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.29),
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
                    height: 20,
                  ),
                  const Text(
                    'Code has sent to',
                    style: TextStyle(
                        fontSize: 17,
                        color: AppColors.blackTemp,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    '+${widget.Mobile.toString()}',
                    style: const TextStyle(
                        fontSize: 20,
                        color: AppColors.blackTemp,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    'OTP: ${otpp.toString()}',
                    style: const TextStyle(
                        fontSize: 20,
                        color: AppColors.blackTemp,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: PinCodeTextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        textotp = value.toString();
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(15),
                        activeColor: AppColors.blackTemp,
                        inactiveColor: AppColors.blackTemp,
                        selectedColor: AppColors.blackTemp,
                        fieldHeight: 70,
                        fieldWidth: 70,
                      ),
                      //pinBoxRadius:20,
                      appContext: context,
                      length: 4,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Haven't received the verification code?",
                    style: TextStyle(
                        fontSize: 17,
                        color: AppColors.blackTemp,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  !isLoading
                      ? InkWell(
                          onTap: () {
                            sendOtp();
                          },
                          child: const Text(
                            "Resend",
                            style: TextStyle(
                                fontSize: 17,
                                color: AppColors.blackTemp,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : LoadingWidget(context),
                  const SizedBox(
                    height: 70,
                  ),
                  InkWell(
                    onTap: () {
                      print("========$textotp========$otpp=");
                      print(
                          "========${textotp.runtimeType}========${otpp.runtimeType}=");
                      if (textotp == null) {
                        customSnackbar(context, "Please Fill OTP Fields");
                      } else if (otpp != textotp) {
                        customSnackbar(context, "Please Fill Correct OTP");
                      } else {
                        if (widget.isLogin == true) {
                          widget.isFrom == "login"
                              ? verifie()
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SignUpScr(mobile: widget.Mobile),
                                  ),
                                );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePassword(
                                Mobile: widget.Mobile.toString(),
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: CustomButton(
                      textt: "Submit",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFCM();
    otpp = widget.otp.toString();
    ;
  }

  bool isLoading = false;
  var otpp;
  var textotp;

  void sendOtp() {
    setState(() {
      isLoading = true;
    });
    var param = {
      "user_phone": widget.Mobile.toString(),
    };
    apiBaseHelper.postAPICall(loginurl, param).then((getData) {
      String msg = getData['message'];
      bool error = getData['status'];

      if (error == true) {
        setState(() {
          otpp = getData['data'].toString();
        });
        customSnackbar(context, msg.toString());
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

  var fcmToken;
  getFCM() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    try {
      fcmToken = await _firebaseMessaging.getToken() ?? "";
    } on FirebaseException {}
  }

  void verifie() {
    setState(() {
      isLoading = true;
    });
    var param = {
      "user_phone": widget.Mobile.toString(),
      'otp': otpp.toString(),
      'firebaseToken': fcmToken.toString()
    };
    apiBaseHelper.postAPICall(verifieurl, param).then((getData) async {
      String msg = getData['message'];
      bool error = getData['status'];

      if (error == true) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', '${getData['data']['id']}');
        customSnackbar(context, msg.toString());
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScr(),
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
}
