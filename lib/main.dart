/*External dependencies*/
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Local dependencies*/
import 'package:finik/firebase_options.dart';
import 'package:finik/routes/routes.dart';
import 'package:finik/screens/auth/forgotPassword/forgot_password_loading_view.dart';
import 'package:finik/screens/auth/forgotPassword/forgot_password_view.dart';
import 'package:finik/screens/auth/login/log_in_view.dart';
import 'package:finik/screens/auth/singup/sign_up_form.dart';
import 'package:finik/screens/auth/singup/sign_up_verify_email_view.dart';
import 'package:finik/screens/carousel_view.dart';
import 'package:finik/screens/home/home_view.dart';
import 'package:finik/services/auth/bloc/auth_bloc.dart';
import 'package:finik/services/auth/firebase_auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  double width = 375;
  double height = 812;
  runApp(ScreenUtilInit(
    designSize: Size(width, height),
    child: BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(FirebaseAuthProvider()),
      child: MaterialApp(
        home: const CarouselView(),
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: initScreen == 0 || initScreen == null
            ? carouselRoute
            : homeViewRoute,
        routes: {
          logInRoute: (context) => const LoginView(),
          signUpEmailRoute: (context) => const SignUpForm(),
          signUpVerifyEmailRoute: (context) => const SignUpVerifyEmailView(),
          homeViewRoute: (context) => const HomeView(),
          forgotPasswordRoute: (context) => const ForgotPasswordView(),
          forgotPasswordLoadingRoute: (context) =>
              const ForgotPasswordLoadingView(),
          carouselRoute: (context) => const CarouselView(),
        },
      ),
    ),
  ));
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());

    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthStateSignedUp) {
        return const SignUpVerifyEmailView();
      } else if (state is AuthStateLoggedIn) {
        return const HomeView();
      } else if (state is AuthStateNeedsVerification) {
        return const SignUpVerifyEmailView();
      } else if (state is AuthStateLogOut) {
        return const HomeView();
      } else {
        return const Scaffold(
          backgroundColor: Colors.black,
          body: Center(
              child: CircularProgressIndicator(
            color: Color(0xFFACF709),
          )),
        );
        // return const CarouselView();
      }
    });
  }
}
