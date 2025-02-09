import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/data/repositories/auth_repository.dart';
import 'package:spotify_clone/data/exeptions/log_in_with_email_and_password_failure.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;

  SignInBloc({
    required this.authRepository,
  }) : super(const InitialSignInState()) {
    on<OnSignInEvent>(_onPerform);
    on<OnGoogleSignInEvent>(_onGoogleSignInEvent);
    on<OnAppleSignInEvent>(_onAppleSignInEvent);
  }

  void signIn(String email, String password, bool formState) {
    add(OnSignInEvent(email: email, password: password, formState: formState));
  }

  void googleSignIn() {
    add(const OnGoogleSignInEvent());
  }

  void appleSignIn() {
    add(const OnAppleSignInEvent());
  }

  void _onPerform(
    OnSignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    if (event.formState == false) {
      emit(const ErrorFormSignInState());
      return;
    }
    emit(const LoadingSignInState());
    try {
      await authRepository.signIn(email: event.email, password: event.password);
      emit(const SuccessSignInState());
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(ErrorSignInState(e.message));
    } catch (e) {
      emit(const ErrorSignInState('Errore sconosciuto. Riprova più tardi.'));
    }
  }

  void _onGoogleSignInEvent(
    OnGoogleSignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(LoadingSignInState());
    try {
      await authRepository.logInWithGoogle();
      emit(SuccessSignInState());
    } catch (e) {
      emit(ErrorSignInState(e.toString()));
    }
  }

  void _onAppleSignInEvent(
    OnAppleSignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(LoadingSignInState());
    try {
      await authRepository.signInWithApple();
      emit(SuccessSignInState());
    } catch (e) {
      emit(ErrorSignInState(e.toString()));
    }
  }
}
