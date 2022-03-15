import 'package:flutter/material.dart';

class ScreenSizeHelper {
  static ScreenSize getSize(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.shortestSide;
    if (deviceWidth > 900) return ScreenSize.ExtraLarge;
    if (deviceWidth > 600) return ScreenSize.Large;
    if (deviceWidth > 300) return ScreenSize.Normal;
    return ScreenSize.Small;
  }
}

enum ScreenSize { Small, Normal, Large, ExtraLarge }