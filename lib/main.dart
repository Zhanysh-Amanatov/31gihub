/*External dependencies*/
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
/*Local dependencies*/
import 'package:finik/bloc/app_bloc_observer.dart';
import 'package:finik/bloc/auth/authentication_bloc.dart';
import 'package:finik/bloc/database/database_bloc.dart';
import 'package:finik/bloc/formBloc/form_bloc.dart';
import 'package:finik/firebase_options.dart';
import 'package:finik/screens/auth/forgotPassword/forgot_password_loading_view.dart';
import 'package:finik/screens/auth/forgotPassword/forgot_password_view.dart';
import 'package:finik/screens/auth/login/log_in_view.dart';
import 'package:finik/screens/auth/singup/sign_up_email_view.dart';
import 'package:finik/screens/auth/singup/sign_up_verify_email_view.dart';
import 'package:finik/screens/authentication_page.dart';
import 'package:finik/screens/home/carousel_view.dart';
import 'package:finik/screens/home/home_view.dart';
import 'package:finik/screens/initial_view.dart';
import 'package:finik/services/authentication_repository.dart';
import 'package:finik/services/database_repository.dart';
import 'package:finik/view_routes/routes.dart';

void main() async {
  // runZonedGuarded<Future<void>>(() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) {});
  Bloc.observer = AppBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(AuthenticationRepositoryImpl())
                ..add(AuthenticationStarted()),
        ),
        BlocProvider(
          create: (context) => FormBloc(
              AuthenticationRepositoryImpl(), DatabaseRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
        )
      ],
      child: const MyApp(),
    ),
  );
  // blocObserver: AppBlocObserver();
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double width = 375;
    double height = 812;
    return ScreenUtilInit(
      builder: (BuildContext context, state) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const AuthenticationFlowWidget(),
        routes: {
          logInRoute: (context) => const LogInView(),
          signUpEmailRoute: (context) => const SignUpEmailView(),
          signUpVerifyEmailRoute: (context) => const SignUpVerifyEmailView(),
          homeViewRoute: (context) => const HomeView(),
          initialViewRoute: (context) => const InitialView(),
          forgotPasswordRoute: (context) => const ForgotPasswordView(),
          forgotPasswordLoadingRoute: (context) =>
              const ForgotPasswordLoadingView(),
          carouselRoute: (context) => const CarouselView(),
        },
      ),
      designSize: Size(width, height),
    );
  }
}

// class DefaultView extends StatelessWidget {
//   const DefaultView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Firebase.initializeApp(
//           options: DefaultFirebaseOptions.currentPlatform),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.done:
//             return const CarouselView();
//           default:
//             return const InitialView();
//         }
//       },
//     );
//   }
// }
