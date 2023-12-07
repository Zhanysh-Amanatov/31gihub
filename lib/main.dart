/*External dependencies*/
import 'package:firebase_core/firebase_core.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
/*Local dependencies*/
import 'package:finik/bloc/app_bloc.dart';
import 'package:finik/bloc_observer.dart';
import 'package:finik/repository/authentication_repository.dart';
import 'package:finik/screens/auth/forgotPassword/forgot_password_loading_view.dart';
import 'package:finik/screens/auth/forgotPassword/forgot_password_view.dart';
import 'package:finik/screens/auth/login/log_in_form.dart';
import 'package:finik/screens/auth/singup/sign_up_form.dart';
import 'package:finik/screens/auth/singup/sign_up_verify_email_view.dart';
import 'package:finik/screens/home/carousel_view.dart';
import 'package:finik/screens/home/home_view.dart';
import 'package:finik/screens/initial_view.dart';
import 'package:finik/theme.dart';
import 'package:finik/view_routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;
  runApp(App(authenticationRepository: authenticationRepository));
}

class App extends StatelessWidget {
  const App({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = 375;
    double height = 812;
    final appStatus = context.select((AppBloc bloc) => bloc.state.status);

    return ScreenUtilInit(
      builder: (BuildContext context, state) {
        return MaterialApp(
          theme: theme,
          home: FlowBuilder<AppStatus>(
            state: appStatus,
            onGeneratePages: onGenerateAppViewPages,
          ),
          routes: {
            logInRoute: (context) => const LoginForm(),
            signUpEmailRoute: (context) => const SignUpForm(),
            signUpVerifyEmailRoute: (context) => const SignUpVerifyEmailView(),
            homeViewRoute: (context) => const HomeView(),
            initialViewRoute: (context) => const InitialView(),
            forgotPasswordRoute: (context) => const ForgotPasswordView(),
            forgotPasswordLoadingRoute: (context) =>
                const ForgotPasswordLoadingView(),
            carouselRoute: (context) => const CarouselView(),
          },
        );
      },
      designSize: Size(width, height),
    );
  }
}

// class App extends StatelessWidget {
//   const App({
//     required AuthenticationRepository authenticationRepository,
//     super.key,
//   }): _authenticationRepository = authenticationRepository;

//   final AuthenticationRepository _authenticationRepository;
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     double width = 375;
//     double height = 812;
//     return ScreenUtilInit(
//       builder: (BuildContext context, state) => MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
//           useMaterial3: true,
//         ),
//         home: const AppView(),
//         routes: {
//           logInRoute: (context) => const LoginForm(),
//           signUpEmailRoute: (context) => const SignUpForm(),
//           signUpVerifyEmailRoute: (context) => const SignUpVerifyEmailView(),
//           homeViewRoute: (context) => const HomeView(),
//           initialViewRoute: (context) => const InitialView(),
//           forgotPasswordRoute: (context) => const ForgotPasswordView(),
//           forgotPasswordLoadingRoute: (context) =>
//               const ForgotPasswordLoadingView(),
//           carouselRoute: (context) => const CarouselView(),
//         },
//       ),
//     );
//   }
// }


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
