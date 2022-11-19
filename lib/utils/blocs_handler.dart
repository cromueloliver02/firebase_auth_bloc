import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../blocs/blocs.dart';
import '../cubits/cubits.dart';
import '../repositories/auth_repository.dart';

class BlocsHandler {
  final List<RepositoryProvider> repositoryProviders = [
    RepositoryProvider<AuthRepository>(
      create: (ctx) => AuthRepository(
        firebaseFirestore: FirebaseFirestore.instance,
        firebaseAuth: FirebaseAuth.instance,
      ),
    ),
  ];

  final List<BlocProvider> blocProviders = [
    BlocProvider<AuthBloc>(
      create: (ctx) => AuthBloc(
        authRepository: ctx.read<AuthRepository>(),
      ),
    ),
    BlocProvider<SigninCubit>(
      create: (ctx) => SigninCubit(
        authRepository: ctx.read<AuthRepository>(),
      ),
    ),
    BlocProvider<SignupCubit>(
      create: (ctx) => SignupCubit(
        authRepository: ctx.read<AuthRepository>(),
      ),
    ),
  ];
}
