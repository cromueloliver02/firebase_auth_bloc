import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';
import '../../repositories/auth_repository.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepository authRepository;

  SigninCubit({
    required this.authRepository,
  }) : super(SigninState.initial());

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: SigninStatus.submitting));

    try {
      await authRepository.signin(email: email, password: password);

      emit(state.copyWith(status: SigninStatus.sucess));
    } on CustomError catch (err) {
      emit(state.copyWith(
        status: SigninStatus.error,
        error: err,
      ));

      if (kDebugMode) print('Error: $err');
    }
  }
}
