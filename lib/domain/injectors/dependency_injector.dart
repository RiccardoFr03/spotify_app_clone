import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pine/di/dependency_injector_helper.dart';
import 'package:spotify_clone/data/repositories/artist_repository.dart';
import 'package:spotify_clone/data/repositories/auth_repository.dart';
import 'package:spotify_clone/data/repositories/history_repository.dart';
import 'package:spotify_clone/data/repositories/song_repository.dart';
import 'package:spotify_clone/domain/cubits/auth/auth_cubit.dart';

import 'package:spotify_clone/domain/cubits/home_data/home_data_cubit.dart';
import 'package:spotify_clone/domain/cubits/theme/theme_cubit.dart';

part 'repositories.dart';

class DependencyInjector extends StatelessWidget {
  final AuthCubit authCubit;
  final Widget child;

  const DependencyInjector({
    super.key,
    required this.child,
    required this.authCubit,
  });

  @override
  Widget build(BuildContext context) => DependencyInjectorHelper(
        repositories: _repositories,
        blocs: [
          BlocProvider<AuthCubit>.value(value: authCubit),
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider<HomeDataCubit>(
            create: (context) => HomeDataCubit(
              songRepository: context.read(),
              artistRepository: context.read(),
            ),
          )
        ],
        child: child,
      );
}
