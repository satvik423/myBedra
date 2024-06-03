// ignore_for_file: unused_import, unused_field

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:mybedra/pages/Profile.dart';

import 'package:mybedra/TextStyles.dart';
import 'package:mybedra/categories.dart';
import 'package:mybedra/consts.dart';
import 'package:mybedra/themes.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'Widgets/carousalSlider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _ListviewPageState();
}

class _ListviewPageState extends State<HomePage> {
  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg"
  ];

  int activePage = 1;
  int _currentPage = 0;
  late Timer _timer;

  bool _isSearchValid = false;
  bool _isPasswordValid = false;

  bool _isHidePassword = false;
  bool _isLogin = false;

  final _pageController = PageController(viewportFraction: 0.8, initialPage: 1);

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  final TextEditingController _searchController = TextEditingController();
  final _imageUrls = [
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__340.jpg",
    "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__340.jpg",
    "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__340.jpg"
  ];

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.black : Colors.black26,
            shape: BoxShape.circle),
      );
    });
  }

  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C'
  ];
  final List<int> colorCodes = <int>[
    600,
    500,
    100,
    600,
    500,
    100,
    600,
    500,
    100
  ];

  final List<String> myimages = <String>[
    'assets/images/alfacodes.png',
    'assets/images/alfacodes.png',
    'assets/images/alfacodes.png',
    'assets/images/alfacodes.png',
    'assets/images/alfacodes.png',
    'assets/images/alfacodes.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Hi, AlfaCodes",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(32, 0, 8, 8),
                        child: Text(
                          "Welcome to Connect Moodbidri",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/cmlogo.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                ],
              ),

              Container(
                margin: EdgeInsets.all(12),
                height: 50,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: greyBorderColor,
                    width: 0.3,
                  ),
                ),
                child: TextFormField(
                  controller: _searchController,
                  cursorColor: Colors.black26,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search : Advocates, Restaurants etc..',
                    hintStyle: TextStyle(
                      color: greyDarkColor,
                      fontSize: 14,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isSearchValid = !_isSearchValid;
                          _searchController.clear();
                        });
                      },
                      child: _isSearchValid ? Icon(Icons.search) : SizedBox(),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isSearchValid = value.length >= 1;
                    });
                  },
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: PageView.builder(
                        itemCount: _imageUrls.length,
                        pageSnapping: false,
                        controller: _pageController,
                        onPageChanged: (_currentPage) {
                          setState(() {
                            activePage = _currentPage;
                          });
                        },
                        itemBuilder: (context, pagePosition) {
                          return Container(
                            margin: EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                scale: 0.8,
                                image: NetworkImage(_imageUrls[pagePosition]),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          );

                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(8),
                          //   child: Image.network(

                          //     _imageUrls[pagePosition],
                          //     scale: 1.2,
                          //   ),
                          // );
                        }),
                  ),
                ],
              ),
              MyImageCarousel(imageUrls: [
                "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__340.jpg",
                "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__340.jpg",
                "https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455__340.jpg"
              ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicators(_imageUrls.length, activePage)),

              Container(
                  margin: EdgeInsets.all(12),
                  alignment: Alignment.centerLeft,
                  child: NormalText("Search by Categories", kgreyDark, 16)),
              //  SearchList(),
              //buildFloatingSearchBar(context),
              Container(
                child: Categories(),
                alignment: Alignment.centerLeft,
              ),
              // Stack(
              //   children: [],
              // ),

              // CarouselSlider(
              //   options: CarouselOptions(height: 400.0),
              //   items: [myimages].map((i) {
              //     return Builder(
              //       builder: (BuildContext context) {
              //         return Container(
              //             width: MediaQuery.of(context).size.width,
              //             margin: EdgeInsets.symmetric(horizontal: 5.0),
              //             decoration: BoxDecoration(color: Colors.amber),
              //             child: Text(
              //               '$i',
              //               style: TextStyle(fontSize: 16.0),
              //             ));
              //       },
              //     );
              //   }).toList(),
              // ),
              // Container(
              //   height: 300,
              //   child: ListView.separated(
              //     padding: const EdgeInsets.all(8),
              //     itemCount: entries.length,
              //     scrollDirection: Axis.vertical,
              //     shrinkWrap: true,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Container(
              //         height: 50,
              //         color: Colors.amber[colorCodes[index]],
              //         child: Center(child: Text('Entry ${entries[index]}')),
              //       );
              //     },
              //     separatorBuilder: (BuildContext context, int index) =>
              //         const Divider(),
              //   ),
              // ),
              // Container(
              //   height: 200,
              //   child: ListView.builder(
              //       padding: const EdgeInsets.all(20),
              //       itemCount: entries.length,
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (BuildContext context, int index) {
              //         return Card(
              //           color: Colors.amber[colorCodes[index]],
              //           child: Center(
              //               child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text('Entry ${entries[index]}'),
              //           )),
              //         );
              //       }),
              // ),
              // Container(
              //   height: 100.0,
              //   child: ListView.builder(
              //     itemCount: myimages.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Card(
              //           child: Container(
              //         width: 130.0,
              //         child: Align(
              //           alignment: Alignment.center,
              //           child: Image.asset(
              //             '${myimages[index]}',
              //             width: 60,
              //             height: 60,
              //           ),
              //         ),
              //         alignment: Alignment.center,
              //       ));
              //     },
              //     scrollDirection: Axis.horizontal,
              //   ),
              // ),
              Container(
                height: 100.0,
                child: ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: Container(
                      width: 130.0,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Entry ${entries[index]}'),
                      ),
                      alignment: Alignment.center,
                    ));
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlertBox extends StatelessWidget {
  const AlertBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.amber)),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: Text("Show Alert Dialog"),
    );
  }
}
