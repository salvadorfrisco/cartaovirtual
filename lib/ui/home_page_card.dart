import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:virtual_card/services/storage_service.dart';
import 'package:virtual_card/ui/home_page.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../models/card_info.dart';
import 'package:flutter/foundation.dart';

class HomePageCard extends StatefulWidget {
  HomePageCard({Key? key, this.version}) : super(key: key);

  final String? version;

  @override
  _HomePageCardState createState() => _HomePageCardState();
}

class _HomePageCardState extends State<HomePageCard> {
  bool? tipVisible, didLoad = false;
  StorageService storage = StorageService();
  Future<CardInfo>? cardInfoFuture;
  CardInfo? cardInfo = CardInfo();
  Future<Uint8List>? imageBackgroundFuture, profileImageFuture;
  Uint8List? imageBackground, profileImage;

  @override
  void initState() {
    cardInfoFuture = getCardInfo(widget.version);
    imageBackgroundFuture = storage.getImage('imageBackground' + widget.version!);
    profileImageFuture = storage.getImage('profileImage' + widget.version!);
    Future.delayed(const Duration(milliseconds: 100), () => setState(() {}));
    super.initState();
  }

  Future<CardInfo> getCardInfo(version) async {
    CardInfo card = await storage.getCardInfo(version: version);
    return card;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CardInfo>(
        future: cardInfoFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          cardInfo = snapshot.data;
          return FutureBuilder<Uint8List>(
              future: profileImageFuture,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                profileImage = snapshot.data;
                return FutureBuilder<Uint8List>(
                    future: imageBackgroundFuture,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      imageBackground = snapshot.data;
                      return _buildHomePage();
                    });
              });
        });
  }

  _buildHomePage() {
    return HomePage(
      cardInfo: cardInfo,
      imageBackground: imageBackground,
      profileImage: profileImage,
      widthScreen: displayWidth(context) * 0.4,
      withIcons: false,
    );
  }
}
