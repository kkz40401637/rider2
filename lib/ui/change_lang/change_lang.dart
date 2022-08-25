import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../services/bloc/change_language/change_language.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = ChangeLangBloc();
    bloc.checkLang(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme:
        const IconThemeData(color: Color.fromARGB(255, 219, 212, 212)),
        backgroundColor: const Color(0xFFF55F01),
        title: Text(
          tr("Language"),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.headset_mic),
            onPressed: () {},
          )
        ],
      ),
      body: StreamBuilder<int?>(
          initialData: bloc.val,
          stream: bloc.lanStream(),
          builder: (context, snapshot) {
            return Column(
              children: [
                ListTile(
                  leading: Radio(
                      value: 1,
                      groupValue: snapshot.data,
                      activeColor: const Color(0xFFF55F01),
                      onChanged: (int? value) {
                        bloc.changeToEn(context);
                      }),
                  title: Text(tr("English")),
                ),
                ListTile(
                  leading: Radio(
                      value: 2,
                      groupValue: snapshot.data,
                      activeColor: const Color(0xFFF55F01),
                      onChanged: (int? value) {
                        bloc.changeToMm(context);
                      }),
                  title: Text(tr("Myanmar")),
                ),
              ],
            );
          }),
    );
  }
}