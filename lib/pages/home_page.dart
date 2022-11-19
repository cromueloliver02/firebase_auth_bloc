import 'package:flutter/material.dart';
import '../blocs/blocs.dart';
import '../pages/pages.dart';

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
              onPressed: () => Navigator.pushNamed(context, ProfilePage.id),
              iconSize: 30,
              icon: const Icon(Icons.account_circle),
            ),
            IconButton(
              onPressed: () => _signout(context),
              iconSize: 30,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/bloc_logo_full.png',
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              const SizedBox(height: 20),
              const Text(
                'Bloc is an awesome\nstate management\nfor Flutter!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
