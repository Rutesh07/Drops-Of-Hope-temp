import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter1/screen/HomePage.dart';
import 'package:flutter1/screen/OnBoarding.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  get controller => null;

  get text => null;

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 6),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => OnboardingScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xffffffff),
        body: SingleChildScrollView(
          controller: controller,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                    height: 200,
                  ),
                  Center(child: Text("Blood\nDonation\nApp" ,style: TextStyle(fontFamily: "PlayfairDisplay", fontSize: 40 , fontWeight: FontWeight.bold ),),),
        
                  // SvgPicture.asset(
                  //   'assets/images/BestDesign.svg',
                  //   height: 450,
                  //   alignment: Alignment.center,
                  // ),
                  SizedBox(
                    height: 230,
                  ),
                  Lottie.asset("assets/animations/lf30_editor_7io4xwvy.json",
                      height: 300)
                ],
            ),
          ),
        ),
        // (
          // child: Center(
          //   child: Column(
          //     // children: [
          //     //   SizedBox(
          //     //     height: 200,
          //     //   ),
          //     //   Center(child: Text("Blood\nDonation\nApp" ,style: TextStyle(fontFamily: "PlayfairDisplay", fontSize: 40 , fontWeight: FontWeight.bold ),),),
        
          //     //   // SvgPicture.asset(
          //     //   //   'assets/images/BestDesign.svg',
          //     //   //   height: 450,
          //     //   //   alignment: Alignment.center,
          //     //   // ),
          //     //   SizedBox(
          //     //     height: 230,
          //     //   ),
          //     //   Lottie.asset("assets/animations/lf30_editor_7io4xwvy.json",
          //     //       height: 300)
          //     // ],
          //   ),
          // ),
        // )
        );
  }
}