import 'package:mybedra/TextStyles.dart';
import 'package:mybedra/consts.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          backgroundColor: kwhite,
          title: BoldText("Offers in Bedra", 25, kblack),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              notification2(),
              notification1(),
            ],
          ),
        ));
  }

  Padding notification1() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 100,
        child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BoldText("15% off on Shawarma", 20.0, kblack),
                    Icon(
                      Icons.more_horiz,
                      size: 20.0,
                      color: kblack,
                    )
                  ],
                ),
                NormalText("Arabian", kgreyDark, 16),
                NormalText("hurry now - valid from 7:00 PM to 10:00 PM",
                    kdarkBlue, 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Padding notification2() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      height: 100,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BoldText("Alfa Codes", 20.0, kblack),
                  Icon(
                    Icons.more_horiz,
                    size: 20.0,
                    color: kblack,
                  )
                ],
              ),
              NormalText("Follow on intasgram", kgreyDark, 16),
              NormalText("www.instagram.com/alfacodes", kdarkBlue, 12),
            ],
          ),
        ),
      ),
    ),
  );
}

Padding notification3() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      height: 100,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  BoldText("creative alfaz", 20.0, kblack),
                  Icon(
                    Icons.more_horiz,
                    size: 20.0,
                    color: kblack,
                  )
                ],
              ),
              NormalText("Follow on intasgram", kgreyDark, 16),
              NormalText("www.instagram.com/alfacodes", kdarkBlue, 12),
            ],
          ),
        ),
      ),
    ),
  );
}
