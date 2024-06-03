import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mybedra/components/my_button.dart';
import 'package:mybedra/components/my_textfield.dart';
import 'package:mybedra/components/square_tile.dart';
import 'package:mybedra/services/auth_service.dart';

class ResgisterPage extends StatefulWidget {
  final Function()? onTap;

  const ResgisterPage({super.key, required this.onTap});

  @override
  State<ResgisterPage> createState() => _ResgisterPageState();
}

class _ResgisterPageState extends State<ResgisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final comfirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Cancel any active work or subscriptions here
    // before the state is disposed
    super.dispose();
  }

  // sign user in method
  void signUserUp() async {
    if (!mounted) return;
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    if (emailController.text.isEmpty || passwordController.text.isEmpty || comfirmPasswordController.text.isEmpty) {
      Navigator.pop(context);
      showErrorMessage('Please fill in all fields');
      return;
    }
    //check if confirm password is same as password
    if (passwordController.text == comfirmPasswordController.text) {
      if (!isValidEmail(emailController.text)) {
      Navigator.pop(context);
      showErrorMessage('Invalid email');
      return;
    }
    final passwordValidationResult = validatePassword(passwordController.text);
    if (passwordValidationResult != null) {
      Navigator.pop(context);
      showErrorMessage(passwordValidationResult);
      return;
    }
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        FirebaseFirestore.instance
            .collection("User")
            .doc(userCredential.user!.email)
            .set({
          'username': emailController.text.split('@')[0],
          'address': '',
          'phoneNumber': '',
        });

        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showErrorMessage(e.code);
      }
    } else {
      Navigator.pop(context);
      showErrorMessage("Password don't match");
    }
  }
  bool isValidEmail(String email) {
  final emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$',
  );
  return emailRegex.hasMatch(email);
}
String? validatePassword(String password) {
  if (password.length < 8) {
    return 'Password must have at least 8 characters';
  }

  if (!password.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one number';
  }

  if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    return 'Password must contain at least one special character';
  }

  return null;
}
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.purple,
            title: Text(
              message,
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  "assets/images/cmlogo.png",
                  height: 150,
                ),

                const SizedBox(height: 10),

                // welcome back, you've been missed!
                Text(
                  'Let\'s create a account for you',
                  style: GoogleFonts.bebasNeue(
                      fontSize: 20, color: Colors.grey[700]),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                //confirm password textfield
                MyTextField(
                  controller: comfirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // sign up button
                MyButton(
                  onTap: signUserUp,
                  text: "Sign up",
                ),

                const SizedBox(height: 22),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: GoogleFonts.bebasNeue(
                              fontSize: 20, color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'img/google.png',
                    ),




                  ],
                ),

                const SizedBox(height: 50),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have a account?',
                      style: GoogleFonts.bebasNeue(
                          fontSize: 20, color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Login now',
                        style: GoogleFonts.bebasNeue(
                            fontSize: 20, color: Colors.blue[700]),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
