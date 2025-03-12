import 'package:flutter/material.dart';

class SquareImage extends StatelessWidget {
  final String imagePath;

  const SquareImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(
          imagePath,
          height: 60,
        ),
      ),
    );
  }
}
