import 'package:flutter/material.dart';
import 'package:mychatapp/screens/login_screen.dart';
import '../services/auth_services.dart';
import '../wedgets/my_button.dart';
import '../wedgets/square_image.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final authServiceObject = AuthServices();
  final _formKey = GlobalKey<FormState>();

  Future<void> register(BuildContext context) async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(color: Color(0xFF264131)),
        );
      },
    );

    try {
      // Perform registration
      await authServiceObject.register(
        context,
        emailController.text,
        passController.text,
        confirmPassController.text,
      );

      // Close loading dialog
      Navigator.pop(context);

      // Navigate to LoginScreen after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );

    } catch (error) {
      // Close loading dialog if an error occurs
      Navigator.pop(context);

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed: $error")),
      );
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

                // Email TextField
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email cannot be empty!";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email!";
                    }
                    return null;
                  },
                ),

                // Password TextField
                TextFormField(
                  controller: passController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password cannot be empty!";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters!";
                    }
                    return null;
                  },
                ),

                // Confirm Password TextField
                TextFormField(
                  controller: confirmPassController,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Confirm password cannot be empty!";
                    }
                    if (value != passController.text) {
                      return "Passwords do not match!";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 10),

                // Register Button
                MyButton(
                  text: 'Register',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      register(context);
                    }
                  },
                ),

                SizedBox(height: 20),

                // Social Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareImage(imagePath: 'assets/images/gmail.png'),
                    SquareImage(imagePath: 'assets/images/iphone.png'),
                  ],
                ),

                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
