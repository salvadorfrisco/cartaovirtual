import 'dart:typed_data';

import 'package:virtual_card/ui/home_page.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../models/card_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ModelSelected implements SliverPersistentHeaderDelegate {
  ModelSelected({this.minExtent, this.maxExtent, this.cardInfo, this.imageBackground, this.profileImage});
  double maxExtent;
  double minExtent;
  CardInfo cardInfo;
  Uint8List imageBackground, profileImage;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
        ),
      margin: EdgeInsets.only(
          top: displayWidth(context) * 0.04,
          left: displayWidth(context) * 0.24,
          right: displayWidth(context) * 0.24,
          bottom: displayWidth(context) * 0.04),
        child: HomePage(
                cardInfo: cardInfo,
                imageBackground: imageBackground,
                profileImage: profileImage,
                widthScreen: displayWidth(context) * 0.52,
                withIcons: false,
              ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;

  @override
  // TODO: implement showOnScreenConfiguration
  PersistentHeaderShowOnScreenConfiguration get showOnScreenConfiguration => null;

  @override
  // TODO: implement vsync
  TickerProvider get vsync => null;
}
