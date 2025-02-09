import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/domain/cubits/auth/auth_cubit.dart';
import 'package:spotify_clone/domain/helpers/assets/app_vectors.dart';
import 'package:spotify_clone/domain/helpers/is_dark_mode.dart';
import 'package:spotify_clone/presetation/screens/profile_screen.dart';
import 'package:spotify_clone/presetation/screens/search_screen.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';
import 'package:spotify_clone/presetation/utils/constants.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 72,
      centerTitle: true,
      leading: IconButton(
        color: context.isDarkMode ? white : black,
        onPressed: () {
          context.push(ProfileScreen.path);
        },
        icon: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Container(
              width: 42,
              height: 42,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.isDarkMode ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.04),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(21),
                child: state.user.photo != null
                    ? Image.network(
                        state.user.photo ?? Constants.img,
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person, size: 24);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          );
                        },
                      )
                    : Icon(Icons.person, size: 24),
              ),
            );
          },
        ),
      ),
      title: SvgPicture.asset(
        AppVectors.logo,
        height: 40,
        width: 40,
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.push(SearchScreen.path);
          },
          icon: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: context.isDarkMode ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.04),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search,
              size: 24,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
