part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final SignupStatus status;
  final CustomError error;

  const SignupState({
    required this.status,
    required this.error,
  });

  factory SignupState.initial() {
    return const SignupState(
      status: SignupStatus.initial,
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, error];

  @override
  String toString() => 'SignupState(status: $status, error: $error)';

  SignupState copyWith({
    SignupStatus? status,
    CustomError? error,
  }) {
    return SignupState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

enum SignupStatus {
  initial,
  submitting,
  success,
  error,
}
