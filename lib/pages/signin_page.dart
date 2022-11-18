import 'package:flutter/material.dart';

class SigninPage extends StatelessWidget {
  static const id = '/signin';

  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Signin'),
      ),
    );
  }
}
