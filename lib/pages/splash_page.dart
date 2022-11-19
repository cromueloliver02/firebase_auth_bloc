import 'package:flutter/material.dart';
import '../blocs/blocs.dart';
import '../pages/pages.dart';

class SplashPage extends StatelessWidget {
  static const id = '/';

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (ctx, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushNamed(ctx, HomePage.id);
        }

        if (state.status == AuthStatus.unauthenticated) {
          Navigator.pushNamed(ctx, SigninPage.id);
        }
      },
      builder: (ctx, state) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
