import 'package:flutter/material.dart';
import './pages/pages.dart';
import './utils/utils.dart';

class FirebaseAuthApp extends StatelessWidget {
  FirebaseAuthApp({super.key});

  final _routesHandler = RoutesHandler();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashPage.id,
      routes: _routesHandler.routes,
    );
  }
}
