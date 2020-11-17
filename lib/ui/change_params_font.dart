import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_card/models/content_model.dart';
import 'package:virtual_card/services/storage_service.dart';
import 'package:virtual_card/utils/block_picker.dart';
import 'package:virtual_card/utils/converter_functions.dart';
import 'package:virtual_card/utils/font_picker.dart';
import 'package:virtual_card/utils/functions.dart';
import 'package:virtual_card/utils/responsive.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../models/card_info.dart';

const List<Color> _defaultColors = [
  Colors.red,
  Colors.pink,
  Colors.purpleAccent,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.white,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];

const List<String> _defaultFonts = [
  'Advark',
  'Aquar',
  'Arcade',
  'Armywar',
  'Athletic',
  'Barcode',
  'Bendit',
  'Bernardo',
  'Blacklist',
  'Blocks',
  'Blomster',
  'Caricature',
  'Cartoon',
  'Caste',
  'Catpaw',
  'Champagne',
  'Circus',
  'Cowby',
  'Dancing',
  'Dreams',
  'Excentric',
  'Flower',
  'Forgot',
  'Fuzzy',
  'Giorgino',
  'Grobol',
  'Hannah',
  'Heineken',
  'Hischool',
  'Icecold',
  'Icecream',
  'Kuenstler',
  'LokiCola',
  'Melody',
  'Milestone',
  'Minnie',
  'Montserrat',
  'Music',
  'Neoa',
  'Opficio',
  'Pacifico',
  'Playfair',
  'Playtoy',
  'Porkys',
  'Potter',
  'Resort',
  'Roboto',
  'Rubik',
  'School',
  'Secondch',
  'Smoke',
  'Vanessa',
  'Vegas',
  'Verdana',
  'Vintage',
  'Walkway',
  'Woodcutter',
  'Zornic',
];

class ChangeParamFonts extends StatefulWidget {
  ChangeParamFonts(
      {Key key, this.cardInfo, this.imageBackground, this.profileImage})
      : super(key: key);
  final CardInfo cardInfo;
  final Uint8List imageBackground, profileImage;

  @override
  _ChangeParamFontsState createState() => _ChangeParamFontsState();
}

