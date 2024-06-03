import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'GetPath.dart';

class ImageSearch extends StatefulWidget {
  final String searchItem;

  const ImageSearch({
    Key? key,
    required this.searchItem,
  }) : super(key: key);

  @override
  _ImageSearchState createState() => _ImageSearchState();
}

class _ImageSearchState extends State<ImageSearch> {
  List<Map<String, dynamic>> searchedItems = [];

  @override
  void initState() {
    super.initState();
    searchItems(widget.searchItem);
  }
      

  Future<void> searchItems(String searchTerm) async {
    GetUrl serverPath = GetUrl();
    final url = serverPath.url+'categories_search?searchString=$searchTerm';

    final response = await http.get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      setState(() {
        searchedItems = data.map((item) => Map<String, dynamic>.from(item)).toList();
      });
    } else {
      print('Failed to fetch category data. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results',style: GoogleFonts.bebasNeue(fontSize: 20),),
      ),
      body: ListView.builder(
        itemCount: searchedItems.length,
        itemBuilder: (context, index) {
          final result = searchedItems[index];
          return ListTile(
            title: Text(result['cname'] ?? '',style: GoogleFonts.bebasNeue(fontSize: 20),),
            subtitle: Text(result['contact1'] ?? result['contact2'] ?? '',style: GoogleFonts.bebasNeue(fontSize: 20),),
            onTap: () {
      String phoneNumber = result['contact1'] ?? result['contact2'] ?? '';
      launch('tel:$phoneNumber');
    },
          );
        },
      ),
    );
  }
}
