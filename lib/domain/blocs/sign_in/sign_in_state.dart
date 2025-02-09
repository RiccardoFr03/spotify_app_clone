part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

final class InitialSignInState extends SignInState {
  const InitialSignInState();
}

final class LoadingSignInState extends SignInState {
  const LoadingSignInState();
}

final class SuccessSignInState extends SignInState {
  const SuccessSignInState();
}

final class ErrorSignInState extends SignInState {
  final String error;

  const ErrorSignInState(this.error);

  @override
  List<Object?> get props => [error];
}

final class ErrorFormSignInState extends SignInState {
  const ErrorFormSignInState();
}
