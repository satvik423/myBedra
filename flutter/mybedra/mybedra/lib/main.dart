// ignore_for_file: unused_import

import 'dart:io';

import 'package:mybedra/Home.dart';
import 'package:mybedra/pages/Profile.dart';
import 'package:mybedra/SplashScreen.dart';
import 'package:mybedra/TestPage.dart';
import 'package:mybedra/login.dart';
import 'package:mybedra/signinPage.dart';
import 'package:mybedra/themes.dart';
import 'package:flutter/material.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MaterialApp(
    theme: ThemeData(
      timePickerTheme: _timePickerTheme,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor:
              MaterialStateColor.resolveWith((states) => GreenColor),
          backgroundColor:
              MaterialStateColor.resolveWith((states) => whiteColor),
          overlayColor: MaterialStateColor.resolveWith((states) => whiteColor),
        ),
      ),
    ),
    home: Home(),
  ));
}

class HomeWidget extends StatefulWidget {
  HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('hello Creative')),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final _timePickerTheme = TimePickerThemeData(
  backgroundColor: Colors.blueGrey,
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Color.fromARGB(207, 28, 184, 98), width: 4),
  ),
  dayPeriodBorderSide:
      const BorderSide(color: Color.fromARGB(207, 28, 184, 98), width: 4),
  dayPeriodColor: Colors.white12,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Color.fromARGB(207, 28, 184, 98), width: 4),
  ),
  dayPeriodTextColor: Colors.white,
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: Color.fromARGB(207, 28, 184, 98), width: 4),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? Color.fromARGB(207, 28, 184, 98)
          : Colors.blueGrey.shade800),
  hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? Colors.white
          : Color.fromARGB(207, 28, 184, 98)),
  dialHandColor: Colors.blueGrey.shade700,
  dialBackgroundColor: Colors.blueGrey.shade800,
  hourMinuteTextStyle:
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  dayPeriodTextStyle:
      const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  helpTextStyle: const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? Color.fromARGB(207, 28, 184, 98)
          : Colors.white),
  entryModeIconColor: Color.fromARGB(207, 28, 184, 98),
);
