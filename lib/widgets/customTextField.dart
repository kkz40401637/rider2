import 'package:flutter/material.dart';

Widget CustomTextField({
  required BuildContext context,
  String? label,
  Color? hintTextColor,
  bool? noBorder,
  bool? autoFocus,
  bool? border,
  Color? color,
  int maxline = 1,
  bool readOnly = false,
  TextInputType inputType = TextInputType.text,
  String validatorText = 'Cannot be empty',
  hintText = '',
  Icon? prefixIcon,
  maxLength,
  FocusNode? node,
  String? initialValue,
  Function(String data)? onsubmit,
  String? Function(String? value)? validator,
  TextInputAction action = TextInputAction.done,
  required Function(String val)? onChange,
}) {
  return TextFormField(
    focusNode: node,
    readOnly: readOnly,
    maxLength: maxLength,
    initialValue: initialValue,
    maxLines: maxline,
    decoration: InputDecoration(
        prefixIcon: prefixIcon,
        labelStyle: TextStyle(color: Colors.black, fontSize: 16),
        labelText: label,
        hintText: hintText,
        border: UnderlineInputBorder(
          borderSide: noBorder == true
              ? BorderSide.none
              : BorderSide(style: BorderStyle.solid, width: 0.1),
        )),
    style: TextStyle(color: Colors.black, fontSize: 17),
    textInputAction: action,
    onFieldSubmitted: onsubmit,
    autofocus: autoFocus = true,
    keyboardType: inputType,
    validator: validator,
    onChanged: onChange,
  );
}

Widget CustomPasswordField(
    {required BuildContext context,
      String? initialVal,
      required String hint_Text,
      String? Function(String? value)? validator,
      bool hide = true,
      required Function(bool hide) hideBtn,
      FocusNode? node,
      Function(String data)? onSubmit,
      TextInputType inputType = TextInputType.text,
      String validatorText = 'Cannot be empty',
      required Function(String value)? OnChange}) {
  return TextFormField(
    initialValue: initialVal,
    validator: validator,
    focusNode: node,
    obscureText: hide,
    onChanged: OnChange,
    decoration: InputDecoration(
      border: const UnderlineInputBorder(),
      hintText: hint_Text,
      hintStyle: TextStyle(fontSize: 16, color: Colors.black54),
      prefixIcon: const Icon(Icons.lock),
      suffixIcon: IconButton(
          onPressed: () {
            hideBtn(hide);
          },
          icon: const Icon(
            Icons.remove_red_eye,
            color: Colors.black,
          )),
    ),
  );
}
