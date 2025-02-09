import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/domain/helpers/assets/app_images.dart';
import 'package:spotify_clone/domain/helpers/assets/app_vectors.dart';
import 'package:spotify_clone/presetation/screens/intro/theme_mode_screen.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';
import 'package:spotify_clone/presetation/utils/dimensions.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';
import 'package:spotify_clone/presetation/widgets/buttons/basic_button.dart';

class GetStartedScreen extends StatelessWidget {
  static const String path = '/get-started';
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.getStarted,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withValues(alpha: 0.65),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Text(
                        'Vivi la tua musica preferita',
                        style: bold_22.copyWith(color: white),
                      ),
                      height_8,
                      Text(
                        'Riscopri i brani che ami, scopri nuovi suoni che ti emozioneranno e lascia che ogni momento della tua vita abbia la sua colonna sonora.',
                        style: regular_16.copyWith(color: white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                height_24,
                BasicButton(
                  onPressed: () {
                    context.go(ThemeModeScreen.path);
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
