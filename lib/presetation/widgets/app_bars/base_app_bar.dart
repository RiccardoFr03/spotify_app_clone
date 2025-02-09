import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/cubits/auth/auth_cubit.dart';
import 'package:spotify_clone/domain/helpers/is_dark_mode.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? backgroundColor;
  final bool isPlayer;

  const BaseAppBar({required this.title, this.backgroundColor, super.key, this.isPlayer = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: bold_20,
      ),
      actions: [
        isPlayer
            ? _CustomIconButton(
                icon: Icons.more_vert,
                size: 24,
                onPressed: () {},
              )
            : _CustomIconButton(
                icon: Icons.exit_to_app,
                size: 24,
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                },
              )
      ],
      leading: _CustomIconButton(
        icon: Icons.arrow_back_ios_new,
        size: 18,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final void Function()? onPressed;

  const _CustomIconButton({required this.icon, required this.size, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: context.isDarkMode ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.04),
            shape: BoxShape.circle),
        child: Icon(
          icon,
          size: size,
          color: context.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
