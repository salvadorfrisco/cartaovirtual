import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:virtual_card/ui/terms_page.dart';
import 'main_page.dart';
import 'ui/intro_screen.dart';
import 'ui/splash_screen.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MainPage(),
  "/intro": (BuildContext context) => IntroScreen(),
  "/terms": (BuildContext context) => TermsPage(),
};

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
        MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: [const Locale('pt', 'BR')],
            theme:
            ThemeData(
              primaryColor: Color(0xff0a1032),
              accentColor: Colors.white,
            ),
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            routes: routes));
  });
}
