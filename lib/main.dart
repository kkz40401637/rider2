import 'package:apitestinglogin/services/bloc/bloc/cubit/auth_cubit.dart';
import 'package:apitestinglogin/services/bloc/bloc/cubit/order_cubit.dart';
import 'package:apitestinglogin/ui/auth/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apitestinglogin/services/bloc/get_profile/get_profile_cubit.dart';
import 'package:apitestinglogin/services/bloc/bloc/order/order_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('my', 'MM')],
      path: 'languages',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
              create: (BuildContext context) => AuthCubit()),
          BlocProvider<GetProfileCubit>(
              create: (BuildContext context) => GetProfileCubit()),
          BlocProvider<OrderCubit>(
              create: (BuildContext context) => OrderCubit()),
        ],
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          home: const Login(),
        ));
  }
}

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
GlobalKey<ScaffoldMessengerState>();