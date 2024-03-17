import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;
    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        decoration: BoxDecoration(
            color: Colors.amber.shade300,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black12),
            boxShadow: [BoxShadow()]),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: swidth * 0.02,
            vertical: sheight * 0.02,
          ),
          child: Center(
            child: Text(
              "Please Use Google SignIn",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik'),
            ),
          ),
        ),
      ),
    );
  }
}
