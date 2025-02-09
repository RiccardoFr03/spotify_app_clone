import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/data/exeptions/sign_up_with_email_and_password_failure.dart';
import 'package:spotify_clone/data/repositories/auth_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;

  SignUpBloc({
    required this.authRepository,
  }) : super(const InitialSignUpState()) {
    on<OnSignUpEvent>(_onPerform);
    on<OnGoogleSignUpEvent>(_onGoogleSignUpEvent);
    on<OnAppleSignUpEvent>(_onAppleSignUpEvent);
  }

  void signIn(String email, String password, String confirmPassword, bool formState) {
    add(OnSignUpEvent(email: email, password: password, confirmPassword: confirmPassword, formState: formState));
  }

  void googleSignIn() {
    add(const OnGoogleSignUpEvent());
  }

  void appleSignIn() {
    add(const OnAppleSignUpEvent());
  }

  void _onPerform(
    OnSignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    if (event.formState == false) {
      emit(const ErrorFormSignUpState());
      return;
    }
    emit(const LoadingSignUpState());
    try {
      await authRepository.signUp(email: event.email, password: event.password);
      emit(const SuccessSignUpState());
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(ErrorSignUpState(e.message));
    } catch (e) {
      emit(const ErrorSignUpState('Errore sconosciuto. Riprova più tardi.'));
    }
  }

  void _onGoogleSignUpEvent(
    OnGoogleSignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(const LoadingSignUpState());
    try {
      await authRepository.logInWithGoogle();
      emit(const SuccessSignUpState());
    } catch (e) {
      emit(ErrorSignUpState(e.toString()));
    }
  }

  void _onAppleSignUpEvent(
    OnAppleSignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(const LoadingSignUpState());
    try {
      await authRepository.signInWithApple();
      emit(const SuccessSignUpState());
    } catch (e) {
      emit(ErrorSignUpState(e.toString()));
    }
  }
}
