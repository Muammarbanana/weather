import 'package:flutter/material.dart';

class CustomDialog {
  BuildContext? _context;
  final bool isDismissible;
  CustomDialog({this.isDismissible = false});

  CustomDialog of(BuildContext context) {
    _context = context;
    return this;
  }

  Future<T?> dialog<T>(Widget widget) {
    return showDialog<T>(
      context: _context!,
      builder: (_) => widget,
    ).whenComplete(() {});
  }
}
