import 'package:flutter/material.dart';

class BloknotButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const BloknotButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
