import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller ;
  final String text ;
  final bool obsecureText ;


  const MyTextField({super.key,required this.controller,required this.text,required this.obsecureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 24),
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF264131)),
          ),
          fillColor: Colors.grey.shade200,
          filled: true
        ),
      ),
    );
  }
}
