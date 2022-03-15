import 'package:flutter/cupertino.dart';

import '../helpers.dart';

class Insets {

  late double extraSmall;
  late double small;
  late double normal;
  late double large;
  late double extraLarge;

  Insets.of(BuildContext context) {
    if (ScreenSizeHelper.getSize(context).index >= ScreenSize.Large.index) {
      //Large, Extra Large
      extraSmall = 2;
      small = 6;
      normal = 8;
      large = 12;
      extraLarge = 24;

    } else {
      //Small, normal
      extraSmall = 1;
      small = 4;
      normal = 5;
      large = 10;
      extraLarge = 20;
    }

  }


}