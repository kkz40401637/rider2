import 'package:apitestinglogin/models/profile/profile_response_model.dart';
import 'package:apitestinglogin/ui/change_lang/change_lang.dart';
import 'package:apitestinglogin/ui/update_profile_page/update_profile_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:apitestinglogin/utils/stream_ext.dart';
import '../models/response_model.dart';
import '../services/bloc/change_status/change_staus.dart';
import '../services/bloc/get_profile/get_profile_bloc.dart';
import '../utils/app_utills.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _bloc = ChangeStatusBloc();
  final _profileBloc = ProfileBloc();
  String? dropdownValue;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _profileBloc.getProfileData();

    _bloc.changeStatusStream().listen((ResponseModel responseModel) {
      if (responseModel.msgState == MsgState.data) {
        AppUtils.showSnackBar(text: "success");
        _profileBloc.getProfileData();
      }

      if (responseModel.msgState == MsgState.error) {
        AppUtils.showSnackBar(
          text: responseModel.data,
        );
        _profileBloc.getProfileData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        body: _profileBloc.getProfileStream().streamWidget(
            successWidget: (ResponseModel responseModel) {
          ProfileModels profileModels = responseModel.data;
          return Form(
            key: _formKey,
            child: SizedBox(
              width: width,
              child: Column(
                children: [
                  //Name Phone Number Status
                  Column(
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        // state.profile.name!,
                        profileModels.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color(0xA6000000),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        // state.profile.phone!,
                        profileModels.phone!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xA6000000),
                        ),
                      ),
                      const SizedBox(height: 15),
                      _bloc.changeStatusStream().streamLoadingWidget(
                            childWidget: Container(
                              width: 90,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xff00C851),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DropdownButton<String>(
                                    value: dropdownValue ??
                                        (profileModels.status!
                                            ? "Online"
                                            : "Offline"),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                    ),
                                    dropdownColor: const Color(0xff00C851),
                                    borderRadius: BorderRadius.circular(5),
                                    elevation: 16,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                    onChanged: (String? newValue) {
                                      _bloc.changeStatus(isOnline: newValue!);
                                      setState(() {
                                        dropdownValue = newValue;
                                      });
                                    },
                                    items: <String>['Online', 'Offline']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )
                                ],
                              ),
                            ),
                          ),
                      const SizedBox(height: 30),
                    ],
                  ),

                  // P R O F I L E
                  Column(
                    children: [
                      const TitleTextAccountPage(titleText: 'PROFILE'),
                      EachSettingListTile(
                        iconData: Icons.account_circle_outlined,
                        titleText: 'Update Profile',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return const UpdateProfilePage();
                            }),
                          ).then((value) => _profileBloc.getProfileData());
                        },
                      ),
                      EachSettingListTile(
                        iconData: Icons.key,
                        titleText: 'Change Password',
                        onTap: () {},
                      ),
                    ],
                  ),

                  //G E N E R A L
                  Column(
                    children: [
                      const TitleTextAccountPage(titleText: 'GENERAL'),
                      EachSettingListTile(
                        iconData: Icons.language,
                        titleText: 'Language',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return const ChangeLanguage();
                            }),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                      EachSettingListTile(
                        iconData: Icons.headset_mic,
                        titleText: 'Help Center',
                        onTap: () {},
                      ),
                      EachSettingListTile(
                        iconData: Icons.list_alt,
                        titleText: 'Terms & Conditions',
                        onTap: () {},
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => LogoutScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("Log Out"),
                          maxLines: 1,
                          style: TextStyle(
                              fontSize:
                                  context.locale == const Locale("my", "MM")
                                      ? 16
                                      : 20,
                              color: const Color(0xfff55f01)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.logout,
                          color: Color(0xFFF55F01),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }, tryAgain: () {
          _profileBloc.getProfileData();
        }));
  }

  @override
  dispose() {
    super.dispose();
    _bloc.dispose();
  }
}

class EachSettingListTile extends StatelessWidget {
  const EachSettingListTile({
    Key? key,
    required this.iconData,
    required this.titleText,
    required this.onTap,
  }) : super(key: key);

  final IconData iconData;
  final String titleText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          iconData,
          size: 30,
          color: const Color(0x99000000),
        ),
        title: Text(
          tr(titleText),
          style: const TextStyle(
            color: Color(0xA6000000),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 17,
        ),
      ),
    );
  }
}

class TitleTextAccountPage extends StatelessWidget {
  const TitleTextAccountPage({
    Key? key,
    required this.titleText,
  }) : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      color: const Color(0xffF2F2F7),
      child: Text(
        tr(titleText),
        style: TextStyle(
          color: const Color(0x80000000),
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: context.locale == const Locale("my", "MM") ? null : 5,
        ),
      ),
    );
  }
}
