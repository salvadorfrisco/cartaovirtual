import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unicons/unicons.dart';
import 'package:virtual_card/models/content_model.dart';
import 'package:virtual_card/services/storage_service.dart';
import 'package:virtual_card/utils/color_picker.dart';
import 'package:virtual_card/utils/converter_functions.dart';
import 'package:virtual_card/utils/font_picker.dart';
import 'package:virtual_card/utils/functions.dart';
import 'package:virtual_card/utils/responsive.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../models/card_info.dart';

extension GlobalKeyEx on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null)?.getTranslation();
    if (translation != null && renderObject!.paintBounds != null) {
      return renderObject.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}

class ChangeParamFonts extends StatefulWidget {
  ChangeParamFonts(
      {Key? key, this.cardInfo, this.imageBackground, this.profileImage})
      : super(key: key);
  final CardInfo? cardInfo;
  final Uint8List? imageBackground, profileImage;

  @override
  _ChangeParamFontsState createState() => _ChangeParamFontsState();
}

class _ChangeParamFontsState extends State<ChangeParamFonts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? _buttonsOn = false, isLoading = false, _upSide;
  Color _appColor = Color(0xFFF2F2F2);
  late double _sizeWidth, _sizeHeight;
  late List<ContentModel> contentList;
  CardInfo? cardInfo;
  String? _field;
  StorageService storage = StorageService();
  double? _dx, _dy;
  late Offset _position;
  late Timer _timer;

  final GlobalKey _keyName = GlobalKey();
  final GlobalKey _keyOccupation = GlobalKey();
  final GlobalKey _keyPhone = GlobalKey();
  final GlobalKey _keyPhoto = GlobalKey();
  final GlobalKey _keyEmail = GlobalKey();
  final GlobalKey _keyFacebook = GlobalKey();
  final GlobalKey _keyInstagram = GlobalKey();
  final GlobalKey _keyTwitter = GlobalKey();
  final GlobalKey _keyLinkedin = GlobalKey();
  final GlobalKey _keyYoutube = GlobalKey();
  final GlobalKey _keyWebsite = GlobalKey();
  final GlobalKey _keyNameSize = GlobalKey();
  final GlobalKey _keyOccupationSize = GlobalKey();
  final GlobalKey _keyPhoneSize = GlobalKey();
  final GlobalKey _keyPhotoSize = GlobalKey();
  final GlobalKey _keyEmailSize = GlobalKey();
  final GlobalKey _keyFacebookSize = GlobalKey();
  final GlobalKey _keyInstagramSize = GlobalKey();
  final GlobalKey _keyTwitterSize = GlobalKey();
  final GlobalKey _keyLinkedinSize = GlobalKey();
  final GlobalKey _keyYoutubeSize = GlobalKey();
  final GlobalKey _keyWebsiteSize = GlobalKey();
  Size? elementSize;

  double? factorSizeX, factorSizeY, widthOld, heightOld;

  @override
  void initState() {
    cardInfo = widget.cardInfo;
    // WidgetsBinding.instance.addPostFrameCallback((_) => getSizeAndPosition());
    super.initState();
  }

  getSizeAndPosition(key) {
    RenderBox _cardBox = key.currentContext.findRenderObject();
    elementSize = _cardBox.size;
    return elementSize;
  }

  @override
  Widget build(BuildContext context) {
    _sizeWidth = displayWidth(context);
    _sizeHeight = displayHeight(context);
    contentList = Functions.loadContent(widget.cardInfo);
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey, backgroundColor: _appColor, body: buildBody()));
  }

  Widget buildBody() {
    return Stack(fit: StackFit.expand, children: [
      GestureDetector(
          onTap: () {
            setState(() {
              _buttonsOn = false;
            });
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(color: Colors.white),
              Opacity(
                  opacity: double.parse(widget.cardInfo!.opacity!),
                  child: Container(
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.imageBackground != null
                            ? MemoryImage(widget.imageBackground!)
                            : AssetImage('assets/images/transparent.png')) as ImageProvider<Object>,
                      ),
                    ),
                  )),
              Stack(
                children: contentList.map((cnt) {
                  return _buildItem(cnt);
                }).toList(),
              ),
              Stack(
                children: contentList.map((cnt) {
                  return _buildConfigureItem(cnt);
                }).toList(),
              ),
            ],
          )),
      isLoading!
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.black38,
            ))
          : Container(),
    ]);
  }

  Widget _buildItem(ContentModel cnt) {
    if ((cnt.txt == '')) {
      return Container(
        height: 0,
      );
    } else {
      var _keyContent = getKey(cnt);
      var _keyCenterPoint = getKey(cnt, content: false);
      return Positioned(
          top: cnt.posY,
          left: cnt.posX,
          child: Draggable(
            child: Container(
              child: Column(children: [
                _buildElement(cnt),
                Container(
                    width: 80,
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: Row(
                          children: [
                            Icon(Icons.arrow_drop_up,
                                color: (_field == cnt.type && _buttonsOn!)
                                    ? Colors.white
                                    : Colors.transparent,
                                size: 40),
                            Icon(Icons.arrow_drop_up,
                                color: (_field == cnt.type && _buttonsOn!)
                                    ? Colors.red
                                    : Colors.transparent,
                                size: 40,
                                key: _keyCenterPoint),
                            Icon(Icons.arrow_drop_up,
                                color: (_field == cnt.type && _buttonsOn!)
                                    ? Colors.white
                                    : Colors.transparent,
                                size: 40),
                          ],
                        ))),
              ]),
            ),
            feedback: _buildElement(cnt, feed: true),
            onDraggableCanceled: (velocity, offset) {
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              _position = renderBox.globalToLocal(offset);
              _dx = _position.dx;
              _dy = _position.dy;

              // print('absolute coordinates on screen: ${nameRect}');
              // print("AQUI dx: $_dx");
              // print("AQUI dy: $_dy");

              if ((_dx! + getSizeAndPosition(_keyContent).width * .5) >
                  _sizeWidth)
                _dx = _sizeWidth -
                    getSizeAndPosition(_keyContent).width / 2 -
                    Responsive.of(context).widthPercent(10);
              else if (_dx! + getSizeAndPosition(_keyContent).width / 2 < -10)
                _dx = getSizeAndPosition(_keyContent).width / 2 * -1;

              if (_dy! < 0)
                _dy = 0;
              else if (_dy! > _sizeHeight - _sizeHeight * 0.08)
                _dy = _sizeHeight - _sizeHeight * 0.08;

              cnt.posX = _dx;
              cnt.posY = _dy;
              savePos(cnt.type, cnt.posX, cnt.posY);
            },
          ));
    }
  }

  _buildElement(cnt, {feed: false}) {
    return GestureDetector(
      onTap: () {
        _field = cnt.type;
        _upSide = cnt.posY / _sizeHeight < 0.5;
        setState(() {
          _field = cnt.type;
          _buttonsOn = true;
        });
      },
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(cnt.angle / 360),
        child: (cnt.type == 'photo')
            ? _buildPicture(cnt, feed)
            : Row(
                children: [
                  (cnt.icon != null)
                      ? Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Functions.buildIcon(cnt.type),
                            color: cnt.color,
                            size: cnt.size *
                                (_sizeWidth / displayWidth(context)) *
                                cnt.scale,
                          ))
                      : SizedBox(width: 0),
                  Text(
                    cnt.txt,
                    textScaleFactor: cnt.scale,
                    key: feed ? null : getKey(cnt),
                    style: GoogleFonts.getFont(cnt.font!,
                        fontSize: cnt.size! *
                            (_sizeWidth / displayWidth(context)),
                        color: cnt.color,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildConfigureItem(ContentModel cnt) {
    if ((cnt.txt == '' || cnt.type != _field)) {
      return SizedBox();
    } else {
      return Positioned(
        top: cnt.type == 'photo'
            ? _sizeHeight / 2
            : cnt.posY! + (_upSide! ? 100 : -100),
        // bottom: _sizeHeight / 6,
        left: _sizeWidth / (cnt.type != 'photo' ? 10 : 6),
        child: _buttonsOn! ? _buildButtons(cnt) : SizedBox(),
      );
    }
  }

  _buildButtons(cnt) {
    return Center(
      child: Container(
        width:
            Responsive.of(context).widthPercent(cnt.type != 'photo' ? 80 : 70),
        height: Responsive.of(context).heightPercent(9),
        decoration: BoxDecoration(
            // color: (cnt.color == Color(0xff607d8b)) ? Colors.black12 : Colors.black38,
            color: Colors.white54,
            border: Border.all(
              color: cnt.color ?? Colors.transparent,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (cnt.type != 'photo') ? _buttonFont(cnt) : SizedBox(),
            (cnt.type != 'photo') ? _buttonColor(cnt) : SizedBox(),
            (cnt.type == 'photo') ? _buttonShape(cnt) : SizedBox(),
            _buttonSize(cnt, false),
            _buttonSize(cnt, true),
            _buttonRotate(cnt, increase: false),
            _buttonRotate(cnt),
          ],
        ),
      ),
    );
  }

  _buttonShape(cnt) {
    return IconButton(
        icon: Icon(
            cardInfo!.photoCircle! ? UniconsLine.circle : UniconsLine.square,
            color: Colors.black),
        // icon: Icon(Icons.blur_circular, color: cnt.color),
        iconSize:
            Responsive.of(context).widthPercent(cardInfo!.photoCircle! ? 9 : 11),
        onPressed: () {
          _changeShape(cnt);
        });
  }

  _buttonRotate(cnt, {increase = true}) {
    return GestureDetector(
      onTap: () {
        _changeAngle(cnt, increase: increase);
      },
      onLongPress: () {
        _timer = Timer.periodic(Duration(milliseconds: 60),
            (Timer t) => _changeAngle(cnt, increase: increase));
      },
      onLongPressUp: () {
        _timer.cancel();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 7.0),
        child: Icon(increase ? Icons.rotate_right : Icons.rotate_left,
            color: Colors.black, size: Responsive.of(context).widthPercent(11)),
      ),
    );
  }

  _buttonFont(cnt) {
    return IconButton(
        icon: Icon(UniconsLine.font, color: Colors.black),
        iconSize: Responsive.of(context).widthPercent(9),
        onPressed: () {
          _changeFont(cnt);
        });
  }

  _buttonSize(cnt, increase) {
    return GestureDetector(
      onTap: () => _changeSize(cnt, increase),
      onLongPress: () {
        _timer = Timer.periodic(Duration(milliseconds: 60),
            (Timer t) => _changeSize(cnt, increase));
      },
      onLongPressUp: () {
        _timer.cancel();
      },
      child: Padding(
        padding: EdgeInsets.only(top: 6, left: 8, right: 8),
        child: Icon(
            increase ? Icons.zoom_out_map_sharp : UniconsLine.compress_arrows,
            // color: canIncreaseSize(cnt, _keyContent) ? Colors.black : Colors.black38,
            color: Colors.black,
            size: Responsive.of(context).widthPercent(10)),
      ),
    );
  }

  _buttonColor(cnt) {
    return IconButton(
        icon: Icon(Icons.color_lens, color: Colors.black),
        iconSize: Responsive.of(context).widthPercent(9),
        onPressed: () {
          _changeColor(cnt);
        });
  }

  _changeColor(cnt) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return ColorPicker(
                 cnt: cnt,
                 onColorChanged: changeColorFont,
        );
      },
    );
  }

  changeColorFont({Color? color, required ContentModel cnt}) {
    print(color);
    switch (cnt.type) {
      case "name":
        widget.cardInfo!.colorName = colorToString(color);
        break;
      case "occupation":
        widget.cardInfo!.colorOccupation = colorToString(color);
        break;
      case "phone":
        widget.cardInfo!.colorPhone = colorToString(color);
        break;
      case "photo":
        widget.cardInfo!.colorPhoto = colorToString(color);
        break;
      case "email":
        widget.cardInfo!.colorEmail = colorToString(color);
        break;
      case "facebook":
        widget.cardInfo!.colorFacebook = colorToString(color);
        break;
      case "instagram":
        widget.cardInfo!.colorInstagram = colorToString(color);
        break;
      case "twitter":
        widget.cardInfo!.colorTwitter = colorToString(color);
        break;
      case "linkedin":
        widget.cardInfo!.colorLinkedin = colorToString(color);
        break;
      case "youtube":
        widget.cardInfo!.colorYoutube = colorToString(color);
        break;
      case "website":
        widget.cardInfo!.colorWebsite = colorToString(color);
        break;
    }
    saveData(pop: true);
  }

  changeFontFamily({String? font, required ContentModel cnt}) {
    switch (cnt.type) {
      case "name":
        widget.cardInfo!.fontName = font;
        break;
      case "occupation":
        widget.cardInfo!.fontOccupation = font;
        break;
      case "phone":
        widget.cardInfo!.fontPhone = font;
        break;
      case "photo":
        widget.cardInfo!.fontPhoto = font;
        break;
      case "email":
        widget.cardInfo!.fontEmail = font;
        break;
      case "facebook":
        widget.cardInfo!.fontFacebook = font;
        break;
      case "instagram":
        widget.cardInfo!.fontInstagram = font;
        break;
      case "twitter":
        widget.cardInfo!.fontTwitter = font;
        break;
      case "linkedin":
        widget.cardInfo!.fontLinkedin = font;
        break;
      case "youtube":
        widget.cardInfo!.fontYoutube = font;
        break;
      case "website":
        widget.cardInfo!.fontWebsite = font;
        break;
    }
    saveData(pop: true);
  }

  getKey(cnt, {content = true}) {
    switch (cnt.type) {
      case "name":
        return content ? _keyName : _keyNameSize;
        break;
      case "occupation":
        return content ? _keyOccupation : _keyOccupationSize;
        break;
      case "phone":
        return content ? _keyPhone : _keyPhoneSize;
        break;
      case "photo":
        return content ? _keyPhoto : _keyPhotoSize;
        break;
      case "email":
        return content ? _keyEmail : _keyEmailSize;
        break;
      case "facebook":
        return content ? _keyFacebook : _keyFacebookSize;
        break;
      case "instagram":
        return content ? _keyInstagram : _keyInstagramSize;
        break;
      case "twitter":
        return content ? _keyTwitter : _keyTwitterSize;
        break;
      case "linkedin":
        return content ? _keyLinkedin : _keyLinkedinSize;
        break;
      case "youtube":
        return content ? _keyYoutube : _keyYoutubeSize;
        break;
      case "website":
        return content ? _keyWebsite : _keyWebsiteSize;
        break;
    }
  }

  canIncreaseSize(cnt, keySize) {
    final RenderBox renderSign = keySize.currentContext.findRenderObject();
    final positionRed = renderSign.localToGlobal(Offset.zero);
    if (positionRed.dx > displayWidth(context) * .95 ||
        positionRed.dy > displayHeight(context) * .95) return false;
    return true;
  }

  canDecreaseSize(cnt, keySize) {
    final RenderBox renderSign = keySize.currentContext.findRenderObject();
    final positionRed = renderSign.localToGlobal(Offset.zero);
    if (positionRed.dx < 10 || positionRed.dy < 10) return false;
    return true;
  }

  _changeSize(cnt, increase) {
    var _keyCenterPoint = getKey(cnt, content: false);
    bool _action = false;

    if (increase)
      _action = canIncreaseSize(cnt, _keyCenterPoint);
    else
      _action = canDecreaseSize(cnt, _keyCenterPoint);

    if (_action) {
      switch (cnt.type) {
        case "name":
          widget.cardInfo!.scaleName = widget.cardInfo!.scaleName! +
              (increase
                  ? 0.1
                  : widget.cardInfo!.scaleName! > 0.6
                      ? -0.1
                      : 0.0);
          break;
        case "occupation":
          widget.cardInfo!.scaleOccupation = widget.cardInfo!.scaleOccupation! +
              (increase
                  ? 0.1
                  : widget.cardInfo!.scaleOccupation! > 0.6
                      ? -0.1
                      : 0.0);
          break;
        case "phone":
          widget.cardInfo!.scalePhone = widget.cardInfo!.scalePhone! +
              (increase
                  ? 0.1
                  : widget.cardInfo!.scalePhone! > 0.6
                      ? -0.1
                      : 0.0);
          break;
        case "photo":
          widget.cardInfo!.scalePhoto = widget.cardInfo!.scalePhoto! +
              (increase
                  ? 0.1
                  : widget.cardInfo!.scalePhoto! > 0.4
                      ? -0.1
                      : 0.0);
          break;
        case "email":
          widget.cardInfo!.scaleEmail = widget.cardInfo!.scaleEmail! +
              (increase
                  ? 0.1
                  : widget.cardInfo!.scaleEmail! > 0.6
                      ? -0.1
                      : 0.0);
          break;
        case "facebook":
          widget.cardInfo!.scaleFacebook = widget.cardInfo!.scaleFacebook! +
              (increase
                  ? 0.1
                  : widget.cardInfo!.scaleFacebook! > 0.6
                      ? -0.1
                      : 0.0);
          break;
        case "instagram":
          widget.cardInfo!.scaleInstagram = widget.cardInfo!.scaleInstagram! +
              (increase
                  ? 0.1
                  : widget.cardInfo!.scaleInstagram! > 0.6
                      ? -0.1
                      : 0.0);
          break;
        case "twitter":
          widget.cardInfo!.scaleTwitter = widget.cardInfo!.scaleTwitter! +
              (increase
                  ? 0.1
                  : widget.cardInfo!.scaleTwitter! > 0.6
                      ? -0.1
                      : 0.0);
          break;
        case "linkedin":
          widget.cardInfo!.scaleLinkedin = widget.cardInfo!.scaleLinkedin! +
              (increase
                  ? 0.1
                  : widget.cardInfo!.scaleLinkedin! > 0.6
                      ? -0.1
                      : 0.0);
          break;
        case "youtube":
          widget.cardInfo!.scaleYoutube = widget.cardInfo!.scaleYoutube! +
              (increase
                  ? 0.1
                  : widget.cardInfo!.scaleYoutube! > 0.6
                      ? -0.1
                      : 0.0);
          break;
        case "website":
          widget.cardInfo!.scaleWebsite = widget.cardInfo!.scaleWebsite! +
              (increase
                  ? 0.1
                  : widget.cardInfo!.scaleWebsite! > 0.6
                      ? -0.1
                      : 0.0);
          break;
      }
      saveData();
    }
  }

  savePos(type, posX, posY) {
    if (type == 'name') {
      cardInfo!.posXName = posX;
      cardInfo!.posYName = posY;
    } else if (type == 'occupation') {
      cardInfo!.posXOccupation = posX;
      cardInfo!.posYOccupation = posY;
    } else if (type == 'phone') {
      cardInfo!.posXPhone = posX;
      cardInfo!.posYPhone = posY;
    } else if (type == 'photo') {
      cardInfo!.posXPhoto = posX;
      cardInfo!.posYPhoto = posY;
    } else if (type == 'email') {
      cardInfo!.posXEmail = posX;
      cardInfo!.posYEmail = posY;
    } else if (type == 'facebook') {
      cardInfo!.posXFacebook = posX;
      cardInfo!.posYFacebook = posY;
    } else if (type == 'instagram') {
      cardInfo!.posXInstagram = posX;
      cardInfo!.posYInstagram = posY;
    } else if (type == 'twitter') {
      cardInfo!.posXTwitter = posX;
      cardInfo!.posYTwitter = posY;
    } else if (type == 'linkedin') {
      cardInfo!.posXLinkedin = posX;
      cardInfo!.posYLinkedin = posY;
    } else if (type == 'youtube') {
      cardInfo!.posXYoutube = posX;
      cardInfo!.posYYoutube = posY;
    } else if (type == 'website') {
      cardInfo!.posXWebsite = posX;
      cardInfo!.posYWebsite = posY;
    }
    saveData();
  }

  _changeFont(cnt) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return FontPicker(
          cnt: cnt,
          onFontChanged: changeFontFamily,
        );
      },
    );
  }

  _changeShape(cnt) {
    setState(() {
      cardInfo!.photoCircle = !cardInfo!.photoCircle!;
    });
    saveData();
  }

  _changeAngle(cnt, {increase = true}) {
    switch (cnt.type) {
      case "name":
        widget.cardInfo!.angleName =
            widget.cardInfo!.angleName! + (increase ? 1 : -1);
        break;
      case "occupation":
        widget.cardInfo!.angleOccupation =
            widget.cardInfo!.angleOccupation! + (increase ? 1 : -1);
        break;
      case "phone":
        widget.cardInfo!.anglePhone =
            widget.cardInfo!.anglePhone! + (increase ? 1 : -1);
        break;
      case "photo":
        widget.cardInfo!.anglePhoto =
            widget.cardInfo!.anglePhoto! + (increase ? 1 : -1);
        break;
      case "email":
        widget.cardInfo!.angleEmail =
            widget.cardInfo!.angleEmail! + (increase ? 1 : -1);
        break;
      case "facebook":
        widget.cardInfo!.angleFacebook =
            widget.cardInfo!.angleFacebook! + (increase ? 1 : -1);
        break;
      case "instagram":
        widget.cardInfo!.angleInstagram =
            widget.cardInfo!.angleInstagram! + (increase ? 1 : -1);
        break;
      case "twitter":
        widget.cardInfo!.angleTwitter =
            widget.cardInfo!.angleTwitter! + (increase ? 1 : -1);
        break;
      case "linkedin":
        widget.cardInfo!.angleLinkedin =
            widget.cardInfo!.angleLinkedin! + (increase ? 1 : -1);
        break;
      case "youtube":
        widget.cardInfo!.angleYoutube =
            widget.cardInfo!.angleYoutube! + (increase ? 1 : -1);
        break;
      case "website":
        widget.cardInfo!.angleWebsite =
            widget.cardInfo!.angleWebsite! + (increase ? 1 : -1);
        break;
    }
    saveData();
  }

  _buildPicture(cnt, feed) {
    if (widget.cardInfo!.hasPhoto!) {
      return widget.profileImage != null
          ? Container(
              key: feed ? null : getKey(cnt),
              margin: EdgeInsets.only(top: _sizeWidth * 0.03),
              width: _sizeWidth * 0.4 * cnt.scale,
              height: _sizeWidth * 0.4 * cnt.scale,
              decoration: new BoxDecoration(
                shape: widget.cardInfo!.photoCircle!
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(widget.profileImage!),
                ),
              ),
            )
          : Container();
    } else {
      return Container();
    }
  }

  saveData({pop = false}) {
    storage.saveData(widget.cardInfo, false);
    setState(() {});
    if (pop) Navigator.pop(context);
  }
}
