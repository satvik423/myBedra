import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybedra/pages/profile.dart';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybedra/themes.dart';

import 'GetPath.dart';

// void main() {
//   runApp(MaterialApp(
//     home: GroceryScreen(),
//     theme: ThemeData(brightness: Brightness.dark),
//   ));
// }

class GroceryScreen extends StatefulWidget {
  @override
  _GroceryScreenState createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  List<Map<String, dynamic>> groceryItems = [];
  List<Map<String, dynamic>> cartItems = [];

  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  List<Map<String, dynamic>> searchedItems = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    GetUrl serverPath = GetUrl();
    final response =
        await http.get(Uri.parse(serverPath.url + 'grocery_fetch'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      setState(() {
        groceryItems =
            data.map((item) => Map<String, dynamic>.from(item)).toList();
      });
    }
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void addToCart(Map<String, dynamic> item) {
    final itemName = item['item_name'];
    final itemPrice = item['item_price'];

    // Check if the item already exists in the cart
    final existingItem =
        cartItems.firstWhereOrNull((cartItem) => cartItem['name'] == itemName);

    if (existingItem != null) {
      // Item already exists in the cart
      // You can show a message or perform any other action
      print('Item already in cart');
      return;
    }

    // Add the item to the cart
    setState(() {
      cartItems.add({
        'name': itemName,
        'price': itemPrice,
      });
    });
  }

  void openProfileView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  void openCartView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cartItems: cartItems),
      ),
    );
  }

  void searchItems(String searchTerm) async {
    setState(() {
      isSearching = true;
    });
    GetUrl serverPath = GetUrl();
    final url = serverPath.url + 'grocery_search';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'searchTerm': searchTerm}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      setState(() {
        searchedItems =
            data.map((item) => Map<String, dynamic>.from(item)).toList();
      });
    } else {
      // Handle the API error
      // ...
    }
  }

  void _performSearch(String searchTerm) {
    if (searchTerm.isNotEmpty) {
      searchItems(searchTerm);
      setState(() {
        isSearching = true; // Set isSearching to true when performing search
      });
    } else {
      setState(() {
        searchedItems = List<Map<String, dynamic>>.from(groceryItems);
        isSearching = false; // Set isSearching to false when not searching
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GreenColor,
        title: Text(
          'Grocery',
          style: GoogleFonts.bebasNeue(fontSize: 30),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              openCartView(context);
            },
          ),
          // IconButton(onPressed: openProfileView, icon: Icon(Icons.man)),
        ],
      ),
      body: Column(
        children: [
          CustomSearchBar(
            controller: searchController,
            isSearching: isSearching,
            onSearch: _performSearch,
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    mainAxisExtent: 250,
                  ),
                  itemCount:
                      isSearching ? searchedItems.length : groceryItems.length,
                  itemBuilder: (ctx, index) {
                    final item = isSearching
                        ? searchedItems[index]
                        : groceryItems[index];
                    final String imagePath = item['item_image'];

                    return Card(
                      shape: RoundedRectangleBorder(
                          // color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: GreenColor)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 10.0, right: 10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                imagePath,
                                height: 100,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  item['item_name'],
                                  style: GoogleFonts.bebasNeue(fontSize: 20),
                                ),
                                Text(
                                  '\₹${item['item_price']}',
                                  style: GoogleFonts.bebasNeue(fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      addToCart(item);
                                    },
                                    child: Text(
                                      'Add to Cart',
                                      style:
                                          GoogleFonts.bebasNeue(fontSize: 20),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<double> quantities = [];

  @override
  void initState() {
    super.initState();
    quantities = List<double>.filled(widget.cartItems.length, 1.0);
  }

  final user = FirebaseAuth.instance.currentUser!;

  void incrementQuantity(int index) {
    setState(() {
      quantities[index] += 0.25;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (quantities[index] > 0.25) {
        quantities[index] -= 0.25;
      }
    });
  }

  void placeOrder() async {
    double totalPrice = 0.0;
    List<Map<String, dynamic>> orderedItems = [];
    // Fetch user data from Firebase Firestore
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection("User")
        .doc(user.email)
        .get();
    for (int i = 0; i < widget.cartItems.length; i++) {
      final item = widget.cartItems[i];
      final quantity = quantities[i];
      final price = item['price']; // Parse the price as an integer
      totalPrice += price * quantity;

      if (userData.exists) {
        if (userData['address'] != "" && userData['phoneNumber'] != "") {
          Map<String, dynamic> orderedItem = {
            'user_name': user.email!,
            'item_name': item['name'],
            'item_price': price,
            'quantity': quantity,
            'address': userData['address'],
            'phoneNumber': userData['phoneNumber'],
          };
          orderedItems.add(orderedItem);
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Theme(
                data: Theme.of(context).copyWith(
                  dialogTheme: DialogTheme(
                    elevation: 0, // Set the elevation to 0 to remove the shadow
                  ),
                ),
                child: AlertDialog(
                  title: Text(
                    "Incomplete Profile Information",
                    style: GoogleFonts.bebasNeue(
                        fontSize: 20, color: Colors.redAccent),
                  ),
                  content: Text(
                    'We noticed that some required information is missing from your profile. Please provide your phone number and address to complete your profile. This information is essential for us to provide you with the best possible service and ensure smooth communication. Thank you for your cooperation!',
                    style: GoogleFonts.bebasNeue(fontSize: 20),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style: GoogleFonts.bebasNeue(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
          break;
        }
      }
    }

    if (userData['address'] != "" && userData['phoneNumber'] != "") {
      if (!orderedItems.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: Theme.of(context).copyWith(
                dialogTheme: DialogTheme(
                  elevation: 0,
                ),
              ),
              child: AlertDialog(
                title: Text(
                  'ORDER SUCCESSFULL',
                  style: GoogleFonts.bebasNeue(fontSize: 20),
                ),
                content: Text(
                  'Total Bill: ₹${totalPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.bebasNeue(fontSize: 20),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      sendOrderToAPI(orderedItems);
                    },
                    child: Text(
                      'OK',
                      style: GoogleFonts.bebasNeue(fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: Theme.of(context).copyWith(
                dialogTheme: DialogTheme(
                  elevation: 0,
                ),
              ),
              child: AlertDialog(
                title: Text(
                  'No items',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 20,
                  ),
                ),
                content: Text(
                  'add items to cart to place order',
                  style: GoogleFonts.bebasNeue(fontSize: 20),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      sendOrderToAPI(orderedItems);
                    },
                    child: Text(
                      'OK',
                      style: GoogleFonts.bebasNeue(fontSize: 20),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    }else{
      showDialog(
            context: context,
            builder: (BuildContext context) {
              return Theme(
                data: Theme.of(context).copyWith(
                  dialogTheme: DialogTheme(
                    elevation: 0, // Set the elevation to 0 to remove the shadow
                  ),
                ),
                child: AlertDialog(
                  title: Text(
                    "Incomplete Profile Information",
                    style: GoogleFonts.bebasNeue(
                        fontSize: 20, color: Colors.redAccent),
                  ),
                  content: Text(
                    'We noticed that some required information is missing from your profile. Please provide your phone number and address to complete your profile. This information is essential for us to provide you with the best possible service and ensure smooth communication. Thank you for your cooperation!',
                    style: GoogleFonts.bebasNeue(fontSize: 20),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style: GoogleFonts.bebasNeue(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
    }
  }

  void sendOrderToAPI(List<Map<String, dynamic>> orderedItems) {
    GetUrl serverPath = GetUrl();

    final url = serverPath.url + 'grocery_ordered';
    http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(orderedItems),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: GreenColor,
        title: Text(
          'Cart',
          style: GoogleFonts.bebasNeue(fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            mainAxisExtent: 120,
          ),
          itemCount: widget.cartItems.length,
          itemBuilder: (ctx, index) {
            final item = widget.cartItems[index];
            final quantity = quantities[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    Text(
                      item['name'],
                      style: GoogleFonts.bebasNeue(
                          fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      '₹${item['price']}',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 20, color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            decrementQuantity(index);
                          },
                          icon: Icon(Icons.remove),
                          color: Colors.black,
                        ),
                        Text(
                          quantity.toString(),
                          style: GoogleFonts.bebasNeue(
                              fontSize: 20, color: Colors.black),
                        ),
                        IconButton(
                          onPressed: () {
                            incrementQuantity(index);
                          },
                          icon: Icon(Icons.add),
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          placeOrder();
        },
        label: Text(
          'Place Order',
          style: GoogleFonts.bebasNeue(fontSize: 20),
        ),
        icon: Icon(Icons.shopping_cart),
        elevation: 0,
      ),
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final bool isSearching;
  final Function(String) onSearch;

  const CustomSearchBar({
    required this.controller,
    required this.isSearching,
    required this.onSearch,
  });

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  void _handleSearch() {
    final searchTerm = widget.controller.text;
    widget.onSearch(searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              style: TextStyle(color: Colors.blueGrey),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.blueGrey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _handleSearch,
            color: Colors.blueGrey,
            disabledColor: Colors.black, // Add this line
          ),
        ],
      ),
    );
  }
}
