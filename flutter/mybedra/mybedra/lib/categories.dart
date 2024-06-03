import 'package:flutter/material.dart';
import 'package:mybedra/imagesearch.dart';

class Categories extends StatefulWidget {
  Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String searchItem = "";
    void openCartView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageSearch(searchItem: searchItem),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                      child: GestureDetector(
                        onTap: () {
                          searchItem = "Rest";
                          openCartView(context);
                          },
                        child: Image.asset(
                          'assets/images/dinner.png',
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 54,
                      child: new Text("Restaurants",
                          style: new TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(10.0)),
                          color: Colors.black54),
                      padding: new EdgeInsets.fromLTRB(8, 4, 8, 4),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                      child: GestureDetector(
                        onTap: () {
                          searchItem = "Fur";
                          openCartView(context);
                          },
                        child: Image.asset(
                          'assets/images/sofa.png',
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 54,
                      child: new Text("Furnites",
                          style: new TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(10.0)),
                          color: Colors.black54),
                      padding: new EdgeInsets.fromLTRB(8, 4, 8, 4),
                    ),
                  ],
                ),
              ),
            ),
      Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                      child: GestureDetector(
                        onTap: () {
                          searchItem = "Hosp";
                          openCartView(context);
                          },
                        child: Image.asset(
                          'assets/images/pharmacy.png',
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 54,
                      child: new Text("Hospitals",
                          style: new TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(10.0)),
                          color: Colors.black54),
                      padding: new EdgeInsets.fromLTRB(8, 4, 8, 4),
                    ),
                  ],
                ),
              ),
            ),
                  Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                      child: GestureDetector(
                        onTap: () {
                          searchItem = "Paying";
                          openCartView(context);
                          },
                        child: Image.asset(
                          'assets/images/house.png',
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 54,
                      child: new Text("Paying Guest",
                          style: new TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(10.0)),
                          color: Colors.black54),
                      padding: new EdgeInsets.fromLTRB(8, 4, 8, 4),
                    ),
                  ],
                ),
              ),
            ),
               Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                      child: GestureDetector(
                        onTap: () {
                          searchItem = "Advocate";
                          openCartView(context);
                          },
                        child: Image.asset(
                          'assets/images/advocate.png',
                          width: 50.0,
                          height: 50.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 54,
                      child: new Text("Advocates",
                          style: new TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(10.0)),
                          color: Colors.black54),
                      padding: new EdgeInsets.fromLTRB(8, 4, 8, 4),
                    ),
                  ],
                ),
              ),
            ),
            
            Container(
              margin: EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                      child: Image.asset(
                        'assets/images/hote.png',
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 54,
                      child: new Text("Hotels",
                          style: new TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 8,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      decoration: new BoxDecoration(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(10.0)),
                          color: Colors.black54),
                      padding: new EdgeInsets.fromLTRB(8, 4, 8, 4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
