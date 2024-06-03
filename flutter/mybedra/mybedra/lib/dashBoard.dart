// ignore: file_names
import 'dart:convert';
import 'package:mybedra/GetPath.dart';
import 'package:mybedra/Widgets/bus_list.dart';
import 'package:mybedra/getBuses.dart';
import 'package:mybedra/themes.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  Dashboard({required this.BusRoute}) : super();

  String BusRoute;
  @override
  _DashboardState createState() => _DashboardState(BusRoute);
}

class _DashboardState extends State<Dashboard> {
  _DashboardState(this.BusRoute);

  String BusRoute;
  late Future<List<Buses>> futureAlbum;
  late List<Buses> Busdata;

  loadDatabuses(String BusRoute) async {
    GetUrl serverPath = GetUrl();
    final busJson = await http
        .get(Uri.parse(serverPath.url + 'getbuses?route=' + BusRoute));
    var busdecodedData = jsonDecode(busJson.body);
    var busproductsData = busdecodedData;
    busModel.buslist = List.from(busproductsData)
        .map<Buses>((buslist) => Buses.fromMap(buslist))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColorDark,
        leading: BackButton(color: Colors.white),
        title: Text('Available Buses'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.mH12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (busModel.buslist.isNotEmpty)
                BusList().expand()
              else
                CircularProgressIndicator().centered().expand(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadDatabuses(BusRoute);
  }
}
