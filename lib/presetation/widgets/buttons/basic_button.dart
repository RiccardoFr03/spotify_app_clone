import 'package:flutter/material.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';
import 'package:spotify_clone/presetation/widgets/loading_widget.dart';

class BasicButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? title;
  final double? height;
  const BasicButton({required this.onPressed, required this.title, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 64),
      ),
      child: title != null
          ? Text(
              title!,
              style: bold_22.copyWith(color: white),
            )
          : LoadingWidget(),
    );
  }
}
