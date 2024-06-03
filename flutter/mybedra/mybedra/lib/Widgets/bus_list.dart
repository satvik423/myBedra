// ignore_for_file: unused_import, unnecessary_null_comparison

import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:mybedra/getBuses.dart';
import 'package:mybedra/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:velocity_x/velocity_x.dart';

class BusList extends StatefulWidget {
  @override
  State<BusList> createState() => _BusListState();
}

class _BusListState extends State<BusList> {
  final double _height = 100;

  final _scrollController = ScrollController();
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: busModel.buslist.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          final catalog = busModel.buslist[index];
          if (!flag) {
            flag = true;
            _scrollToIndex(9);
          }
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
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
              _scrollToIndex(9);
            },
            backgroundColor: blueColorDark,
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  void _scrollToIndex(index) {
    _scrollController.animateTo(_height * index,
        duration: const Duration(milliseconds: 1000), curve: Curves.easeIn);
  }
}

class TrekkItem extends StatelessWidget {
  final Buses catalog;

  const TrekkItem({Key? key, required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
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
                          child: const Icon(Icons.bus_alert_sharp),
                        ),
                        Expanded(
                          child: Text(
                            catalog.bus_name.toString(),
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
                          child: const Icon(Icons.route),
                        ),
                        Expanded(
                          child: Text(
                            catalog.destination_name.toString(),
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
                          utcTo12HourFormat(catalog.bus_time.toString()),
                          style: GoogleFonts.bebasNeue(fontSize: 30),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis)),
                ),
              ],
            ),
            padding: EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 1),
            height: 24.0,
          ).h8(context),
        ),
      ),
    );
  }

  String utcTo12HourFormat(String bigTime) {
    if (bigTime.length == 3) {
      bigTime = '0' + bigTime;
    }
    bigTime = bigTime.substring(0, 2) + ':' + bigTime.substring(2, 4);
    DateTime tempDate = DateFormat("hh:mm").parse(bigTime);
    //  var dateFormat = DateFormat("h:mm a"); // you can change the format here
    //  var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    //  var localDate = dateFormat.parse(utcDate, true).toLocal().toString();

    final DateFormat formatter = DateFormat('h:mm a');
    final String formatted = formatter.format(tempDate);
    print(formatted);
    // String createdDate = dateFormat.format(DateTime.parse(localDate));
    //print("------------$createdDate");
    return formatted;
  }
}
