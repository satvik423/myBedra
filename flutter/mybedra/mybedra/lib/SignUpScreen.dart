// Code by alfacodes
// follow on Instagram for more such content

// ignore_for_file: unused_field

import 'package:mybedra/Home.dart';
import 'package:mybedra/Widgets/themes.dart';
import 'package:mybedra/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool value = false;
  bool checkedValue = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isNameValid = false;
  String errorTextPassword = "";
  bool _isPasswordValid = false;
  bool _isConfirmValid = false;
  bool _isAddressValid = false;
  bool _isPhoneValid = false;

  bool _isHidePassword = false;
  bool _isLogin = false;

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _confirmController.dispose();

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
                  'Let\'s Get \n Started ',
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
                    height: 50,
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
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        focusColor: marooncolor,
                        border: InputBorder.none,
                        hintText: 'Full Name',
                        hintStyle: TextStyle(
                          color: greyDarkColor,
                          fontSize: 14,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _isNameValid = value.length >= 1;
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
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        focusColor: marooncolor,
                        border: InputBorder.none,
                        hintText: 'Enter Mobile Number',
                        hintStyle: TextStyle(
                          color: greyDarkColor,
                          fontSize: 14,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _isPhoneValid = value.length == 10;
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
                          _isPasswordValid = value.length >= 6;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
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
                      controller: _confirmController,
                      keyboardType: TextInputType.visiblePassword,

                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Confirm Password',
                        errorStyle: TextStyle(color: Colors.red),
                        //  errorText: errorTextPassword,
                        hintStyle: TextStyle(
                          color: greyDarkColor,
                          fontSize: 14,
                        ),
                        // suffixIcon: GestureDetector(
                        //   onTap: () {
                        //     setState(() {
                        //       _isHidePassword = !_isHidePassword;
                        //     });
                        //   },
                        //   child: (!_isHidePassword)
                        //       ? Icon(Icons.visibility_off, color: greyBorderColor)
                        //       : Icon(Icons.visibility, color: marooncolor),
                        // ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _isConfirmValid = _confirmController.text ==
                              _passwordController.text;
                          if (_confirmController.text !=
                              _passwordController.text) {
                            errorTextPassword = 'Password Does\'nt match';
                          } else {
                            errorTextPassword = '';
                          }
                        });
                      },
                      // onEditingComplete: () => {
                      //   setState(() {
                      //     if (_confirmController.text !=
                      //         _passwordController.text) {
                      //       errorTextPassword = 'Password Does\'nt match';
                      //     }
                      //   }),
                      // },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        errorTextPassword,
                        style: TextStyle(
                          color: marooncolor,
                          fontWeight: medium,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
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
                      controller: _addressController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Short Address',
                        hintStyle: TextStyle(
                          color: greyDarkColor,
                          fontSize: 14,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _isAddressValid = value.length >= 1;
                        });
                      },
                    ),
                  ),

                  CheckboxListTile(
                    activeColor: marooncolor,
                    title: Text(
                      "I Accept Terms & Conditions",
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 14),
                    ),
                    value: checkedValue,
                    onChanged: (newValue) {
                      setState(() {
                        checkedValue = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Checkbox(
                  //       value: this.value,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           if (!this.value) {
                  //             this.value = false;
                  //           }
                  //           if (this.value) {
                  //             this.value = true;
                  //           }
                  //         });
                  //       },
                  //     ),
                  //     Text(
                  //       'I confirm the above details ',
                  //       style: TextStyle(fontSize: 16.0),
                  //     ), //Checkbox
                  //   ], //<Widget>[]
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       'Forgot Password?',
                  //       style: TextStyle(
                  //         color: marooncolor,
                  //         fontWeight: medium,
                  //         fontSize: 12,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 25),
                  Container(
                    height: 45,
                    width: double.infinity,
                    child: _isLogin
                        ? Center(
                            child: CircularProgressIndicator(
                              color: marooncolor,
                            ),
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: _isPasswordValid &&
                                      _isNameValid &&
                                      _isConfirmValid &&
                                      _isAddressValid &&
                                      checkedValue
                                  ? marooncolor
                                  : marooncolorlight,
                              onSurface: marooncolorlight,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _isPasswordValid &&
                                    _isNameValid &&
                                    _isConfirmValid &&
                                    _isAddressValid &&
                                    checkedValue
                                ? () {
                                    setState(() {
                                      _isNameValid = true;
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
                              'Sign up',
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
              "Welcome to Connect Moodbidri",
              style: TextStyle(
                color: greyDarkColor,
                letterSpacing: 0.1,
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
      ..quadraticBezierTo(size.width / 4, 300.0, size.width, 170)
      ..relativeLineTo(0, -180)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
