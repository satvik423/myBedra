// ignore_for_file: unused_import

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mybedra/consts.dart';
import 'package:mybedra/login.dart';
import 'package:mybedra/signinPage.dart';
import 'package:mybedra/themes.dart';
import 'package:mybedra/utils/TextStyles.dart';
import 'package:mybedra/utils/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'BoardingView/OnBoardingScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: connectblue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.plane,
                color: whiteColor,
                size: 70,
              ),
              SizedBox(height: 50),
              BoldText("Connect", 35.0, whiteColor),
              TypewriterAnimatedTextKit(
                text: ["Moodbidri"],
                textStyle: TextStyle(
                    fontSize: 30.0, color: whiteColor, fontFamily: "nunito"),
                speed: Duration(milliseconds: 150),
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        //return LandingPage();
        //return SignInScreen();
        return SignInScreen();
      }));
    });
  }
}
