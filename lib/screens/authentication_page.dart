/*External dependencies */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
/*Local dependencies */
import 'package:finik/bloc/auth/authentication_bloc.dart';
import 'package:finik/screens/home/carousel_view.dart';
import 'package:finik/screens/home/home_view.dart';

class AuthenticationFlowWidget extends StatelessWidget {
  const AuthenticationFlowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
            body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, state) {
            if (state is AuthenticationSuccessState) {
              return const HomeView();
            } else {
              return const CarouselView();
            }
          },
        ));
      },
    );
  }
}
