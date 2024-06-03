import 'dart:async';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybedra/GetPath.dart';
import 'package:mybedra/TextStyles.dart';
import 'package:mybedra/consts.dart';
import 'package:mybedra/dashBoard.dart';
import 'package:mybedra/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:mybedra/getBuses.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class BusSelectPage extends StatefulWidget {
  BusSelectPage({Key? key}) : super(key: key);

  @override
  State<BusSelectPage> createState() => _BusSelectPageState();
}

class _BusSelectPageState extends State<BusSelectPage> {
  late Timer timer;
  bool _isSelected = false;
  bool _isLogin = false;
  String mangloreTime = '';
  String karkalaime = '';
  String bcRoadTime = '';
  String belthangadyTime = '';
  String MangaluruNextBusName = '';
  String KarkalaNextBusName = '';
  String BCRoadNextBusName = '';
  String BelthangadyNextBusName = '';

  List<String> dropdownValues = [];
  late String _dropDownValue = "Select location";

  Future<void> fetchData() async {
    // Make an HTTP GET request to your API endpoint
    GetUrl serverPath= GetUrl();
    var response =
        await http.get(Uri.parse(serverPath.url+'api/destinations/bus'));

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

  @override
  void initState() {
    super.initState();
    fetchData();
    loadDatabuses('Mangaluru');
    loadDatabuses('Karkala');
    loadDatabuses('BC Road');
    loadDatabuses('Belthangady');
    timer = Timer.periodic(Duration(seconds: 15), (Timer t) => SetDefault());
  }

  SetDefault() {
    if (mangloreTime == '') mangloreTime = 'No Buses Available';
    if (karkalaime == '') karkalaime = 'No Buses Available';
    if (bcRoadTime == '') bcRoadTime = 'No Buses Available';
    if (mangloreTime == '') mangloreTime = 'No Buses Available';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

      appBar: AppBar(
        backgroundColor: blueColorDark,
        leading: BackButton(color: Colors.white),
        title: Text(
          'Buses from Moodbidri',
          style: GoogleFonts.bebasNeue(fontSize: 30, color: Colors.white),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
              ),
              Container(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/backk.png',
                      color: Colors.blueGrey,
                      height: 100,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 10, 0),
                      child: Image.asset(
                        'assets/images/blue-bus.png',
                        height: 95,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Select your route',
                style:
                    GoogleFonts.bebasNeue(fontSize: 18, color: Colors.blueGrey),
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
                          primary: _isSelected ? blueColorDark : blueColor,
                          onSurface: blueColorDark,
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Dashboard(
                                              BusRoute: _dropDownValue,
                                            )),
                                  );
                                  setState(() {
                                    _isLogin = false;
                                  });
                                });
                              }
                            : null,
                        child: Text(
                          'Serach Buses',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
              ),
              Container(
                  margin: EdgeInsets.all(12),
                  alignment: Alignment.centerLeft,
                  child: NormalText("Quick Access", kgreyDark, 28)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: _buildBusCard(context, 'Mangaluru', mangloreTime,
                          MangaluruNextBusName)),
                  Expanded(
                      child: _buildBusCard(
                          context, 'Karkala', karkalaime, KarkalaNextBusName)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: _buildBusCard(
                          context, 'BC Road', bcRoadTime, BCRoadNextBusName)),
                  Expanded(
                      child: _buildBusCard(context, 'Belthangady',
                          belthangadyTime, BelthangadyNextBusName)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget timeWidget(context, String Timing, String NextBusName) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            NextBusName,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            maxLines: 1,
            style: GoogleFonts.bebasNeue(fontSize: 18, color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            Timing,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: GoogleFonts.bebasNeue(fontSize: 18, color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget _buildBusCard(
      context, String DestinationName, String NextBusTime, String NextBusNAme) {
    return Container(
      margin: EdgeInsets.fromLTRB(4, 0, 2, 0),
      height: 130,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: blueColorDark,
        child: InkWell(
          splashColor: Colors.white.withAlpha(30),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(BusRoute: DestinationName),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 8.0, left: 8.0, right: 8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 80,
                            child: Column(
                              children: [
                                if (NextBusTime != '')
                                  timeWidget(context, NextBusTime, NextBusNAme)
                                else
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ).centered().expand(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        CupertinoIcons.forward,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    height: 30,
                    child: Text(
                      DestinationName,
                      style: GoogleFonts.bebasNeue(
                          fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loadDatabuses(String BusRoute) async {
    GetUrl serverPath = GetUrl();
    final busJson =
        await http.get(Uri.parse(serverPath.url + 'bus/' + BusRoute));
    print(busJson);
    var busdecodedData = jsonDecode(busJson.body);
    var busproductsData = busdecodedData;
    busModel.buslist = List.from(busproductsData)
        .map<Buses>((buslist) => Buses.fromMap(buslist))
        .toList();

    var now = DateTime.now();

    var formatterTime = DateFormat('HHmm');
    String actualTime = formatterTime.format(now);
    String strNextBus = '';
    String strNxtbusName = '';
    int nextBustime;
    for (int i = 0; i < busModel.buslist.length; i++) {
      busModel.buslist[i];
      if ((busModel.buslist[i].bus_time).toString().length == 3) {
        nextBustime = int.parse('0' + busModel.buslist[i].bus_time);
      } else {
        nextBustime = int.parse(busModel.buslist[i].bus_time);
      }

      int currtime = int.parse(actualTime);
      if (nextBustime > currtime) {
        strNextBus = busModel.buslist[i].bus_time;
        strNxtbusName = busModel.buslist[i].bus_name;
        break;
      }
    }
    if (BusRoute == 'Mangaluru') {
      mangloreTime = utcTo12HourFormat(strNextBus);
      MangaluruNextBusName = strNxtbusName;
    } else if (BusRoute == 'Karkala') {
      karkalaime = utcTo12HourFormat(strNextBus);
      KarkalaNextBusName = strNxtbusName;
    } else if (BusRoute == 'BC Road') {
      bcRoadTime = utcTo12HourFormat(strNextBus);
      BCRoadNextBusName = strNxtbusName;
    } else if (BusRoute == 'Belthangady') {
      belthangadyTime = utcTo12HourFormat(strNextBus);
      BelthangadyNextBusName = strNxtbusName;
    }
    setState(() {});
  }
  String utcTo12HourFormat(String bigTime) {
    if (bigTime.length == 3) {
      bigTime = '0' + bigTime;
    }
    if (bigTime != '') {
      bigTime = bigTime.substring(0, 2) + ':' + bigTime.substring(2, 4);
      DateTime tempDate = DateFormat("HH:mm").parse(bigTime);
      final DateFormat formatter = DateFormat('h:mm a');
      final String formatted = formatter.format(tempDate);
      print(formatted);
      return formatted;
    } else {
      return 'Bus not available';
    }
  }
}
