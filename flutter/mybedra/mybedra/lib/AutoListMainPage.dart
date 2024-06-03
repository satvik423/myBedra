import 'dart:convert';
import 'package:mybedra/GetPath.dart';
import 'package:mybedra/Models/AutoModel.dart';
import 'package:mybedra/Widgets/autoListPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class AutoListMainPage extends StatefulWidget {
  AutoListMainPage({Key? key, required this.StandName}) : super(key: key);

  final StandName;

  @override
  State<AutoListMainPage> createState() => _AutoListMainPageState(StandName);
}

class _AutoListMainPageState extends State<AutoListMainPage> {
  _AutoListMainPageState(this._StandName);
  late final _StandName;
  late Future<List<Autos>> futureAlbum;
  late List<Autos> Autodata;

  loadDataauto() async {
    GetUrl serverPath = GetUrl();
    final busJson = await http.get(Uri.parse(serverPath.url +
        'search_auto_list' +
        '?standName=' +
        _StandName.toString()));
    var busdecodedData = jsonDecode(busJson.body);
    var busproductsData = busdecodedData;
    AutoModel.autolist = List.from(busproductsData)
        .map<Autos>((buslist) => Autos.fromMap(buslist))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text(' Auto Rikshaws'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.mH12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (AutoModel.autolist != Null && AutoModel.autolist.isNotEmpty)
                AutoListPage().expand()
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
    loadDataauto();
  }
}
