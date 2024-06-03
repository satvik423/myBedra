// ignore_for_file: unused_field

import 'dart:async';

import 'package:mybedra/TextStyles.dart';
import 'package:mybedra/categories.dart';
import 'package:mybedra/consts.dart';
import 'package:mybedra/themes.dart';
import 'package:flutter/material.dart';

class HomePageSliver extends StatefulWidget {
  HomePageSliver({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageSliver> {
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

  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: Colors.white,
            snap: false,
            centerTitle: false,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Hi, AlfaCodes",
                    style: TextStyle(fontSize: 24, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "Welcome to Connect Moodbidri",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                    ),
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
            bottom: AppBar(
              backgroundColor: Colors.white,
              title: Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
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
                    style: TextStyle(fontSize: 12),
                    cursorColor: Colors.black54,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search : Advocates, Restaurants etc..',
                      hintStyle: TextStyle(
                        color: greyDarkColor,
                        fontSize: 12,
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
              ),
            ),
          ),

          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
                    child: Column(
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
                                      image: NetworkImage(
                                          _imageUrls[pagePosition]),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                indicators(_imageUrls.length, activePage)),
                      ],
                    ),
                  ),
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
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
