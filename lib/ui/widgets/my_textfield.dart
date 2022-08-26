import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Tfwidget extends StatelessWidget {
  const Tfwidget(
      {Key? key,
      required this.controller,
      required this.label,
      required this.isPsw})
      : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool isPsw;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        validator: ((value) {
          if (isPsw) {
            if (value!.isEmpty) {
              return 'Need To Fill';
            } else if (value.length < 6) {
              return "at lease 6 charater";
            } else {
              return null;
            }
          } else {
            if (value!.isEmpty) {
              return 'Need To Fill';
            } else {
              return null;
            }
          }
        }),
        decoration: InputDecoration(
          label: Text(tr(label)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
