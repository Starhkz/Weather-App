import 'package:flutter/material.dart';

class AppColors {
  //uncategorized
  static const background = Color.fromARGB(255, 41, 47, 63);

  static const darkBack = Color.fromARGB(255, 17, 19, 26);

  static const lightBack = Color.fromARGB(255, 65, 71, 86);

  static const lightBlue = Color.fromARGB(255, 3, 170, 241);

  static const orange = Color.fromARGB(255, 241, 130, 3);

  static const lilac = Color.fromARGB(255, 180, 71, 234);

  static const grey = Color.fromARGB(255, 55, 63, 78);

  static const lightGrey = Color.fromARGB(255, 122, 129, 148);

  static const lightGreen = Color.fromARGB(255, 0, 172, 129);

  //grey
  static const greys = MaterialColor(
    0xffDCDCDC, //same as grey100 from the design guide
    {
      300: Color(0xff8A8A8A),
      400: Color(0xff6D6D6D),
      500: Color(0xff434343),
      600: Color(0xff353535),
      700: Color(0xff282828),
      800: Color(0xff101010),
    },
  );
}
