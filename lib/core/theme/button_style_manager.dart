import 'package:flutter/material.dart';

class ButtonStyleManager {
  static ButtonStyle primary() {
    return ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        backgroundColor: Colors.deepPurple);
  }

  static ButtonStyle primaryWhite() {
    return ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          side: BorderSide(color: Colors.black, width: 1),
        ),
        backgroundColor: Colors.white);
  }
}
