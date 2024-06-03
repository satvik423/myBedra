// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:mybedra/GetPath.dart';
import 'package:mybedra/Models/BusDestinationModel.dart';
import 'package:mybedra/TextStyles.dart';
import 'package:mybedra/consts.dart';
import 'package:mybedra/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:http/http.dart' as http;

import 'dashBoard.dart';

class AddBusRequestPage extends StatefulWidget {
  AddBusRequestPage({Key? key}) : super(key: key);

  @override
  State<AddBusRequestPage> createState() => _AddBusRequestPageState();
}

class _AddBusRequestPageState extends State<AddBusRequestPage> {
  bool _isSelected = false;
  bool _isLogin = false;
  String _selectedItem = '';
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime _selectedbusTime = DateTime.now();
  late List<String> _list = [
    'Mangaluru',
    'Karkala',
    'BC Road',
    'Belthangady',
    'Ashwathpura',
    'Belman',
    'Naravi',
    'BC Road',
    'Iruvail',
    'Kinnigoli',
    'Mulki'
  ];

  late String _dropDownValue = "Select location";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

//  final TextEditingController _busNameController = TextEditingController();
//   String _selectedLocation = '';
//   DateTime _selectedDepartureTime = DateTime.now();

  bool _isBusnameValid = false;
  bool _isPasswordValid = false;

  bool _isHidePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColorDark,
        leading: BackButton(color: Colors.white),
        title: Text('Add Bus Request'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(14),
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: blueColorDark,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: blueColorDark),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: blueColorDark),
                ),
                suffixIconColor: blueColorDark,
                hintText: 'Enter Bus Name',
                hintStyle: TextStyle(fontSize: 14, color: greyBorderColor),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isBusnameValid = !_isBusnameValid;
                      _emailController.clear();
                    });
                  },
                  child: _isBusnameValid
                      ? Icon(
                          Icons.close_rounded,
                          color: blueColorDark,
                        )
                      : SizedBox(),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _isBusnameValid = value.length >= 1;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 12, 24, 6),
            child: Center(
              child: DropdownButton(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                hint: _dropDownValue == null
                    ? Text('Dropdown')
                    : Text(
                        _dropDownValue,
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: Colors.blueGrey),
                items: _list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
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
              margin: EdgeInsets.all(24),
              alignment: Alignment.centerLeft,
              // child: NormalText("Featured", kgreyDark, 28)),
              child: NormalText("Bus Departure time", kgreyDark, 28)),
          TimePickerSpinner(
            time: _selectedbusTime,
            is24HourMode: false,
            normalTextStyle: TextStyle(fontSize: 24, color: Colors.grey),
            highlightedTextStyle: TextStyle(fontSize: 24, color: blueColorDark),
            spacing: 10,
            itemHeight: 80,
            isForce2Digits: true,
            onTimeChange: (time) {
              setState(() {
                _selectedbusTime = time;
              });
            },
          ),
          // Text(_selectedbusTime.hour.toString() +
          //     ':' +
          //     _selectedbusTime.minute.toString()),
          // Text("${selectedTime.hour}:${selectedTime.minute}"),
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
                            final bus = Bus(
                              name: _emailController.text,
                              location: _selectedItem,
                              departureTime: _selectedbusTime.toString(),
                            );
                            insertBusData(bus);

                            // Future.delayed(Duration(milliseconds: 100), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard(
                                        BusRoute: _dropDownValue,
                                      )),
                            );
                            //   // setState(() {
                            //   //   _isLogin = false;
                            //   // });
                            // });
                          }
                        : null,
                    child: Text(
                      'Submit Bus Details',
                      style: TextStyle(
                        color: whiteColor,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
      confirmText: "CONFIRM",
      cancelText: "NOT NOW",
      helpText: "BUS DEPATURE TIME",
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  loadBusDestinationData() async {
    //await Future.delayed(Duration(seconds: 5));
    //  final busJson = await rootBundle.loadString("assets/files/buses.json");
    //final busJson = await fetchAlbum();
    GetUrl serverPath = GetUrl();
    final busJson =
        await http.get(Uri.parse(serverPath.url + 'get_bus_routes.php'));

    // final response = await http.get(Uri.parse(url));
    //  final catalogJson = response.body;
    var busdecodedData = jsonDecode(busJson.body);
    var busproductsData = busdecodedData;
    BusDestModel.Destinationlist = List.from(busproductsData)
        .map<BusDestination>((buslist) => BusDestination.fromMap(buslist))
        .toList();
    setState(() {});
  }
}

//bus database entry
class Bus {
  final String name;
  final String location;
  final String departureTime;

  Bus(
      {required this.name,
      required this.location,
      required this.departureTime});
}

Future<Database> initializeDatabase() async {
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path + 'connectm.db';

  final database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      db.execute(
          '''
        CREATE TABLE IF NOT EXISTS bus_table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          location TEXT,
          departure_time TEXT
        )
      ''');
    },
  );

  return database;
}

Future<void> insertBusData(Bus bus) async {
  final database = await initializeDatabase();

  await database.transaction((txn) async {
    await txn.rawInsert(
        '''
        INSERT INTO bus_table (bus_name, bus_time, destination_name)
        VALUES (?, ?, ?)
      ''',
        [bus.name, bus.departureTime, bus.location]);
  });

  // Data inserted successfully
  print('Bus data inserted successfully.');
}
