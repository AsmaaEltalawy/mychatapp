import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mychatapp/services/auth_services.dart';
import 'package:mychatapp/wedgets/my_button.dart';
import 'package:mychatapp/wedgets/square_image.dart';

import '../wedgets/my_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final authServiceObject = AuthServices();

 void login(BuildContext context)  {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            color: Color(0xFF264131),
          ));
        });
    authServiceObject.login(context, emailController.text, passController.text);
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
              color: Color(0xFF264131),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forget Password',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                SizedBox(
                  width: 24,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            MyButton(
              text: 'LogIn',
              onTap: () => login(context),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a member'),
                SizedBox(
                  width: 4,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/registerScreen');
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Color(0xFF264131), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
