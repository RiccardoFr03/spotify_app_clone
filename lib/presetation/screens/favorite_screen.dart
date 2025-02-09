import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  static const String path = '/favorite';
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Favorite'),
      ),
    );
  }
}
