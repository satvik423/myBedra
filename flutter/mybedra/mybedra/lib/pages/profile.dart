import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybedra/components/my_button.dart';
import 'package:mybedra/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("User");

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> editField(String field) async {
    if (field == 'phoneNumber') {
      editPhoneNumberField(field);
    } else {
      String newValue = "";
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.grey[900],
                title: Text(
                  "Edit ${field}",
                  style:
                      GoogleFonts.bebasNeue(fontSize: 20, color: Colors.white),
                ),
                content: TextField(
                  autofocus: true,
                  style:
                      GoogleFonts.bebasNeue(fontSize: 20, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter new $field",
                    hintStyle: GoogleFonts.bebasNeue(
                        fontSize: 20, color: Colors.white),
                  ),
                  onChanged: (value) {
                    newValue = value;
                  },
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: "Cancel",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyButton(
                      onTap: () {
                        Navigator.of(context).pop(newValue);
                      },
                      text: "Save",
                    ),
                  ),
                ],
              ));
      //update in firestore
      if (newValue.trim().length > 0) {
        await userCollection.doc(currentUser.email!).update({field: newValue});
      }
    }
  }

  Future<void> editPhoneNumberField(String field) async {
    String newValue = "";
    bool showError = false; // Track if error message should be shown

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.grey[900],
            title: Text(
              "Edit $field",
              style: GoogleFonts.bebasNeue(fontSize: 20, color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  autofocus: true,
                  style:
                      GoogleFonts.bebasNeue(fontSize: 20, color: Colors.white),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  decoration: InputDecoration(
                    hintText: "Enter new $field",
                    hintStyle: GoogleFonts.bebasNeue(
                        fontSize: 20, color: Colors.white),
                  ),
                  onChanged: (value) {
                    newValue = value;
                    setState(() {
                      showError = value.trim().length < 10 ||
                          !RegExp(r'^[6-9]').hasMatch(value);
                    });
                  },
                ),
                if (showError) // Show error message if showError is true
                  Text(
                    "Enter a valid phone number",
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: "Cancel",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                  onTap: () {
                    if (!showError) {
                      Navigator.of(context).pop(newValue);
                    }
                  },
                  text: "Save",
                ),
              ),
            ],
          );
        },
      ),
    );

    // Update in Firestore
    if (newValue.trim().length > 0) {
      await userCollection.doc(currentUser.email!).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile Page",
            style: GoogleFonts.bebasNeue(fontSize: 30),
          ),
          backgroundColor: Colors.grey,
          actions: [
            IconButton(onPressed: signUserOut, icon: Icon(Icons.logout)),
          ],
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("User")
              .doc(currentUser.email)
              .snapshots(),
          builder: (context, snapshot) {
            // get user data
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return ListView(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Icon(
                    Icons.person,
                    size: 100,
                  ),
                  Text(
                    currentUser.email!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.bebasNeue(
                        fontSize: 15, color: Colors.grey[700]),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Text(
                      "My Details",
                      style: GoogleFonts.bebasNeue(fontSize: 20),
                    ),
                  ),
                  //username
                  MyTextBox(
                    text: userData['username'],
                    sectionName: "User Name",
                    onPressed: () => editField('username'),
                  ),
                  //bio
                  MyTextBox(
                    text: userData['address'],
                    sectionName: "address",
                    onPressed: () => editField('address'),
                  ),
                  //phoneNumber
                  MyTextBox(
                    text: userData['phoneNumber'],
                    sectionName: "Phone Number",
                    onPressed: () => editField('phoneNumber'),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