class _ChangeParamFontsState extends State<ChangeParamFonts> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _buttonsOn = false, isLoading = false, _upSide;
  Color _appColor = Color(0xFFF2F2F2);
  double _sizeWidth, _sizeHeight;
  List<ContentModel> contentList;
  CardInfo cardInfo;
  String _field;
  StorageService storage = StorageService();
  double _dx, _dy;
  Offset _position;
  Timer _timer;
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
  Size elementSize;

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
                  opacity: double.parse(widget.cardInfo.opacity),
                  child: Container(
                    decoration: new BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: widget.imageBackground != null
                            ? MemoryImage(widget.imageBackground)
                            : AssetImage('assets/images/transparent.png'),
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
      isLoading
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
      var _key = getKey(cnt);
      return Positioned(
          top: cnt.posY,
          left: cnt.posX,
          child: Draggable(
            child: Container(child: _buildElement(cnt)),
            feedback: _buildElement(cnt, feed: true),
            onDraggableCanceled: (velocity, offset) {
              RenderBox renderBox = context.findRenderObject();
              _position = renderBox.globalToLocal(offset);
              _dx = _position.dx;
              _dy = _position.dy;

              if ((_dx + getSizeAndPosition(_key).width / 2) > _sizeWidth)
                _dx = _sizeWidth - getSizeAndPosition(_key).width / 2;
              else if (_dx + getSizeAndPosition(_key).width / 2 < -10) _dx = 0;

              if (_dy < 0)
                _dy = 0;
              else if (_dy > _sizeHeight - _sizeHeight * 0.08)
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
                    style: TextStyle(
                        fontFamily: cnt.font,
                        fontSize:
                            cnt.size * (_sizeWidth / displayWidth(context)),
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
            : cnt.posY + (_upSide ? 100 : -100),
        // bottom: _sizeHeight / 6,
        left: _sizeWidth / (cnt.type != 'photo' ? 10 : 6),
        child: _buttonsOn ? _buildButtons(cnt) : SizedBox(),
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
            _buttonSizeFont(cnt),
            _buttonSizeFont(cnt, increase: false),
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
            cardInfo.photoCircle
                ? FontAwesomeIcons.circle
                : Icons.crop_square_sharp,
            color: Colors.black),
        // icon: Icon(Icons.blur_circular, color: cnt.color),
        iconSize:
            Responsive.of(context).widthPercent(cardInfo.photoCircle ? 9 : 11),
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
        icon: Icon(FontAwesomeIcons.font, color: Colors.black),
        iconSize: Responsive.of(context).widthPercent(9),
        onPressed: () {
          _changeFont(cnt);
        });
  }

  _buttonSizeFont(cnt, {increase = true}) {
    var _key = getKey(cnt);
    bool _action = false;
    if (increase)
      _action = _canIncreaseSize(cnt, _key);
    else
      _action = _canDecreaseSize(cnt, _key);
    return GestureDetector(
      onTap: () => _action ? _changeSize(cnt, increase) : {},
      onLongPress: () {
        _timer = Timer.periodic(Duration(milliseconds: 60), (Timer t) {
          _action = false;
          if (increase)
            _action = _canIncreaseSize(cnt, _key);
          else
            _action = _canDecreaseSize(cnt, _key);
          _action ? _changeSize(cnt, increase) : {};
        });
      },
      onLongPressUp: () {
        _timer.cancel();
      },
      child: Padding(
        padding: EdgeInsets.only(top: ((increase) ? 6 : 9), left: 8, right: 8),
        child: Icon(
            increase
                ? Icons.zoom_out_map_sharp
                : FontAwesomeIcons.compressArrowsAlt,
            color: _action ? Colors.black : Colors.black38,
            size: Responsive.of(context).widthPercent((increase) ? 10 : 8)),
      ),
    );
  }

  _buttonColor(cnt) {
    return IconButton(
        icon: Icon(FontAwesomeIcons.palette, color: Colors.black),
        iconSize: Responsive.of(context).widthPercent(9),
        onPressed: () {
          _changeColor(cnt);
        });
  }

  _changeColor(cnt) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecione a cor'),
          content: SingleChildScrollView(
            child: BlockPicker(
              cnt: cnt,
              pickerColor: cnt.color,
              availableColors: _defaultColors,
              onColorChanged: changeColorFont,
            ),
          ),
        );
      },
    );
  }

  changeColorFont({Color color, ContentModel cnt}) {
    switch (cnt.type) {
      case "name":
        widget.cardInfo.colorName = colorToString(color);
        break;
      case "occupation":
        widget.cardInfo.colorOccupation = colorToString(color);
        break;
      case "phone":
        widget.cardInfo.colorPhone = colorToString(color);
        break;
      case "photo":
        widget.cardInfo.colorPhoto = colorToString(color);
        break;
      case "email":
        widget.cardInfo.colorEmail = colorToString(color);
        break;
      case "facebook":
        widget.cardInfo.colorFacebook = colorToString(color);
        break;
      case "instagram":
        widget.cardInfo.colorInstagram = colorToString(color);
        break;
      case "twitter":
        widget.cardInfo.colorTwitter = colorToString(color);
        break;
      case "linkedin":
        widget.cardInfo.colorLinkedin = colorToString(color);
        break;
      case "youtube":
        widget.cardInfo.colorYoutube = colorToString(color);
        break;
      case "website":
        widget.cardInfo.colorWebsite = colorToString(color);
        break;
    }
    saveData(pop: true);
  }

  changeFontFamily({String font, ContentModel cnt}) {
    switch (cnt.type) {
      case "name":
        widget.cardInfo.fontName = font;
        break;
      case "occupation":
        widget.cardInfo.fontOccupation = font;
        break;
      case "phone":
        widget.cardInfo.fontPhone = font;
        break;
      case "photo":
        widget.cardInfo.fontPhoto = font;
        break;
      case "email":
        widget.cardInfo.fontEmail = font;
        break;
      case "facebook":
        widget.cardInfo.fontFacebook = font;
        break;
      case "instagram":
        widget.cardInfo.fontInstagram = font;
        break;
      case "twitter":
        widget.cardInfo.fontTwitter = font;
        break;
      case "linkedin":
        widget.cardInfo.fontLinkedin = font;
        break;
      case "youtube":
        widget.cardInfo.fontYoutube = font;
        break;
      case "website":
        widget.cardInfo.fontWebsite = font;
        break;
    }
    saveData(pop: true);
  }

  getKey(cnt) {
    switch (cnt.type) {
      case "name":
        return _keyName;
        break;
      case "occupation":
        return _keyOccupation;
        break;
      case "phone":
        return _keyPhone;
        break;
      case "photo":
        return _keyPhoto;
        break;
      case "email":
        return _keyEmail;
        break;
      case "facebook":
        return _keyFacebook;
        break;
      case "instagram":
        return _keyInstagram;
        break;
      case "twitter":
        return _keyTwitter;
        break;
      case "linkedin":
        return _keyLinkedin;
        break;
      case "youtube":
        return _keyYoutube;
        break;
      case "website":
        return _keyWebsite;
        break;
    }
  }

  _canIncreaseSize(cnt, key) {
    if (getSizeAndPosition(key).width + cnt.posX > displayWidth(context)) {
      setState(() {});
      return false;
    }
    if (getSizeAndPosition(key).width > displayWidth(context)) {
      setState(() {});
      return false;
    }
    return true;
  } // cnt.posX + getSizeAndPosition(key).width > displayWidth(context);

  _canDecreaseSize(cnt, key) {
    if (getSizeAndPosition(key).width < (cnt.type == 'photo' ? 40 : 120)) {
      setState(() {});
      return false;
    }
    if (cnt.posX * -1 < getSizeAndPosition(key).width / 2) return true;
    if (cnt.posX > 0) return true;

    setState(() {});
    return false;
  } // cnt.posX < 0 && getSizeAndPosition(key).width < ((cnt.posX * -1) * 2);

  _changeSize(cnt, increase) {
    var _key = getKey(cnt);
    bool _action = false;
    double factorSize = (increase)
        ? -2
        : (cnt.scale > 0.6)
            ? 3
            : 0;

    if (increase)
      _action = _canIncreaseSize(cnt, _key);
    else
      _action = _canDecreaseSize(cnt, _key);

    if (_action) {
      switch (cnt.type) {
        case "name":
          widget.cardInfo.scaleName = widget.cardInfo.scaleName +
              (increase
                  ? 0.1
                  : widget.cardInfo.scaleName > 0.6
                      ? -0.1
                      : 0.0);
          widget.cardInfo.posXName = widget.cardInfo.posXName + factorSize;
          widget.cardInfo.posYName = widget.cardInfo.posYName + factorSize;
          break;
        case "occupation":
          widget.cardInfo.scaleOccupation = widget.cardInfo.scaleOccupation +
              (increase
                  ? 0.1
                  : widget.cardInfo.scaleOccupation > 0.6
                      ? -0.1
                      : 0.0);
          widget.cardInfo.posXOccupation =
              widget.cardInfo.posXOccupation + factorSize;
          widget.cardInfo.posYOccupation =
              widget.cardInfo.posYOccupation + factorSize;
          break;
        case "phone":
          widget.cardInfo.scalePhone = widget.cardInfo.scalePhone +
              (increase
                  ? 0.1
                  : widget.cardInfo.scalePhone > 0.6
                      ? -0.1
                      : 0.0);
          widget.cardInfo.posXPhone = widget.cardInfo.posXPhone + factorSize;
          widget.cardInfo.posYPhone = widget.cardInfo.posYPhone + factorSize;

          break;
        case "photo":
          widget.cardInfo.scalePhoto = widget.cardInfo.scalePhoto +
              (increase
                  ? 0.1
                  : widget.cardInfo.scalePhoto > 0.4
                      ? -0.1
                      : 0.0);
          widget.cardInfo.posXPhoto = widget.cardInfo.posXPhoto + factorSize;
          widget.cardInfo.posYPhoto = widget.cardInfo.posYPhoto + factorSize;
          break;
        case "email":
          widget.cardInfo.scaleEmail = widget.cardInfo.scaleEmail +
              (increase
                  ? 0.1
                  : widget.cardInfo.scaleEmail > 0.6
                      ? -0.1
                      : 0.0);
          widget.cardInfo.posXEmail = widget.cardInfo.posXEmail + factorSize;
          widget.cardInfo.posYEmail = widget.cardInfo.posYEmail + factorSize;
          break;
        case "facebook":
          widget.cardInfo.scaleFacebook = widget.cardInfo.scaleFacebook +
              (increase
                  ? 0.1
                  : widget.cardInfo.scaleFacebook > 0.6
                      ? -0.1
                      : 0.0);
          widget.cardInfo.posXFacebook =
              widget.cardInfo.posXFacebook + factorSize;
          widget.cardInfo.posYFacebook =
              widget.cardInfo.posYFacebook + factorSize;
          break;
        case "instagram":
          widget.cardInfo.scaleInstagram = widget.cardInfo.scaleInstagram +
              (increase
                  ? 0.1
                  : widget.cardInfo.scaleInstagram > 0.6
                      ? -0.1
                      : 0.0);
          widget.cardInfo.posXInstagram =
              widget.cardInfo.posXInstagram + factorSize;
          widget.cardInfo.posYInstagram =
              widget.cardInfo.posYInstagram + factorSize;
          break;
        case "twitter":
          widget.cardInfo.scaleTwitter = widget.cardInfo.scaleTwitter +
              (increase
                  ? 0.1
                  : widget.cardInfo.scaleTwitter > 0.6
                      ? -0.1
                      : 0.0);
          widget.cardInfo.posXTwitter =
              widget.cardInfo.posXTwitter + factorSize;
          widget.cardInfo.posYTwitter =
              widget.cardInfo.posYTwitter + factorSize;
          break;
        case "linkedin":
          widget.cardInfo.scaleLinkedin = widget.cardInfo.scaleLinkedin +
              (increase
                  ? 0.1
                  : widget.cardInfo.scaleLinkedin > 0.6
                      ? -0.1
                      : 0.0);
          widget.cardInfo.posXLinkedin =
              widget.cardInfo.posXLinkedin + factorSize;
          widget.cardInfo.posYLinkedin =
              widget.cardInfo.posYLinkedin + factorSize;
          break;
        case "youtube":
          widget.cardInfo.scaleYoutube = widget.cardInfo.scaleYoutube +
              (increase
                  ? 0.1
                  : widget.cardInfo.scaleYoutube > 0.6
                      ? -0.1
                      : 0.0);
          widget.cardInfo.posXYoutube =
              widget.cardInfo.posXYoutube + factorSize;
          widget.cardInfo.posYYoutube =
              widget.cardInfo.posYYoutube + factorSize;
          break;
        case "website":
          widget.cardInfo.scaleWebsite = widget.cardInfo.scaleWebsite +
              (increase
                  ? 0.1
                  : widget.cardInfo.scaleWebsite > 0.6
                      ? -0.1
                      : 0.0);
          widget.cardInfo.posXWebsite =
              widget.cardInfo.posXWebsite + factorSize;
          widget.cardInfo.posYWebsite =
              widget.cardInfo.posYWebsite + factorSize;
          break;
      }
      saveData();
    }
  }

  savePos(type, posX, posY) {
    if (type == 'name') {
      cardInfo.posXName = posX;
      cardInfo.posYName = posY;
    } else if (type == 'occupation') {
      cardInfo.posXOccupation = posX;
      cardInfo.posYOccupation = posY;
    } else if (type == 'phone') {
      cardInfo.posXPhone = posX;
      cardInfo.posYPhone = posY;
    } else if (type == 'photo') {
      cardInfo.posXPhoto = posX;
      cardInfo.posYPhoto = posY;
    } else if (type == 'email') {
      cardInfo.posXEmail = posX;
      cardInfo.posYEmail = posY;
    } else if (type == 'facebook') {
      cardInfo.posXFacebook = posX;
      cardInfo.posYFacebook = posY;
    } else if (type == 'instagram') {
      cardInfo.posXInstagram = posX;
      cardInfo.posYInstagram = posY;
    } else if (type == 'twitter') {
      cardInfo.posXTwitter = posX;
      cardInfo.posYTwitter = posY;
    } else if (type == 'linkedin') {
      cardInfo.posXLinkedin = posX;
      cardInfo.posYLinkedin = posY;
    } else if (type == 'youtube') {
      cardInfo.posXYoutube = posX;
      cardInfo.posYYoutube = posY;
    } else if (type == 'website') {
      cardInfo.posXWebsite = posX;
      cardInfo.posYWebsite = posY;
    }
    saveData();
  }

  _changeFont(cnt) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecione a fonte'),
          content: SingleChildScrollView(
            child: FontPicker(
              cnt: cnt,
              pickerFont: cnt.font,
              availableFonts: _defaultFonts,
              onFontChanged: changeFontFamily,
            ),
          ),
        );
      },
    );
  }

  _changeShape(cnt) {
    setState(() {
      cardInfo.photoCircle = !cardInfo.photoCircle;
    });
    saveData();
  }

  _changeAngle(cnt, {increase = true}) {
    switch (cnt.type) {
      case "name":
        widget.cardInfo.angleName =
            widget.cardInfo.angleName + (increase ? 1 : -1);
        break;
      case "occupation":
        widget.cardInfo.angleOccupation =
            widget.cardInfo.angleOccupation + (increase ? 1 : -1);
        break;
      case "phone":
        widget.cardInfo.anglePhone =
            widget.cardInfo.anglePhone + (increase ? 1 : -1);
        break;
      case "photo":
        widget.cardInfo.anglePhoto =
            widget.cardInfo.anglePhoto + (increase ? 1 : -1);
        break;
      case "email":
        widget.cardInfo.angleEmail =
            widget.cardInfo.angleEmail + (increase ? 1 : -1);
        break;
      case "facebook":
        widget.cardInfo.angleFacebook =
            widget.cardInfo.angleFacebook + (increase ? 1 : -1);
        break;
      case "instagram":
        widget.cardInfo.angleInstagram =
            widget.cardInfo.angleInstagram + (increase ? 1 : -1);
        break;
      case "twitter":
        widget.cardInfo.angleTwitter =
            widget.cardInfo.angleTwitter + (increase ? 1 : -1);
        break;
      case "linkedin":
        widget.cardInfo.angleLinkedin =
            widget.cardInfo.angleLinkedin + (increase ? 1 : -1);
        break;
      case "youtube":
        widget.cardInfo.angleYoutube =
            widget.cardInfo.angleYoutube + (increase ? 1 : -1);
        break;
      case "website":
        widget.cardInfo.angleWebsite =
            widget.cardInfo.angleWebsite + (increase ? 1 : -1);
        break;
    }
    saveData();
  }

  _buildPicture(cnt, feed) {
    if ((widget.cardInfo.hasPhoto)) {
      return widget.profileImage != null
          ? Container(
              key: feed ? null : getKey(cnt),
              margin: EdgeInsets.only(top: _sizeWidth * 0.03),
              width: _sizeWidth * 0.4 * cnt.scale,
              height: _sizeWidth * 0.4 * cnt.scale,
              decoration: new BoxDecoration(
                shape: (widget.cardInfo.photoCircle)
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(widget.profileImage),
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
