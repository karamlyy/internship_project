import 'package:flutter/material.dart';
import 'package:language_learning/presenter/screens/auth/splash/view/splash_body.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SplashBody(),
    );
  }
}
