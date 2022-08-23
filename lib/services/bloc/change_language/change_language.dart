import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ChangeLangBloc {
  final PublishSubject<int?> _controller = PublishSubject<int?>();
  Stream<int?> lanStream() => _controller.stream;

  int? val;

  checkLang(BuildContext context) {
    context.locale == const Locale("en", "US") ? val = 1 : val = 2;
    _controller.sink.add(val);
  }

  changeToMm(BuildContext context) {
    val = 2;

    context.setLocale(const Locale('my', 'MM'));
    _controller.sink.add(val!);
  }

  changeToEn(BuildContext context) {
    val = 1;

    context.setLocale(const Locale('en', 'US'));
    _controller.sink.add(val!);
  }
}