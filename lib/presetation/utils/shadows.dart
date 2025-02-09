import 'package:flutter/material.dart';
import 'package:spotify_clone/presetation/utils/colors.dart';

List<BoxShadow> get inputShadow {
  return const [
    BoxShadow(
      color: lightGray,
      blurRadius: 16,
      offset: Offset(0, 0),
      spreadRadius: 0,
    )
  ];
}
