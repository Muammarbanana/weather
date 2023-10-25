import 'package:flutter/material.dart';

class TextStyleManager {
  static TextStyle buttonText({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    const double defaultFontSize = 16;
    const Color defaultColor = Colors.white;
    const FontWeight defaultFontWeight = FontWeight.w400;

    return TextStyle(
      color: color ?? defaultColor,
      fontSize: fontSize ?? defaultFontSize,
      fontWeight: fontWeight ?? defaultFontWeight,
    );
  }

  static TextStyle hintText({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    const double defaultFontSize = 14;
    const Color defaultColor = Colors.grey;
    const FontWeight defaultFontWeight = FontWeight.w400;

    return TextStyle(
      color: color ?? defaultColor,
      fontSize: fontSize ?? defaultFontSize,
      fontWeight: fontWeight ?? defaultFontWeight,
    );
  }

  static TextStyle mediumText({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    const double defaultFontSize = 14;
    const Color defaultColor = Colors.black;
    const FontWeight defaultFontWeight = FontWeight.w400;

    return TextStyle(
      color: color ?? defaultColor,
      fontSize: fontSize ?? defaultFontSize,
      fontWeight: fontWeight ?? defaultFontWeight,
    );
  }

  static TextStyle header2Text({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    const double defaultFontSize = 18;
    const Color defaultColor = Colors.black;
    const FontWeight defaultFontWeight = FontWeight.w400;

    return TextStyle(
      color: color ?? defaultColor,
      fontSize: fontSize ?? defaultFontSize,
      fontWeight: fontWeight ?? defaultFontWeight,
    );
  }

  static TextStyle headerText({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    const double defaultFontSize = 24;
    const Color defaultColor = Colors.black;
    const FontWeight defaultFontWeight = FontWeight.w400;

    return TextStyle(
      color: color ?? defaultColor,
      fontSize: fontSize ?? defaultFontSize,
      fontWeight: fontWeight ?? defaultFontWeight,
    );
  }
}
