import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:virtual_card/models/content_model.dart';
import 'package:virtual_card/services/storage_service.dart';
import 'package:virtual_card/utils/functions.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../models/card_info.dart';

class PositionPage extends StatefulWidget {
  PositionPage({Key key, this.cardInfo, this.imageBackground, this.profileImage}) : super(key: key);
  final CardInfo cardInfo;
  final Uint8List imageBackground, profileImage;
  @override
  _PositionPageState createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> {
  List<ContentModel> contentList;
  bool didLoad = false;
  StorageService storage = StorageService();
  CardInfo cardInfo;
  bool formChanged = false, formSaved = false;
  double _sizeWidth, _sizeHeight, _dx, _dy;
  Offset _position;
  Uint8List imageBackground;

  @override
  void initState() {
    setInitialData();
    Future.delayed(const Duration(milliseconds: 1), () {
      setState(() {});
    });
    super.initState();
  }

  setInitialData() {
    cardInfo = widget.cardInfo;
    loadLocalImages();
    imageBackground = widget.imageBackground;
  }

  @override
  Widget build(BuildContext context) {
    _sizeWidth = displayWidth(context);
    _sizeHeight = displayHeight(context);
    contentList = Functions.loadContent(widget.cardInfo);
    return buildBody();
  }

  Widget buildBody() {
    return SafeArea(
      child: Scaffold(
        body: Stack(fit: StackFit.expand, children: [
          Opacity(
              opacity: double.parse(widget.cardInfo.opacity),
              child: Container(
                decoration: new BoxDecoration(
//                          shape: BoxShape.,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: imageBackground != null
                        ? MemoryImage(imageBackground)
                        : AssetImage('assets/images/white_pixel.jpg'),
                  ),
                ),
              )
          ),
          Stack(
            children: contentList.map((cnt) {
              return _buildItem(cnt);
            }).toList(),
          )
        ]),
      ),
    );
  }

  Widget _buildItem(ContentModel cnt) {
    if ((cnt.txt == '')) {
      return Container(
        height: 0,
      );
    } else {
      return Positioned(
        top: cnt.posY,
        left: cnt.posX,
        child: Draggable(
          child: Container(
              child: _buildElement(cnt)),
          feedback: Material(
            child: Container(
              child: _buildElement(cnt),
              color: Color(0x46ddee00),
            ),
          ),
          onDraggableCanceled: (velocity, offset){
            RenderBox renderBox = context.findRenderObject();
            _position = renderBox.globalToLocal(offset);
            _dx = _position.dx;
            _dy = _position.dy;
            if (_dx < 0)
              _dx = 0;
            else if (_dx > _sizeWidth - _sizeWidth * 0.1)
              _dx = _sizeWidth - _sizeWidth * 0.1;
            if (_dy < 0)
              _dy = 0;
            else if (_dy > _sizeHeight - _sizeHeight * 0.04)
              _dy = _sizeHeight - _sizeHeight * 0.04;
            cnt.posX = _dx;
            cnt.posY = _dy;
            savePos(cnt.type, cnt.posX, cnt.posY);
          },
        )
      );
    }
  }

  _buildElement(cnt) {
    return FittedBox(
      child: Row(
        children: <Widget>[
          (cnt.type == 'photo')
              ? _buildPicture()
              : (cnt.icon != null)
              ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Functions.buildIcon(cnt.type),
                color: cnt.color,
                size: cnt.size,
              ))
              : SizedBox(width: 0),
          (cnt.type == 'photo')
              ? Container(width: 1, height: 1)
              : Text(
            cnt.txt,
            style: TextStyle(
                fontSize: cnt.size,
                color: cnt.color,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Container _buildPicture() {
    return (widget.cardInfo.hasPhoto)
        ? Container(
      margin: EdgeInsets.only(top: _sizeWidth * 0.03),
      width: _sizeWidth * 0.4,
      height: _sizeWidth * 0.4,
      decoration: new BoxDecoration(
        shape: (widget.cardInfo.photoCircle) ? BoxShape.circle : BoxShape.rectangle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: widget.profileImage != null
              ? MemoryImage(widget.profileImage)
              : AssetImage('assets/images/white_pixel.jpg'),
        ),
      ),
    )
        : Container();
  }

  savePos(type, posX, posY) {
    if (type == 'name') { cardInfo.posXName = posX; cardInfo.posYName = posY; }
    else if (type == 'occupation') { cardInfo.posXOccupation = posX; cardInfo.posYOccupation = posY; }
    else if (type == 'phone') { cardInfo.posXPhone = posX; cardInfo.posYPhone = posY; }
    else if (type == 'photo') { cardInfo.posXPhoto = posX; cardInfo.posYPhoto = posY; }
    else if (type == 'email') { cardInfo.posXEmail = posX; cardInfo.posYEmail = posY; }
    else if (type == 'facebook') { cardInfo.posXFacebook = posX; cardInfo.posYFacebook = posY; }
    else if (type == 'instagram') { cardInfo.posXInstagram = posX; cardInfo.posYInstagram = posY; }
    else if (type == 'twitter') { cardInfo.posXTwitter = posX; cardInfo.posYTwitter = posY; }
    else if (type == 'linkedin') { cardInfo.posXLinkedin = posX; cardInfo.posYLinkedin = posY; }
    else if (type == 'youtube') { cardInfo.posXYoutube = posX; cardInfo.posYYoutube = posY; }
    else if (type == 'website') { cardInfo.posXWebsite = posX; cardInfo.posYWebsite = posY; }
    saveData();
  }

  saveData() {
    storage.saveData(cardInfo, false);
    setState(() {});
    // formChanged = false;
    // formSaved = true;
    // setState(() {});
    // Future.delayed(const Duration(seconds: 1), () {
    //   formSaved = false;
    //   setState(() {});
    // });
  }

  loadLocalImages() async {
    imageBackground = await storage.getImage('imageBackground' + cardInfo.version);
  }
}
