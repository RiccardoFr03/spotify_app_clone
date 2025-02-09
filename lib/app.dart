import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/domain/cubits/auth/auth_cubit.dart';
import 'package:spotify_clone/domain/cubits/theme/theme_cubit.dart';
import 'package:spotify_clone/domain/injectors/dependency_injector.dart';
import 'package:spotify_clone/presetation/themes/theme.dart';
import 'package:spotify_clone/router/router.dart';

class App extends StatelessWidget {
  final AuthCubit authCubit;
  final GoRouter router;
  const App({super.key, required this.authCubit, required this.router});

  @override
  Widget build(BuildContext context) {
    return DependencyInjector(
      authCubit: authCubit,
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Spotify Clone',
            debugShowCheckedModeBanner: false,
            locale: const Locale('it'),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: router,
            scaffoldMessengerKey: AppRouter.scaffoldMessengerKey,
          );
        },
      ),
    );
  }
}
