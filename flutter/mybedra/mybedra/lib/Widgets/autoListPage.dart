// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:mybedra/Models/AutoModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:velocity_x/velocity_x.dart';

class AutoListPage extends StatefulWidget {
  AutoListPage({Key? key}) : super(key: key);

  @override
  State<AutoListPage> createState() => _AutoListPageState();
}

class _AutoListPageState extends State<AutoListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: AutoModel.autolist.length,
      itemBuilder: (context, index) {
        final catalog = AutoModel.autolist[index];

        return InkWell(
          // onTap: () => {Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => HomeDetailPage(catalog: catalog),
          //   ),
          // )},
          child: TrekkItem(catalog: catalog),
        );
      },
    );
  }
}

class TrekkItem extends StatelessWidget {
  final Autos catalog;

  const TrekkItem({Key? key, required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: GestureDetector(
        onTap: () {
          String phoneNumber = catalog.auto_number.toString();
          launch('tel:$phoneNumber');
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(Icons.local_taxi_outlined),
                          ),
                          Expanded(
                            child: Text(
                              catalog.auto_name.toString(),
                              maxLines: 1,
                              softWrap: false,
                              style: GoogleFonts.bebasNeue(fontSize: 30),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(Icons.local_taxi_outlined),
                          ),
                          Expanded(
                            child: Text(
                              catalog.auto_stand.toString(),
                              maxLines: 1,
                              softWrap: false,
                              style: GoogleFonts.bebasNeue(fontSize: 30),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(2, 0, 4, 0),
                      alignment: Alignment.centerRight,
                      child: Text(
                        catalog.auto_number.toString(),
                        style: GoogleFonts.bebasNeue(fontSize: 30),
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(vertical: 1),
              height: 24.0,
            ).h10(context),
          ),
        ),
      ),
    );
  }

  Future<void> contactDial(String number) async {
    await _launchCaller(number);
  }

  _launchCaller(String number) async {
    String url = Platform.isIOS ? 'tel://$number' : 'tel:$number';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
