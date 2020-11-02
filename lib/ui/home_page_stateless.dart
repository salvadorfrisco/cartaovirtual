import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:virtual_card/models/content_model.dart';
import 'package:virtual_card/utils/functions.dart';
import '../models/card_info.dart';

class HomePageStateLess extends StatelessWidget {
  HomePageStateLess({Key key, this.cardInfo, this.imageBackground, this.profileImage, this.widthScreen})
      : super(key: key);
  final CardInfo cardInfo;
  final Uint8List imageBackground, profileImage;
  final double widthScreen;

  @override
  Widget build(BuildContext context) {
    final List<ContentModel> contentList = Functions.loadContent(cardInfo);
    return SafeArea(
      child: Scaffold(
        body: Stack(fit: StackFit.expand, children: [
          Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(color: Colors.white),
              Opacity(
                  opacity: double.parse(cardInfo.opacity),
                  child: Container(
                    decoration: new BoxDecoration(
//                          shape: BoxShape.,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: imageBackground != null
                            ? MemoryImage(imageBackground)
                            : AssetImage('assets/images/transparent.png'),
                      ),
                    ),
                  )
              ),
              Stack(
                children: contentList.map((cnt) {
                  return _buildItem(cnt);
                }).toList(),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _buildItem(ContentModel cnt) {
    if ((cnt.txt == '' || cnt.type == 'photo')) {
      return Container(
        height: 0,
      );
    } else {
      return Positioned(
          top: cnt.posY,
          left: cnt.posX,
          child: Row(
            children: [
              (cnt.icon != null)
                  ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Functions.buildIcon(cnt.type),
                    color: cnt.color,
                    size: cnt.size,
                  ))
                  : SizedBox(width: 0),
              Text(
                cnt.txt,
                textScaleFactor: cnt.scale,
                style: TextStyle(
                    fontFamily: cnt.font,
                    fontSize: cnt.size,
                    color: cnt.color,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ));
    }
  }

  _buildPicture() {
    if ((cardInfo.hasPhoto)) {
      return profileImage != null ? Container(
        margin: EdgeInsets.only(top: widthScreen * 0.03),
        width: widthScreen * 0.4,
        height: widthScreen * 0.4,
        decoration: new BoxDecoration(
          shape: (cardInfo.photoCircle) ? BoxShape.circle : BoxShape.rectangle,
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: MemoryImage(profileImage),
          ),
        ),
      ) : Container();
    } else {
      return Container();
    }
  }
}
