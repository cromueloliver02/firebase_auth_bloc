import 'package:fb_auth_bloc/blocs/blocs.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const id = '/home';

  const HomePage({super.key});

  void _signout(BuildContext ctx) {
    ctx.read<AuthBloc>().add(SignoutRequestedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => _signout(context),
              iconSize: 30,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: const Center(
          child: Text('Home'),
        ),
      ),
    );
  }
}
