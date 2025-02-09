import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify_clone/app.dart';
import 'package:spotify_clone/data/repositories/auth_repository.dart';
import 'package:spotify_clone/domain/cubits/auth/auth_cubit.dart';
import 'package:spotify_clone/domain/helpers/bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spotify_clone/router/router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : await getApplicationDocumentsDirectory(),
  );
  Bloc.observer = const AppBlocObserver();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authRepository = AuthRepository();
  final authCubit = AuthCubit(authenticationRepository: authRepository);
  final router = AppRouter.createRouter(authCubit);
  runApp(
    App(authCubit: authCubit, router: router),
  );
  FlutterNativeSplash.remove();
}
