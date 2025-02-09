import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/blocs/search/search_bloc.dart';
import 'package:spotify_clone/domain/blocs/sign_in/sign_in_bloc.dart';
import 'package:spotify_clone/domain/blocs/sign_up/sign_up_bloc.dart';
import 'package:spotify_clone/domain/cubits/artist_songs/artist_songs_cubit.dart';
import 'package:spotify_clone/domain/cubits/auth/auth_cubit.dart';
import 'package:spotify_clone/domain/cubits/history/history_cubit.dart';
import 'package:spotify_clone/domain/cubits/most_played/most_played_cubit.dart';
import 'package:spotify_clone/domain/cubits/obscure_text/obscure_text_cubit.dart';
import 'package:spotify_clone/domain/helpers/auth_redirect_helper.dart';
import 'package:spotify_clone/presetation/screens/artist_screen.dart';
import 'package:spotify_clone/presetation/screens/error_screen.dart';
import 'package:spotify_clone/presetation/screens/intro/get_started_screen.dart';
import 'package:spotify_clone/presetation/screens/home_screen.dart';
import 'package:spotify_clone/presetation/screens/auth/sign_in_screen.dart';
import 'package:spotify_clone/presetation/screens/auth/sign_up_screen.dart';
import 'package:spotify_clone/presetation/screens/intro/theme_mode_screen.dart';
import 'package:spotify_clone/presetation/screens/profile_screen.dart';
import 'package:spotify_clone/presetation/screens/search_screen.dart';
import 'package:spotify_clone/presetation/screens/song_player_screen.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';

class AppRouter {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  static final navigatorKey = GlobalKey<NavigatorState>(debugLabel: "root");
  static final shellNavigatorKey = GlobalKey<NavigatorState>(
    debugLabel: "shell",
  );

  static GoRouter createRouter(AuthCubit authCubit) {
    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: GetStartedScreen.path,
      navigatorKey: navigatorKey,
      refreshListenable: AuthRedirectHelper(authCubit.stream),
      redirect: (context, state) => authRedirect(context, state, authCubit),
      routes: [
        GoRoute(
          path: GetStartedScreen.path,
          builder: (context, state) => const GetStartedScreen(),
        ),
        GoRoute(
          path: ThemeModeScreen.path,
          builder: (context, state) => const ThemeModeScreen(),
        ),
        GoRoute(
          path: SignInScreen.path,
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SignInBloc(
                  authRepository: context.read(),
                ),
              ),
              BlocProvider(
                create: (context) => ObscureTextCubit(),
              )
            ],
            child: const SignInScreen(),
          ),
        ),
        GoRoute(
          path: SignUpScreen.path,
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SignUpBloc(
                  authRepository: context.read(),
                ),
              ),
            ],
            child: const SignUpScreen(),
          ),
        ),
        GoRoute(
          path: HomeScreen.path,
          builder: (context, state) => HomeScreen(),
        ),
        GoRoute(
          path: '${ArtistiScreen.path}/:name',
          builder: (context, state) {
            final name = state.pathParameters['name']!;
            return BlocProvider(
              create: (context) => ArtistSongsCubit(songRepository: context.read()),
              child: ArtistiScreen(name: name),
            );
          },
        ),
        GoRoute(
          path: SongPlayerScreen.path,
          builder: (context, state) {
            final songId = state.extra as String;
            return SongPlayerScreen(songId: songId);
          },
        ),
        GoRoute(
          path: ProfileScreen.path,
          builder: (context, state) => BlocProvider(
            create: (context) => MostPlayedCubit(songRepository: context.read()),
            child: ProfileScreen(),
          ),
        ),
        GoRoute(
          path: SearchScreen.path,
          builder: (context, state) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SearchBloc(songRepository: context.read())..searchChange(''),
              ),
              BlocProvider(
                create: (context) => HistoryCubit(historyRepository: context.read()),
              ),
            ],
            child: SearchScreen(),
          ),
        ),
      ],
      errorBuilder: (context, state) => const ErrorScreen(),
    );
  }

  static BuildContext? get currentContext => navigatorKey.currentContext;

  static void showSnackBar(String message) {
    Future.delayed(const Duration(seconds: 1), () {
      if (scaffoldMessengerKey.currentState != null) {
        scaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            backgroundColor: green,
            content: Text(
              message,
              style: semibold_16,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            clipBehavior: Clip.none,
            margin: const EdgeInsets.only(bottom: 4.0, left: 16.0, right: 16.0),
            showCloseIcon: true,
            closeIconColor: black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
        );
      }
    });
  }

  static void showErrorSnackBar(String message) {
    Future.delayed(const Duration(seconds: 1), () {
      if (scaffoldMessengerKey.currentState != null) {
        scaffoldMessengerKey.currentState!.showSnackBar(
          SnackBar(
            backgroundColor: red,
            content: Text(
              message,
              style: semibold_16,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            behavior: SnackBarBehavior.floating,
            clipBehavior: Clip.none,
            margin: const EdgeInsets.only(bottom: 4.0, left: 16.0, right: 16.0),
            showCloseIcon: true,
            closeIconColor: black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
          ),
        );
      }
    });
  }

  static String? authRedirect(BuildContext context, GoRouterState state, AuthCubit authCubit) {
    final authenticationBloc = authCubit.state;

    if (authenticationBloc is! AuthenticatedState && authenticationBloc is! NotAuthenticatedState) {
      return null;
    }

    final isAuthenticated = authenticationBloc is AuthenticatedState;
    final isUnauthenticated = authenticationBloc is NotAuthenticatedState;

    final isOnLoginScreen = state.matchedLocation == SignInScreen.path;
    final isOnRegisterScreen = state.matchedLocation == SignUpScreen.path;
    final isOnThemeScreen = state.matchedLocation == ThemeModeScreen.path;
    final isOnStartScreen = state.matchedLocation == GetStartedScreen.path;

    if (isUnauthenticated && !isOnLoginScreen && !isOnRegisterScreen && !isOnThemeScreen && !isOnStartScreen) {
      return SignInScreen.path;
    }

    if (isAuthenticated && (isOnLoginScreen || isOnRegisterScreen || isOnThemeScreen || isOnStartScreen)) {
      return HomeScreen.path;
    }

    return null;
  }
}
