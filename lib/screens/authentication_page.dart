import 'package:finik/screens/home/carousel_view.dart';
import 'package:finik/screens/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationFlowWidget extends StatelessWidget {
  const AuthenticationFlowWidget({super.key});
  static String id = 'main_view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeView();
        } else {
          return const CarouselView();
        }
      },
    ));
  }
}
