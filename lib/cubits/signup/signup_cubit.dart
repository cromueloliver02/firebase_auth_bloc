import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';
import '../../repositories/auth_repository.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository authRepository;

  SignupCubit({
    required this.authRepository,
  }) : super(SignupState.initial());

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: SignupStatus.submitting));

    try {
      await authRepository.signup(
        name: name,
        email: email,
        password: password,
      );

      emit(state.copyWith(status: SignupStatus.success));
    } on CustomError catch (err) {
      emit(state.copyWith(
        status: SignupStatus.error,
        error: err,
      ));
    }
  }
}
