// Code by alfacodes
// follow on Instagram for more such content

import 'package:mybedra/Home.dart';
import 'package:mybedra/SignUpScreen.dart';
import 'package:mybedra/Widgets/themes.dart';
import 'package:mybedra/utils/consts.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isEmailValid = false;
  bool _isPasswordValid = false;

  bool _isHidePassword = false;
  bool _isLogin = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              CustomPaint(
                child: Container(
                    // width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    height: 2),
                painter: HeaderCurvedContainer(),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 2),
                margin: EdgeInsets.fromLTRB(0, 40, 0, 2),
                alignment: Alignment.center,
                child: Text(
                  'Welcome',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                  ),
                ),
              ),
            ]),
            Container(
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Image.asset(
                    'assets/images/loginman.png',
                    height: 200,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: greyBorderColor,
                        width: 0.3,
                      ),
                    ),
                    child: TextFormField(
                      cursorColor: marooncolor,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        focusColor: marooncolor,
                        border: InputBorder.none,
                        hintText: 'Enter Mobile Number',
                        hintStyle: TextStyle(
                          color: greyDarkColor,
                          fontSize: 14,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isEmailValid = !_isEmailValid;
                              _emailController.clear();
                            });
                          },
                          child: _isEmailValid
                              ? Icon(Icons.close_rounded, color: marooncolor)
                              : SizedBox(),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _isEmailValid = value.length >= 1;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: greyBorderColor,
                        width: 0.3,
                      ),
                    ),
                    child: TextFormField(
                      cursorColor: marooncolor,
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: !_isHidePassword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: greyDarkColor,
                          fontSize: 14,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isHidePassword = !_isHidePassword;
                            });
                          },
                          child: (!_isHidePassword)
                              ? Icon(Icons.visibility_off,
                                  color: greyBorderColor)
                              : Icon(Icons.visibility, color: marooncolor),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _isPasswordValid = value.length >= 1;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: marooncolor,
                          fontWeight: medium,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Container(
                    height: 45,
                    width: double.infinity,
                    child: _isLogin
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: _isPasswordValid && _isEmailValid
                                  ? marooncolor
                                  : marooncolorlight,
                              onSurface: marooncolorlight,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _isPasswordValid && _isEmailValid
                                ? () {
                                    setState(() {
                                      _isEmailValid = true;
                                      _isPasswordValid = true;
                                      _isLogin = true;
                                    });
                                    Future.delayed(Duration(seconds: 2), () {
                                      setState(() {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Home(),
                                          ),
                                        );
                                        _isLogin = false;
                                      });
                                    });
                                  }
                                : null,
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                color: whiteColor,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 45,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: greyBorderColor,
              width: 0.3,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              style: TextStyle(
                color: greyDarkColor,
                letterSpacing: 0.1,
              ),
            ),
            InkWell(
              onTap: () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                )
              },
              child: Text(
                ' Sign Up.',
                style: TextStyle(
                  color: marooncolor,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = marooncolor;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 6, 250.0, size.width, 170)
      ..relativeLineTo(0, -180)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
