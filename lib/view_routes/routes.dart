import 'package:finik/bloc/app_bloc.dart';
import 'package:finik/screens/home/carousel_view.dart';
import 'package:finik/screens/home/home_view.dart';
import 'package:flutter/material.dart';

const logInRoute = '/logIn';
const signUpEmailRoute = '/signUpEmail';
const signUpVerifyEmailRoute = '/signUpVerifyEmail';
const signUpPasswordRoute = '/signUpPassword';
const logInLoadingRoute = '/logInLoading';
const homeViewRoute = '/homeView';
const initialViewRoute = '/initialView';
const forgotPasswordRoute = '/forgotPassword';
const forgotPasswordLoadingRoute = '/forgotPasswordLoading';
const carouselRoute = '/carouselRoute';
const noRoute = '';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomeView.page()];
    case AppStatus.unauthenticated:
      return [CarouselView.page()];
  }
}
