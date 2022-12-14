import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordRest() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            content: Text("Password reset link sent. Check your Inbox."),
          );
        }),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            content: Text(
              e.message.toString(),
            ),
          );
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Hello"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text("Enter your email. We will send reset link to you.",
                textAlign: TextAlign.center),
          ),

          SizedBox(height: 10),
          //Email Textfield
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  controller: _emailController, //Email Text field controller.
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          MaterialButton(
            onPressed: () {
              passwordRest();
            },
            child: Text("Reset Password"),
            color: Colors.deepPurple,
          )
        ],
      ),
    );
  }
}
