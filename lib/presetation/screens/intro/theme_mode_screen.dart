import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/domain/cubits/theme/theme_cubit.dart';
import 'package:spotify_clone/domain/helpers/assets/app_images.dart';
import 'package:spotify_clone/domain/helpers/assets/app_vectors.dart';
import 'package:spotify_clone/domain/helpers/is_dark_mode.dart';
import 'package:spotify_clone/presetation/screens/auth/sign_in_screen.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';
import 'package:spotify_clone/presetation/utils/dimensions.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';
import 'package:spotify_clone/presetation/widgets/buttons/basic_button.dart';

class ThemeModeScreen extends StatelessWidget {
  static const String path = '/theme-mode';
  const ThemeModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              context.isDarkMode ? AppImages.themeDarkBG : AppImages.themeLightBG,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withValues(alpha: context.isDarkMode ? 0.65 : 0.40),
          ),
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(24, 56, 24, 24),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVectors.logo),
                ),
                const Spacer(),
                Text(
                  'Scegli il tema',
                  style: bold_22.copyWith(color: white),
                ),
                height_16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: context.isDarkMode
                                    ? BoxDecoration(
                                        color: const Color(0xff30393C).withValues(alpha: 0.5),
                                        shape: BoxShape.circle,
                                      )
                                    : BoxDecoration(
                                        color: black,
                                        shape: BoxShape.circle,
                                      ),
                                child: SvgPicture.asset(
                                  AppVectors.sun,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        height_8,
                        Text(
                          'Chiaro',
                          style: semibold_16.copyWith(color: white),
                        )
                      ],
                    ),
                    width_48,
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: context.isDarkMode
                                    ? BoxDecoration(
                                        color: black,
                                        shape: BoxShape.circle,
                                      )
                                    : BoxDecoration(
                                        color: const Color(0xff30393C).withValues(alpha: 0.5),
                                        shape: BoxShape.circle,
                                      ),
                                child: SvgPicture.asset(
                                  AppVectors.moon,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        height_8,
                        Text(
                          'Scuro',
                          style: semibold_16.copyWith(color: white),
                        )
                      ],
                    ),
                  ],
                ),
                height_24,
                BasicButton(
                  onPressed: () {
                    context.go(SignInScreen.path);
                  },
                  title: 'Iniziamo',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
