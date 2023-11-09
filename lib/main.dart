/*External dependencies*/
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
/*Local dependencies*/
import 'package:finik/view_routes/routes.dart';
import 'package:finik/firebase_options.dart';
import 'package:finik/views/home/home_view.dart';
import 'package:finik/views/login/forgot_password_loading_view.dart';
import 'package:finik/views/login/forgot_password_view.dart';
import 'package:finik/views/login/sign_up_verify_email_view.dart';
import 'package:finik/views/login/initial_view.dart';
import 'package:finik/views/login/log_in_view.dart';
import 'package:finik/views/login/sign_up_email_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const DefaultView(),
        routes: {
          logInRoute: (context) => const LogInView(),
          signUpEmailRoute: (context) => const SignUpEmailView(),
          signUpVerifyEmailRoute: (context) => const SignUpVerifyEmailView(),
          homeViewRoute: (context) => const HomeView(),
          initialViewRoute: (context) => const InitialView(),
          forgotPasswordRoute: (context) => const ForgotPasswordView(),
          forgotPasswordLoadingRoute: (context) =>
              const ForgotPasswordLoadingView(),
        },
      ),
      designSize: const Size(375, 812),
    );
  }
}

class DefaultView extends StatelessWidget {
  const DefaultView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return const HomeView();
          default:
            return const InitialView();
        }
      },
    );
  }
}
