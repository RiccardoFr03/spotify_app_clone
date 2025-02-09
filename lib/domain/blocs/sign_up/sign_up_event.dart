part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

final class OnSignUpEvent extends SignUpEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final bool formState;

  const OnSignUpEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.formState,
  });

  @override
  List<Object?> get props => [email, password, confirmPassword, formState];
}

final class OnGoogleSignUpEvent extends SignUpEvent {
  const OnGoogleSignUpEvent();
}

final class OnAppleSignUpEvent extends SignUpEvent {
  const OnAppleSignUpEvent();
}
