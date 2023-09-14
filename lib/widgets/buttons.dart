import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  Buttons({super.key, required this.buttonText, required this.buttonTap});

  final String buttonText;
  final buttonTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: buttonTap,
        child: Container(
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 32,
                color: Colors.white70,
              ),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.brown.shade800,
          ),
        ),
      ),
    );
  }
}
