import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const id = '/profile';

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
