import 'package:flutter/material.dart';
import '../pages/pages.dart';

class RoutesHandler {
  final Map<String, WidgetBuilder> routes = {
    SplashPage.id: (ctx) => const SplashPage(),
    HomePage.id: (ctx) => const HomePage(),
    SigninPage.id: (ctx) => const SigninPage(),
    SignupPage.id: (ctx) => const SignupPage(),
    ProfilePage.id: (ctx) => const ProfilePage(),
  };
}
