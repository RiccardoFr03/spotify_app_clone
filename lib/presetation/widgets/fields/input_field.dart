import 'package:flutter/material.dart';
import 'package:spotify_clone/domain/helpers/is_dark_mode.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';
import 'package:spotify_clone/presetation/utils/shadows.dart';
import 'package:spotify_clone/presetation/utils/text_styles.dart';

class InputField extends StatelessWidget {
  final String label;
  final IconData icon;
  final IconButton? suffixIcon;
  final TextEditingController? controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;
  final bool error;
  final bool? enabled;
  final double? height;

  const InputField({
    super.key,
    required this.label,
    required this.icon,
    this.controller,
    this.keyboardType,
    this.validator,
    this.autovalidateMode,
    this.suffixIcon,
    this.obscureText,
    this.onChanged,
    this.error = false,
    this.enabled,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(boxShadow: inputShadow),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: height != null ? EdgeInsets.all(0) : null,
          fillColor: lightGray,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(color: red, width: 1.0),
          ),
          label: Text(
            label,
            style: regular_16,
          ),
          suffixIconColor: context.isDarkMode ? white : black,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: suffixIcon,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: context.isDarkMode ? white : black, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: context.isDarkMode ? white : black, width: 1.2),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: false,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Icon(
              icon,
              color: context.isDarkMode ? white : black,
            ),
          ),
          errorMaxLines: 1,
          errorStyle: regular_14.copyWith(color: red),
        ),
        controller: controller,
        obscureText: obscureText ?? false,
        autocorrect: false,
        keyboardType: keyboardType,
        validator: validator,
        autovalidateMode: autovalidateMode,
        onChanged: onChanged,
        enabled: enabled ?? true,
      ),
    );
  }
}
