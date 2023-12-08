import 'package:flutter/material.dart';
import 'package:llapp/constants/colors.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: scaffolBackgroundColor,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
