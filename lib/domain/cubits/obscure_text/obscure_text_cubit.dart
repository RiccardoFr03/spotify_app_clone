import 'package:flutter_bloc/flutter_bloc.dart';

class ObscureTextCubit extends Cubit<bool> {
  ObscureTextCubit() : super(true);

  void toggle() => emit(!state);
}
