import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:virtual_card/common/constants.dart';
import 'package:virtual_card/services/storage_service.dart';
import 'package:virtual_card/ui/intro_screen.dart';
import '../main_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StorageService storage = StorageService();
  String _actualVersion;

  @override
  void initState() {
    verifyDataSaved();
    Future.delayed(Duration(seconds: 3)).then((_){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(_actualVersion ?? "0") != "0" ? MainPage() : IntroScreen()));
    });
    super.initState();
//    Timer(Duration(seconds: 1), () => (_actualVersion ?? "0") != "0" ? CardNavigator.navToHome(context) : CardNavigator.navToIntro(context));
   }

  Future verifyDataSaved() async {
    _actualVersion = await storage.getVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Color(0xFFE3E3E3)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 90.0),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Image.asset('assets/icon/icon.png'),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        NAME,
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Lottie.asset(
                  'assets/lottiefiles/wave_loading.json',
                  frameBuilder: (context, child, composition) {
                    return AnimatedOpacity(
                      child: child,
                      opacity: composition == null ? 0 : 1,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeOut,
                    );
                  },
                  width: 240.0,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
