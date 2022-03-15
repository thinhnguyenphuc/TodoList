import 'package:flutter/material.dart';
import 'resources/Strings.dart';
import 'resources/Themes.dart';
import 'views/SplashScreen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Strings.appName,
        theme: Themes.lightTheme(),
        darkTheme: Themes.getThemeOf(ThemeName.dark),
        initialRoute: '/',
        routes: {
          '/': (context) => const Splash(),
        });
  }
}
