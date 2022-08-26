// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../services/bloc/bloc/cubit/auth_cubit.dart';
// import 'login.dart';
//
// class LogoutScreen extends StatelessWidget {
//   const LogoutScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFFF55F01),
//         title: const Text('See You Again'),
//       ),
//       body: BlocListener<AuthCubit, AuthState>(
//         listener: (context, state) {
//           if (state is LogoutSuccess) {
//             // SystemNavigator.pop();
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (context) => Login()),
//                     (route) => false);
//           }
//         },
//         child: Column(
//           children: [
//             SizedBox(
//               height: 30,
//             ),
//             Image.network(
//               'https://forfoodieuat.bimats.com:10443/images/Logo_white.png',
//               fit: BoxFit.cover,
//             ),
//             Text('Logout for you..'),
//             Container(
//               height: 200,
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
