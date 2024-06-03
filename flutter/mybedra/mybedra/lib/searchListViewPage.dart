// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:mybedra/GetPath.dart';
import 'package:mybedra/Models/ResultModel.dart';
import 'package:mybedra/Widgets/resultListPage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchListMainPage extends StatefulWidget {
  SearchListMainPage({Key? key, required this.searchQuery}) : super(key: key);

  final searchQuery;
  @override
  State<SearchListMainPage> createState() =>
      _SearchListMainPageState(searchQuery);
}

class _SearchListMainPageState extends State<SearchListMainPage> {
  _SearchListMainPageState(this._searchQuery);
  late final _searchQuery;
  late Future<List<Result>> futureAlbum;
  late List<Result> Autodata;

  loadSearchData() async {
    //await Future.delayed(Duration(seconds: 5));
    //  final busJson = await rootBundle.loadString("assets/files/buses.json");
    //final busJson = await fetchAlbum();
    GetUrl serverPath = GetUrl();
    final busJson = await http.get(Uri.parse(serverPath.url +
        'getConnect.php' +
        '?Patern=' +
        _searchQuery.toString()));

    // final response = await http.get(Uri.parse(url));
    //  final catalogJson = response.body;
    var busdecodedData = jsonDecode(busJson.body);
    var busproductsData = busdecodedData;
    ResultModel.resultList = List.from(busproductsData)
        .map<Result>((buslist) => Result.fromMap(buslist))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text('Looking for ' + _searchQuery.toString()),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: Vx.mH12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (ResultModel.resultList != null &&
                  ResultModel.resultList.isNotEmpty)
                ResultListPage().expand()
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
    loadSearchData();
    // futureAlbum = fetchAlbum();
  }
}
