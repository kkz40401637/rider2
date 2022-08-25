import 'package:apitestinglogin/services/bloc/update_profile/update_profile_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:apitestinglogin/utils/stream_ext.dart';
import '../../models/response_model.dart';
import '../../utils/app_utills.dart';
import '../widgets/my_textfield.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({Key? key}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameTec = TextEditingController();
  final _phoneTec = TextEditingController();
  final _emailTec = TextEditingController();
  final _adressTec = TextEditingController();
  final _bloc = UpdateProfileBLoc();

  @override
  void initState() {
    _bloc.updProfileStream().listen((ResponseModel responseModel) {
      if (responseModel.msgState == MsgState.data) {
        setState(() {
          _usernameTec.clear();
          _phoneTec.clear();
          _emailTec.clear();
          _adressTec.clear();
        });
        AppUtils.showSnackBar(text: "success");
      }

      if (responseModel.msgState == MsgState.error) {
        AppUtils.showSnackBar(
          text: responseModel.data,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 219, 212, 212)),
        backgroundColor: const Color(0xFFF55F01),
        title: Text(
          tr("Update Profile"),
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Tfwidget(
                  controller: _usernameTec,
                  label: "Name",
                  isPsw: false,
                ),
                Tfwidget(
                  controller: _phoneTec,
                  label: "Phone",
                  isPsw: false,
                ),
                Tfwidget(
                  controller: _emailTec,
                  label: "Email",
                  isPsw: false,
                ),
                Tfwidget(
                  controller: _adressTec,
                  label: "Adress",
                  isPsw: false,
                ),
                SizedBox(
                  height: size.height * 0.3,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bloc.updProfileStream().streamLoadingWidget(
            childWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFFF55F01)),
                ),
                onPressed: doUpdate,
                child: Text(tr("Save")),
              ),
            ),
          ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

extension UpdPf on _UpdateProfilePageState {
  doUpdate() {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    Map<String, dynamic> map = {};
    map['name'] = _usernameTec.text;
    map['address'] = _adressTec.text;
    map['phone'] = _phoneTec.text;
    map['email'] = _emailTec.text;
    _bloc.doUpdate(map);
  }
}
