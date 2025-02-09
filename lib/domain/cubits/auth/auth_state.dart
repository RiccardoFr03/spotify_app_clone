part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  final User user;
  const AuthState(this.user);

  @override
  List<Object?> get props => [user];
}

final class AuthenticatedState extends AuthState {
  const AuthenticatedState(super.user);
}

final class NotAuthenticatedState extends AuthState {
  const NotAuthenticatedState(super.user);
}
