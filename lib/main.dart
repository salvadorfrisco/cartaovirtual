import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card/ui/terms_page.dart';
import 'ad_state.dart';
import 'main_page.dart';
import 'ui/intro_screen.dart';
import 'ui/splash_screen.dart';
import 'package:virtual_card/generated/l10n.dart';

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
  WidgetsFlutterBinding.ensureInitialized();
  final initFuture = MobileAds.instance.initialize();
  final adState = AdState(initFuture);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
        Provider.value(
            value: adState,
            builder: (context, child) => GetMaterialApp(
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
            routes: routes)
        ),
    );
  });
}


