import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/domain/cubits/auth/auth_cubit.dart';
import 'package:spotify_clone/domain/cubits/theme/theme_cubit.dart';
import 'package:spotify_clone/domain/helpers/is_dark_mode.dart';
import 'package:spotify_clone/presetation/utils/dimensions.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';
import 'package:spotify_clone/presetation/widgets/image_widget.dart';

class ProfileAppBar extends StatefulWidget {
  final ValueNotifier<bool> isExpandedNotifier;
  const ProfileAppBar({super.key, required this.isExpandedNotifier});

  @override
  State<ProfileAppBar> createState() => _ProfileAppBarState();
}

class _ProfileAppBarState extends State<ProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthCubit>().state.user;
    return SliverAppBar(
      backgroundColor:
          context.isDarkMode ? const Color.fromARGB(255, 81, 78, 78) : const Color.fromARGB(255, 170, 162, 162),
      expandedHeight: MediaQuery.of(context).size.height / 3.2,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.fromLTRB(16, 0, 0, 4),
        background: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              height_24,
              _buildProfileImage(context, user.photo),
              height_16,
              Text(
                user.name ?? 'Username',
                style: bold_24,
                textAlign: TextAlign.center,
              ),
              Text(
                user.email ?? 'user@email.com',
                style: semibold_16,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        centerTitle: false,
      ),
      title: ValueListenableBuilder<bool>(
        valueListenable: widget.isExpandedNotifier,
        builder: (context, isExpanded, child) {
          return AnimatedOpacity(
            opacity: isExpanded ? 0.0 : 1.0,
            duration: Duration(milliseconds: 300),
            child: Text(
              'Profilo',
              style: bold_22,
            ),
          );
        },
      ),
      centerTitle: true,
      leading: ValueListenableBuilder<bool>(
        valueListenable: widget.isExpandedNotifier,
        builder: (context, isExpanded, child) {
          return IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: context.isDarkMode
                    ? Colors.white.withValues(alpha: isExpanded ? 0.30 : 0)
                    : Colors.white.withValues(alpha: isExpanded ? 0.50 : 0),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: context.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          );
        },
      ),
      actions: [
        ValueListenableBuilder<bool>(
          valueListenable: widget.isExpandedNotifier,
          builder: (context, isExpanded, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: PopupMenuButton<String>(
                clipBehavior: Clip.hardEdge,
                splashRadius: 16,
                enableFeedback: false,
                menuPadding: EdgeInsets.all(4),
                offset: Offset(0, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                icon: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? Colors.white.withValues(alpha: isExpanded ? 0.30 : 0)
                        : Colors.white.withValues(alpha: isExpanded ? 0.50 : 0),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.settings,
                    size: 24,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                onSelected: (String selected) {
                  if (selected == 'toggle_theme') {
                    context.isDarkMode
                        ? context.read<ThemeCubit>().updateTheme(ThemeMode.light)
                        : context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                  } else if (selected == 'logout') {
                    context.read<AuthCubit>().signOut();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<String>(
                      value: 'toggle_theme',
                      child: Row(
                        children: [
                          Icon(
                            size: 24,
                            context.isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
                            color: context.isDarkMode ? Colors.white : Colors.black,
                          ),
                          SizedBox(width: 8),
                          Text(
                            context.isDarkMode ? 'Modalità Chiara' : 'Modalità Scura',
                            style: semibold_14,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(
                            size: 24,
                            Icons.logout,
                            color: context.isDarkMode ? Colors.white : Colors.black,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Logout',
                            style: semibold_14,
                          ),
                        ],
                      ),
                    ),
                  ];
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

Widget _buildProfileImage(BuildContext context, String? userImg) {
  if (userImg == null) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: context.isDarkMode ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.04),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.person,
        size: 60,
        color: context.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }

  return ImageWidget(
    artistName: '',
    songTitle: '',
    link: userImg,
    borderRadius: 100,
    fit: BoxFit.cover,
    height: 100,
    width: 100,
  );
}
