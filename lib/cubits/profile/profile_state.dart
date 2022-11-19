part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final ProfileStatus status;
  final User user;
  final CustomError error;

  const ProfileState({
    required this.status,
    required this.user,
    required this.error,
  });

  factory ProfileState.initial() {
    return ProfileState(
      status: ProfileStatus.initial,
      user: User.initial(),
      error: const CustomError(),
    );
  }

  @override
  List<Object> get props => [status, user, error];

  @override
  String toString() =>
      'ProfileState(status: $status, user: $user, error: $error)';

  ProfileState copyWith({
    ProfileStatus? status,
    User? user,
    CustomError? error,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}

enum ProfileStatus {
  initial,
  loading,
  loaded,
  error,
}
