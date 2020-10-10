import 'package:flutter/material.dart';

class CardNavigator {
  static void navToHome(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/home");
  }

  static void navToIntro(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/intro");
  }

  static void navToTipOfTheDay(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/tipoftheday");
  }
  
  static void navToTerms(BuildContext context) {
    Navigator.pushNamed(context, "/terms");
  }
}
