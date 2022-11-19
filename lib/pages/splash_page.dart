import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../blocs/blocs.dart';
import '../pages/pages.dart';

class SplashPage extends StatelessWidget {
  static const id = '/';

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (kDebugMode) print('listener $state');

        if (state.status == AuthStatus.authenticated) {
          Navigator.pushNamed(context, HomePage.id);
        }

        if (state.status == AuthStatus.unauthenticated) {
          Navigator.pushNamed(context, SigninPage.id);
        }
      },
      builder: (context, state) {
        if (kDebugMode) print('builder $state');

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
