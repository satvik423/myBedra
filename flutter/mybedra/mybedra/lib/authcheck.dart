// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';

import 'package:mybedra/catalog.dart';
import 'package:mybedra/getBuses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

Future<String> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('http://192.168.0.144/db/getbuses.php'));

  if (response.statusCode == 200) {
//  Album output = jsonDecode(response.body);

//     return output;
    return response.toString();

    // final users = (response.body).toString();
    // // If the server did return a 200 OK response,
    // // then parse the JSON.

    // Map<String, dynamic> jsonData = json.decode(users) as Map<String, dynamic>;

    // List<Album> temp = jsonDecode(response.body) as List<Album>;

    // return temp;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Student Data');
  }
}

class Album {
  final String bus_name;
  final String bus_time;
  final String destination_name;

  Album({
    required this.bus_name,
    required this.bus_time,
    required this.destination_name,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      bus_name: json['bus_name'],
      bus_time: json['bus_time'],
      destination_name: json['destination_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'bus_name': bus_name,
        'bus_time': bus_time,
        'destination_name': destination_name
      };
}

loadDataPro() async {
  await Future.delayed(Duration(seconds: 1));
  final catalogJson = await rootBundle.loadString("assets/files/catalog.json");

  // final response = await http.get(Uri.parse(url));
  //  final catalogJson = response.body;
  final decodedData = jsonDecode(catalogJson);
  var productsData = decodedData["products"];
  CatalogModel.items =
      List.from(productsData).map<Item>((item) => Item.fromMap(item)).toList();
}

loadDatabuses() async {
  await Future.delayed(Duration(seconds: 2));
  final busJson = await rootBundle.loadString("assets/files/buses.json");

  // final response = await http.get(Uri.parse(url));
  //  final catalogJson = response.body;
  final busdecodedData = jsonDecode(busJson);
  var busproductsData = busdecodedData;
  busModel.buslist = List.from(busproductsData)
      .map<Buses>((buslist) => Buses.fromMap(buslist))
      .toList();
}


// Autogen

