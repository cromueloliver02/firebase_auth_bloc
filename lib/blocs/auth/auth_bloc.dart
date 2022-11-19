import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final StreamSubscription _authSubscription;
  final AuthRepository authRepository;

  AuthBloc({
    required this.authRepository,
  }) : super(AuthState.unknown()) {
    _authSubscription = authRepository.user.listen((fb_auth.User? user) {
      add(AuthStateChangedEvent(user: user));
    });

    on<AuthStateChangedEvent>(_authStateChanged);
    on<SignoutRequestedEvent>(_signoutRequested);
  }

  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  void _authStateChanged(
    AuthStateChangedEvent event,
    Emitter<AuthState> emit,
  ) {
    final fb_auth.User? user = event.user;

    if (user != null) {
      emit(state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      ));
      return;
    }

    emit(state.copyWith(
      status: AuthStatus.unauthenticated,
      user: null,
    ));
  }

  void _signoutRequested(
    SignoutRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.signout();
  }
}
