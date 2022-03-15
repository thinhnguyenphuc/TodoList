import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child : AnimatedSplashScreen(
            duration: 2000,
            splash: Icons.my_library_books_outlined,
            splashIconSize: 200,
            nextScreen: const HomeScreen(),
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: Colors.white));
  }
}
