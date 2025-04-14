import 'package:flutter/material.dart';
import 'package:mychatapp/services/auth_services.dart';
import 'package:mychatapp/wedgets/my_button.dart';
import 'package:mychatapp/wedgets/square_image.dart';
import 'package:mychatapp/screens/chat_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final authServiceObject = AuthServices();
  final _formKey = GlobalKey<FormState>();

  Future<void> login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false, // Prevents accidental dismiss
        builder: (context) => Center(
          child: CircularProgressIndicator(color: Color(0xFF264131)),
        ),
      );

      try {
        // Perform login
        await authServiceObject.login(
            context, emailController.text, passController.text);

        // Close loading indicator before navigation
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }

        // Navigate to ChatScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
      } catch (error) {
        // Close loading dialog on error
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: $error")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Icon(Icons.lock, color: Color(0xFF264131), size: 100),
                  SizedBox(height: 50),
                  Text(
                    'Welcome back, you have been missed',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF264131)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Field cannot be empty!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF264131)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Field cannot be empty!";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      SizedBox(width: 24),
                    ],
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not a member?'),
                      SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/registerScreen');
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Color(0xFF264131),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
