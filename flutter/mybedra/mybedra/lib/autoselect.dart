import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybedra/AutoListMainPage.dart';
import 'package:mybedra/GetPath.dart';
import 'package:http/http.dart' as http;
import 'package:mybedra/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AutoSelect extends StatefulWidget {
  AutoSelect({Key? key}) : super(key: key);

  @override
  State<AutoSelect> createState() => _AutoSelectState();
}

class _AutoSelectState extends State<AutoSelect> {
  @override
  void initState() {
    super.initState();
    fetchData();

  }

  bool _isSelected = false;
  bool _isLogin = false;

  List<String> dropdownValues = [];
  Future<void> fetchData() async {
    GetUrl serverPath=GetUrl();
    // Make an HTTP GET request to your API endpoint
    var response = await http
        .get(Uri.parse(serverPath.url+'api/destinations/auto'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> destinations = jsonData['destinations'];

      setState(() {
        dropdownValues = destinations.cast<String>();
      });
    } else {
      // Handle the error case
      print('Request failed with status: ${response.statusCode}');
    }
  }

  late String _dropDownValue = "Select location";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellowColor,
        leading: BackButton(color: Colors.white),
        title: Text(
          ' Select your location',
          style: GoogleFonts.bebasNeue(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment(-0.8, 0.2),
                  children: [
                    Image.asset(
                      'assets/images/backk.png',
                      color: Colors.green,
                      height: 300,
                    ),
                    Image.asset(
                      'assets/images/y-auto.png',
                      height: 140,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Auto stand location?',
                style:
                    GoogleFonts.bebasNeue(fontSize: 20, color: Colors.blueGrey),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(36, 12, 36, 6),
                child: Center(
                  child: DropdownButton<String>(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    hint: _dropDownValue == Null
                        ? Text('Dropdown')
                        : Text(
                            _dropDownValue,
                            style: GoogleFonts.bebasNeue(
                                fontSize: 18, color: Colors.blueGrey),
                          ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.blueGrey),
                    items: dropdownValues
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.bebasNeue(
                              fontSize: 18, color: Colors.blueGrey),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        _dropDownValue = value!;
                        _isSelected = true;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(24, 0, 24, 12),
                height: 45,
                width: double.infinity,
                child: _isLogin
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: _isSelected ? yellowColor : yellowColor,
                          onSurface: yellowColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _isSelected
                            ? () {
                                setState(() {
                                  _isSelected = true;

                                  _isLogin = true;
                                });
                                Future.delayed(Duration(milliseconds: 100), () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AutoListMainPage(
                                                StandName: _dropDownValue,
                                              )),
                                    );
                                    _isLogin = false;
                                  });
                                });
                              }
                            : null,
                        child: Text(
                          'Seach Auto',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
