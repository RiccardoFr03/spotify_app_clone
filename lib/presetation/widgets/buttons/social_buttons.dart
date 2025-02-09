import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/domain/helpers/assets/app_vectors.dart';
import 'package:spotify_clone/domain/helpers/is_dark_mode.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';
import 'package:spotify_clone/presetation/utils/dimensions.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';

class SocialButtons extends StatelessWidget {
  final void Function()? onGoogleSignIn;
  final void Function()? onAppleSignIn;
  const SocialButtons({super.key, this.onGoogleSignIn, this.onAppleSignIn});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                thickness: 0.8,
                color: context.isDarkMode ? white : black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text('Oppure', style: regular_16),
            ),
            Expanded(
              child: Divider(
                thickness: 0.8,
                color: context.isDarkMode ? white : black,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onAppleSignIn,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: context.isDarkMode ? white : black,
                    width: 0.8,
                  ),
                ),
                child: SvgPicture.asset(
                  fit: BoxFit.none,
                  AppVectors.logoApple,
                  // ignore: deprecated_member_use
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            width_32,
            GestureDetector(
              onTap: onGoogleSignIn,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: context.isDarkMode ? white : black,
                    width: 0.8,
                  ),
                ),
                child: SvgPicture.asset(
                  fit: BoxFit.none,
                  AppVectors.logoGoogle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
