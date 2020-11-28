import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:virtual_card/ui/terms_page.dart';
import 'main_page.dart';
import 'ui/intro_screen.dart';
import 'ui/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:virtual_card/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MainPage(),
  "/intro": (BuildContext context) => IntroScreen(),
  "/terms": (BuildContext context) => TermsPage(),
};

// Sets a platform override for desktop to avoid exceptions. See
// https://flutter.dev/desktop#target-platform-override for more info.
void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _enablePlatformOverrideForDesktop();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
        MaterialApp(
            title: 'Image Creator',
            localizationsDelegates: [
              // 1
              S.delegate,
              // 2
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
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

// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image Creator',
//       localizationsDelegates: [
//         // 1
//         S.delegate,
//         // 2
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: S.delegate.supportedLocales,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // The [AppBar] title text should update its message
//         // according to the system locale of the target platform.
//         // Switching between English and Spanish locales should
//         // cause this text to update.
//         title: Text(AppLocalizations.of(context).helloWorld),
//       ),
//     );
//   }
// }

