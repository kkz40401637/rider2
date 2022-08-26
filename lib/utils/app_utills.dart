import 'package:flutter/material.dart';
import '../main.dart';

class AppUtils {
  static void showSnackBar({required String text}) {
    scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        // padding: EdgeInsets.all(5),
        // margin: EdgeInsets.all(10),
        // elevation: 5,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Text(text, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}