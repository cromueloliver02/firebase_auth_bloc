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
        if (state.status == AuthStatus.unauthenticated) {
          // Navigator.pushNamed(ctx, SigninPage.id);
          // SigninPage gets pushed twice when first logging in and logging out
          Navigator.pushNamedAndRemoveUntil(ctx, SigninPage.id, (route) {
            // print('route ${route.settings.name}');
            // print('ModalRoute ${ModalRoute.of(context)!.settings.name}');
            return route.settings.name == SplashPage.id;
          });
        }

        if (state.status == AuthStatus.authenticated) {
          Navigator.pushNamed(ctx, HomePage.id);
        }
      },
      builder: (ctx, state) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
