import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static const id = '/';

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
