import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(
        
         ),
    ),
  );
}
