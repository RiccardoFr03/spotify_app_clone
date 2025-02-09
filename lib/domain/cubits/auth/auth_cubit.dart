import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authenticationRepository;
  late final StreamSubscription<User> userSubscription;
  AuthCubit({
    required this.authenticationRepository,
  }) : super(
          authenticationRepository.currentUser.isNotEmpty
              ? AuthenticatedState(authenticationRepository.currentUser)
              : const NotAuthenticatedState(User.empty),
        ) {
    //Listen all new get user streams
    userSubscription = authenticationRepository.user.listen(
      (user) {
        if (user.isNotEmpty) {
          emit(AuthenticatedState(user));
        } else {
          emit(const NotAuthenticatedState(User.empty));
        }
      },
      onError: (_) => {
        emit(const NotAuthenticatedState(User.empty)),
      },
    );
  }

  void signOut() => authenticationRepository.logOut();

  @override
  Future<void> close() async {
    await userSubscription.cancel();
    await super.close();
  }
}
