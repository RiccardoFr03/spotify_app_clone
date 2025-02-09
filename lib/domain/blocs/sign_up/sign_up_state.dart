part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

final class InitialSignUpState extends SignUpState {
  const InitialSignUpState();
}

final class LoadingSignUpState extends SignUpState {
  const LoadingSignUpState();
}

final class SuccessSignUpState extends SignUpState {
  const SuccessSignUpState();
}

final class ErrorSignUpState extends SignUpState {
  final String error;

  const ErrorSignUpState(this.error);

  @override
  List<Object?> get props => [error];
}

final class ErrorFormSignUpState extends SignUpState {
  const ErrorFormSignUpState();
}