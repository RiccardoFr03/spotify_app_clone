import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmPasswordCubit extends Cubit<String> {
  ConfirmPasswordCubit() : super('');

  void passwordChange(String password) => emit(password);
}
