import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Color(0xFF3A9EA2)
          : Color(0xFF3A9EA2);


  static Color whiteColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.black54
          : Colors.white;

  static Color blackColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;

  static Color greyColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.grey[700]!;

  static Color lightGrey(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[200]!
          : Colors.grey[500]!;


  static Color redColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.redAccent[100]!
          : Colors.redAccent;



  static Color backgroundColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF121212)
          : Colors.white;

}
