import 'dart:typed_data';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import 'package:virtual_card/widgets/show_banner.dart';
import 'ad_state.dart';
import 'models/card_info.dart';
import 'ui/home_page.dart';
//import 'utils/status_bar_manager.dart';
import 'services/storage_service.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  CardInfo? cardInfo = CardInfo();
  StorageService storage = StorageService();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  CardInfo? cadInfo;
  bool isLoading = false, backupFinalized = false;
  Uint8List? profileImage, imageUploaded, imageBackground;
  // BannerAd banner;

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
              cardInfo = snapshot.data as CardInfo;
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
      body:
      // Column(
      //   children: [
      //     Expanded(
      //       child:
            HomePage(
              cardInfo: cardInfo,
              widthScreen: displayWidth(context),
              imageBackground: imageBackground,
              profileImage: profileImage,
              withIcons: true,
            ),
          // ),
          // Container(
          //   color: Colors.black87,
          //   height: banner == null ? 1 : 56,
          //   child: banner == null
          //       ? SizedBox(
          //           height: 1,
          //         )
          //       : ShowBanner(),
          // )
        // ],
      // ),
    );
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final adState = Provider.of<AdState>(context);
  //   adState.initialization.then((status) {
  //     setState(() {
  //       banner = BannerAd(
  //         adUnitId: adState.bannerAdUnitId,
  //         size: AdSize.banner,
  //         request: AdRequest(),
  //         listener: adState.adListener,
  //       )..load();
  //     });
  //   });
  // }

  loadLocalImages() async {
    imageUploaded =
        await storage.getImage('imageBackground' + cardInfo!.version!);
    imageBackground =
        await storage.getImage('imageBackground' + cardInfo!.version!);
    profileImage = await storage.getImage('profileImage' + cardInfo!.version!);
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
