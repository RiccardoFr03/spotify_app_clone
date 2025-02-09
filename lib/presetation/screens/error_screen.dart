import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  static const String path = '/error';
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Error'),
      ),
    );
  }
}
