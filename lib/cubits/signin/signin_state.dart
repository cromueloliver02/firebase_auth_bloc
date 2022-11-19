part of 'signin_cubit.dart';

class SigninState extends Equatable {
  final SigninStatus status;
  final CustomError error;

  const SigninState({
    required this.status,
    required this.error,
  });

  factory SigninState.initial() {
    return const SigninState(
      status: SigninStatus.initial,
      error: CustomError(),
    );
  }

  @override
  List<Object> get props => [status, error];

  @override
  String toString() => 'SigninState(status: $status, error: $error)';

  SigninState copyWith({
    SigninStatus? status,
    CustomError? error,
  }) {
    return SigninState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

enum SigninStatus {
  initial,
  submitting,
  sucess,
  error,
}
