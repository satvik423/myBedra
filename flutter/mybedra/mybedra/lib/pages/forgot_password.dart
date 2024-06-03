import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  final dynamic Function()? onTap;
  const ForgotPasswordPage({super.key, required this.onTap});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.purple,
            title: Text(
              message.toString(),
            ));
      },
    );
  }

  void resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
          showDialog(context: context, builder: ((context) {
            return AlertDialog(
              content: Text("Password reset link sent! Check your mail"),
            );
          }));
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter your email and we will send you a password reset link!",
              textAlign: TextAlign.center,
              style: GoogleFonts.bebasNeue(fontSize: 20, color: Colors.grey[700]),
            ),
            const SizedBox(height: 10),
            // username textfield
            MyTextField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),
            const SizedBox(height: 10),
            MyButton(
              onTap: resetPassword,
              text: "reset password",
            ),
          ],
        ),
      ),
    );
  }
}
