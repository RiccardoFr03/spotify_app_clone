part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

final class OnSignInEvent extends SignInEvent {
  final String email;
  final String password;
  final bool formState;

  const OnSignInEvent({
    required this.email,
    required this.password,
    required this.formState,
  });

  @override
  List<Object?> get props => [email, password, formState];
}

final class OnGoogleSignInEvent extends SignInEvent {
  const OnGoogleSignInEvent();
}

final class OnAppleSignInEvent extends SignInEvent {
  const OnAppleSignInEvent();
}
