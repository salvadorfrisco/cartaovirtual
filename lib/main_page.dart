import 'dart:typed_data';
import 'package:virtual_card/utils/sizes_helpers.dart';
import 'models/card_info.dart';
import 'ui/home_page.dart';
//import 'utils/status_bar_manager.dart';
import 'services/storage_service.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CardInfo cardInfo = CardInfo();
  StorageService storage = StorageService();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  CardInfo cadInfo;
  bool isLoading = false, backupFinalized = false;
  Uint8List profileImage, imageUploaded, imageBackground;

  @override
  void initState() {
   Future.delayed(const Duration(milliseconds: 10), () {
     setState(() {
       // StatusbarManager.changeStatusBarColor(StatusBar.defaultColor);
     });
   });
   super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: storage.getActualCardInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              cardInfo = snapshot.data;
              loadLocalImages();
              return _buildMainScreen();
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  _buildMainScreen() {
    return Scaffold(
      key: scaffoldKey,
      body: HomePage(
        cardInfo: cardInfo,
        widthScreen: displayWidth(context),
        imageBackground: imageBackground,
        profileImage: profileImage,
        withIcons: true,
      ),
    );
  }

  loadLocalImages() async {
    imageUploaded = await storage.getImage('imageUploaded' + cardInfo.version);
    imageBackground = await storage.getImage('imageBackground' + cardInfo.version);
    profileImage = await storage.getImage('profileImage' + cardInfo.version);
  }
}

class StatusBar {
  const StatusBar();

  static ThemeData white = ThemeData(accentColor: Colors.white);
  static ThemeData white10 =
      ThemeData(accentColor: Colors.white.withOpacity(0.1));
  static ThemeData defaultColor =
      ThemeData(accentColor: Color.fromRGBO(1, 27, 43, 1));
}
