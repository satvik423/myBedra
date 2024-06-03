import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybedra/Grocery.dart';
import 'package:mybedra/BusSelectPage.dart';
import 'package:mybedra/autoselect.dart';
import 'package:mybedra/food.dart';
import 'package:mybedra/categories.dart';
import 'package:mybedra/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Widgets/carousalSlider.dart';

class tempHomePageSliver extends StatefulWidget {
  tempHomePageSliver({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<tempHomePageSliver> {
  int activePage = 1;
  int _currentPage = 1;
  late Timer _timer;


  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  final _imageUrls = [
    "https://upload.wikimedia.org/wikipedia/commons/b/b7/Thousand_Piller_Temple%2C_Moodbidri.jpg",
    "https://metrosaga.com/wp-content/uploads/2019/04/Konaje-1-803x420.jpg",
    "https://www.aiet.org.in/wp-content/uploads/2020/08/AE-04.jpg",
    "https://th-i.thgim.com/public/incoming/fzxbbn/article65772922.ece/alternates/LANDSCAPE_1200/16_mn%20Alvas%20%281%29.jpg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 100,
            leadingWidth: 0,
            floating: true,
            pinned: true,
            backgroundColor: Colors.white,
            snap: false,
            centerTitle: false,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Welcome to myBedra",
                    style: GoogleFonts.bebasNeue(
                        fontSize: 30, color: Colors.black54),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/cmlogo.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ],
          ),

          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        MyImageCarousel(imageUrls: _imageUrls),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      child: Text("Search by Categories", style: GoogleFonts.bebasNeue(fontSize: 25,color: Colors.grey),)),
                  Container(
                    child: Categories(),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      child: Text("Digital Guide",  style: GoogleFonts.bebasNeue(fontSize: 35,color: Colors.grey),)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: _buildProgrammCardBus(context)),
                      Expanded(child: _buildProgrammCardAuto(context)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: _buildProgrammCardFood(context)),
                      Expanded(child: _buildProgrammCardGross(context)),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

Widget _buildProgrammCardAuto(context) {
  return Container(
    margin: EdgeInsets.fromLTRB(4, 0, 2, 0),
    height: 120,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: yellowColor,
      child: InkWell(
        splashColor: Colors.white.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AutoSelect(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          height: 30,
                          child: Image.asset(
                            'assets/images/auto.png',
                            color: Colors.white,
                            height: 30,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.forward,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  height: 30,
                  child: Text('Auto Rikshaw',
                      style: GoogleFonts.bebasNeue(fontSize: 18,color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildProgrammCardBus(context) {
  return Container(
    margin: EdgeInsets.fromLTRB(4, 0, 2, 0),
    height: 120,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: blueColorDark,
      child: InkWell(
        splashColor: Colors.white.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusSelectPage(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          height: 50,
                          width: 50,
                          child: Image.asset(
                            'assets/images/bussidelogo.png',
                            color: Colors.white,
                            height: 70,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.forward,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  height: 30,
                  child: Text(
                    'Buses',
                    style: GoogleFonts.bebasNeue(fontSize: 18,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildProgrammCardFood(context) {
  return Container(
    margin: EdgeInsets.fromLTRB(4, 0, 2, 0),
    height: 120,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: OrangeDark,
      child: InkWell(
        splashColor: Colors.white.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodScreen(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          height: 80,
                          child: Image.asset(
                            'assets/images/dinner.png',
                            color: Colors.white,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.forward,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  height: 30,
                  child: Text('Food',
                      style: GoogleFonts.bebasNeue(fontSize: 18,color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildProgrammCardGross(BuildContext context) {
  return Container(
    margin: EdgeInsets.fromLTRB(4, 0, 2, 0),
    height: 120,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: GreenColor,
      child: InkWell(
        splashColor: Colors.white.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroceryScreen(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          height: 80,
                          child: Image.asset(
                            'assets/images/grocery.png',
                            color: Colors.white,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      CupertinoIcons.forward,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  height: 30,
                  child: Text(
                    'Groceries',
                    style: GoogleFonts.bebasNeue(fontSize: 18,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

