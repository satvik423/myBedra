import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybedra/consts.dart';
import 'package:mybedra/pages/profile.dart';
import 'package:mybedra/tempHomePageSliver.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _cIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 100), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      bottomNavigationBar: BottomNavyBar(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          selectedIndex: _cIndex,
          showElevation: true,
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.home),
              activeColor: Colors.green,
              inactiveColor: kgreyDark,
              title: Text(
                "Home",
                style: GoogleFonts.bebasNeue(fontSize: 20,color: Colors.white),
              ),
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.person),
              title: Text(
                "Profile",
                style: GoogleFonts.bebasNeue(fontSize: 20,color: Colors.white),
              ),
              inactiveColor: kgreyDark,
              activeColor: Colors.orange,
            )
          ],
          onItemSelected: (index) {
            _incrementTab(index);
          }),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _cIndex = index);
          },
          children: <Widget>[
            tempHomePageSliver(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
