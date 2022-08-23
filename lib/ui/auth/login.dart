import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/auth/login_model.dart';
import '../../services/bloc/bloc/cubit/auth_cubit.dart';
import '../../widgets/customTextField.dart';
import '../order_screen.dart';




class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  bool buttonHide = true;
  String _username = '';
  String _password = '';
  bool _hidePwd = true;
  late FocusNode pwdFocus;
  String? loginFail;
  bool loading = false;

  void login() {
    if (_formKey.currentState!.validate()) {
      print(_username + _password);
      LoginModel _loginModel =
      new LoginModel(userName: _username, userType: 4, password: _password);
      _loginModel.toJson();
      BlocProvider.of<AuthCubit>(context).login(_loginModel);
    }
  }

  void initState() {
    _username = '';
    _password = '';
    pwdFocus = new FocusNode();
    super.initState();
  }

  void focusOnPwd() {
    FocusScope.of(context).requestFocus(pwdFocus);
  }

  @override
  void dispose() {
    pwdFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginFail) {
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
            AwesomeDialog(
              padding: EdgeInsets.all(4.0),
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE,
              btnCancel: TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              aligment: Alignment.center,
              btnOk: TextButton(
                child: Text(
                  'Okay',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              // title: 'Oops',
              desc: 'Invaild User',
              btnCancelOnPress: () {},
              btnOkOnPress: () {},
            ).show();
          } else if (state is LoginLoading) {
            setState(() {
              loading = true;
            });
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Logging..'),
                  content: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: CircularProgressIndicator()),
                );
              },
            );
          } else if (state is LoginSuccess) {
            setState(() {
              loading = false;
            });
            Navigator.of(context).pop();
            print(state.response.user);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => OrderScreen()),
                    (route) => false);
          }
        },
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      // color: Colors.red,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Color.fromARGB(255, 219, 214, 214),
                      ),
                      child: Image.network(
                        'https://forfoodieuat.bimats.com:10443/images/Logo_white.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    const Text(
                      "Welcome to your admin portal from foodie",
                      style:
                      TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      // padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomTextField(
                          context: context,
                          action: TextInputAction.done,
                          onChange: (String val) {
                            _username = val;
                          },
                          // label: '09...',
                          onsubmit: (String? data) {
                            focusOnPwd();
                          },
                          hintText: 'Email',
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'User Name cannot be empty';
                          },
                          hintTextColor: Colors.black,
                          noBorder: false,
                          autoFocus: true,
                          color: Colors.black,
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      // padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomPasswordField(
                          hint_Text: 'Password',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Need to fill the password";
                            }
                          },
                          node: pwdFocus,
                          OnChange: (String value) {
                            _password = value;
                          },
                          context: context,
                          hide: buttonHide,
                          hideBtn: (hide) {
                            setState(() {
                              buttonHide = !hide;
                            });
                          }),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      // height: MediaQuery.of(context).hashCode * 0.03,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 249, 122, 3)),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        onPressed: () {
                          login();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Forget your password?",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgor Password",
                              style:
                              TextStyle(color: Colors.blue, fontSize: 18),
                            )),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
