import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import '../wedgets/my_button.dart';
import '../wedgets/my_textfield.dart';
import '../wedgets/square_image.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final authServiceObject = AuthServices();

  void register(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            color: Color(0xFF264131),
          ));
        });
    authServiceObject.register(context, emailController.text,
        passController.text, confirmPassController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Icon(
              Icons.lock,
              color:Color(0xFF264131),
              size: 100,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Welcome back ,you have been missed',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 24,
            ),
            MyTextField(
              text: 'Email',
              obsecureText: false,
              controller: emailController,
            ),
            MyTextField(
                controller: passController,
                text: 'Password',
                obsecureText: true),
            MyTextField(
                controller: confirmPassController,
                text: 'Confirm Password',
                obsecureText: true),
            SizedBox(
              height: 10,
            ),
            MyButton(
              text: 'Register',
              onTap: () => register(context),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareImage(imagePath: 'assets/images/gmail.png'),
                SquareImage(imagePath: 'assets/images/iphone.png'),
              ],
            ),
            SizedBox(
              height: 50,
            ),
          ],
        )),
      ),
    );
  }
}
