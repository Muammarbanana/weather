import 'package:flutter/material.dart';
import 'package:weatherapp/core/theme/text_style_manager.dart';

class InputDecorationManager {
  static InputDecoration defaultStyle({String hintText = ""}) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.purple.withAlpha(16),
      focusColor: Colors.purple.withAlpha(16),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.deepPurple, width: 1),
      ),
      hintText: hintText,
      hintStyle: TextStyleManager.hintText(),
      contentPadding: const EdgeInsets.all(16),
    );
  }
}
