// ignore_for_file: unused_import, unnecessary_null_comparison

import 'dart:io';

import 'package:mybedra/GetPath.dart';
import 'package:mybedra/Models/ResultModel.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:velocity_x/velocity_x.dart';

class ResultListPage extends StatefulWidget {
  ResultListPage({Key? key}) : super(key: key);

  @override
  State<ResultListPage> createState() => _ResultListPageState();
}

class _ResultListPageState extends State<ResultListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: ResultModel.resultList.length,
        itemBuilder: (context, index) {
          final catalog = ResultModel.resultList[index];

          return InkWell(
            // onTap: () => {Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => HomeDetailPage(catalog: catalog),
            //   ),
            // )},
            child: ResultItem(catalog: catalog),
          );
        },
      ),
    );
  }
}

class ResultItem extends StatelessWidget {
  final Result catalog;

  const ResultItem({Key? key, required this.catalog})
      : assert(catalog != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    GetUrl serverPath = GetUrl();
    return Hero(
      tag: Key(catalog.name.toString()),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          //   debugPrint('calling' + catalog.auto_number.toString());
          // _launchCaller(catalog.auto_number.toString());
          // contactDial("8105969290");
          // _makingPhoneCall(catalog.auto_number.toString());
          // launch("tel:" + catalog.auto_number.toString());
        },
        child: Container(
          //  height: 200,
          alignment: Alignment.centerLeft,
          child: Card(
            // color: Colors.lightGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (catalog.imgPath.toString() != 'NA')

                    // Image.network(
                    //   serverPath.imgurl + catalog.imgPath,
                    //   fit: BoxFit.fill,
                    //   errorBuilder: (BuildContext context, Object exception,
                    //       StackTrace? stackTrace) {
                    //     // Appropriate logging or analytics, e.g.
                    //     // myAnalytics.recordError(
                    //     //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                    //     //   exception,
                    //     //   stackTrace,
                    //     // );
                    //     return Text('hello');
                    //   },
                    // )

                    ImageWidget(
                        context, serverPath.imgurl + catalog.imgPath.toString())
                  else
                    SizedBox(

                        // child: CircularProgressIndicator(
                        //   color: Colors.red,
                        // ).centered().expand(),
                        ),
                  Container(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      catalog.name.toString(),
                      maxLines: 2,
                      softWrap: false,
                      style: TextStyle(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(6),
                      alignment: Alignment.centerLeft,
                      child: Text(catalog.category.toString(),
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis)),
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      catalog.contact1.text
                          .maxLines(2)
                          .overflow(TextOverflow.ellipsis)
                          .make(),
                      SizedBox(
                        width: 20,
                      ),
                      catalog.contact2.text
                          .maxLines(2)
                          .overflow(TextOverflow.ellipsis)
                          .make(),
                    ],
                  ).p12(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget ImageWidget(context, String Imgpath) {
  try {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(16, 16),
          topRight: Radius.elliptical(16, 16)),
      child:
          // Image.network(
          //   Imgpath,
          //   fit: BoxFit.fill,
          // ),
          // if (NextBusTime != '')
          //               timeWidget(context, NextBusTime, NextBusNAme)
          //             else
          //               CircularProgressIndicator(
          //                 color: Colors.white,
          //               ).centered().expand(),
          Image.network(
        Imgpath,
        fit: BoxFit.fill,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          // Appropriate logging or analytics, e.g.
          // myAnalytics.recordError(
          //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
          //   exception,
          //   stackTrace,
          // );
          //rethr;
          return Text('');
        },
      ),
    );
  } catch (err) {
    return Text(
      'cannot load',
      style: TextStyle(color: Colors.red),
    );
  }
}
