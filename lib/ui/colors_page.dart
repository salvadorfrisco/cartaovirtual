import 'dart:typed_data';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/card_info.dart';
import 'change_params_font.dart';

class ColorsPage extends StatefulWidget {
  ColorsPage({Key? key, this.cardInfo, this.profileImage}) : super(key: key);
  final CardInfo? cardInfo;
  final Uint8List? profileImage;
  @override
  _ColorsPageState createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StorageService storage = StorageService();
  CardInfo? cardInfo = CardInfo();
  Color? _appColor = Colors.blueGrey;
  bool isLoading = false, didLoad = false;
  Uint8List? profileImage, imageBackground;

  @override
  void initState() {
    setInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadImageBackground(widget.cardInfo!.version),
        builder: (context, snapshot) {
          return Scaffold(
              key: _scaffoldKey,
              backgroundColor: _appColor,
              body: Stack(
                children: <Widget>[
                  ChangeParamFonts(
                      cardInfo: cardInfo,
                      imageBackground: imageBackground,
                      profileImage: widget.profileImage),
                  // Positioned(
                  //     top: displayHeight(context) / 4,
                  //     right: 10,
                  //     child: _transparencyControl()),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Container(),
                ],
              ));
        });
  }

  save() {
    storage.saveData(cardInfo, false);
    setState(() {});
  }

  setInitialData() {
    cardInfo = widget.cardInfo;
  }

  Future<void> loadImageBackground(version) async => await storage
      .getImage('imageBackground' + version)
      .then((img) => imageBackground = img);

  Future<void> loadProfileImage(version) async => await storage
      .getImage('profileImage' + version)
      .then((img) => profileImage = img);
}
