import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './pages/pages.dart';
import './utils/blocs_handler.dart';
import './utils/utils.dart';

class FirebaseAuthApp extends StatelessWidget {
  FirebaseAuthApp({super.key});

  final _blocsHandler = BlocsHandler();
  final _routesHandler = RoutesHandler();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: _blocsHandler.repositoryProviders,
      child: MultiBlocProvider(
        providers: _blocsHandler.blocProviders,
        child: MaterialApp(
          title: 'Firebase Auth',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: SplashPage.id,
          routes: _routesHandler.routes,
        ),
      ),
    );
  }
}
