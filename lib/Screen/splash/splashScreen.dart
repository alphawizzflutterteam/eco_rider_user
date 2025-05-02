import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helper/nointernetcreen.dart';
import '../homepage/homePage.dart';
import 'IntroScreen.dart';

class SplashScr extends StatefulWidget {
  const SplashScr({Key? key}) : super(key: key);

  @override
  State<SplashScr> createState() => _SplashScrState();
}

class _SplashScrState extends State<SplashScr> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    internetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Splashscreen.png'),
        ),
      ),
      child: Center(
        child: Container(
          height: 250,
          width: 250,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/splash logo.png'),
          )),
        ),
      ),
    );
  }

  var userId;

  void sessionmanage() {
    Future.delayed(
      Duration(seconds: 3),
      () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        userId = prefs.getString('userId');
        print(userId);
        print(userId.runtimeType);

        if (userId == null) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => IntroScreen(),
              ));
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard(),));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScr(),
              ));
        }
      },
    );
  }

  void internetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        sessionmanage();
      }
    } on SocketException catch (_) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Internetcheck(),
          ));
    }
  }
}
