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
  static const Color colorBack = Color(0xDD123322);
  String _field;
  StorageService storage = StorageService();
  double _dx, _dy;
  Offset _position;

  @override
  void initState() {
    cardInfo = widget.cardInfo;
    super.initState();
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
    return SafeArea(
      child: Scaffold(
        body: Stack(fit: StackFit.expand, children: [
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
                      return _buildItemColor(cnt);
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
      );;
    }
  }

  _buildElement(cnt) {
    return GestureDetector(
      onTap: () {
        print("AQUI");
        print(cnt.type);
        _field = cnt.type;
        _upSide = cnt.posY / _sizeHeight < 0.5;
        setState(() {
          _field = cnt.type;
          _buttonsOn = true;
        });
      },
      child: (cnt.type == 'photo')
        ? _buildPicture()
        : Row(
        children: [
          (cnt.icon != null)
              ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Functions.buildIcon(cnt.type),
                color: cnt.color,
                size: cnt.size *
                    (_sizeWidth / displayWidth(context)),
              ))
              : SizedBox(width: 0),
          Text(
            cnt.txt,
            textScaleFactor: cnt.scale,
            style: TextStyle(
                fontFamily: cnt.font,
                fontSize:
                cnt.size * (_sizeWidth / displayWidth(context)),
                color: cnt.color,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildItemColor(ContentModel cnt) {
    if ((cnt.txt == '' || cnt.type != _field)) {
      return SizedBox();
    } else {
      return Positioned(
        top: cnt.posY + (_upSide ? 50 : -100),
        left: _sizeWidth / 6,
        child: _buttonsOn
            ? _buildButtons(cnt)
            : SizedBox(),
      );
    }
  }

  _buildButtons(cnt) {
    return Center(
      child: Container(
        width: displayWidth(context) * 0.6,
        height: 60,
        decoration: BoxDecoration(
            // color: (cnt.color == Color(0xff607d8b)) ? Colors.black12 : Colors.black38,
            color: Colors.white54,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (cnt.type == 'photo') ? _buttonShape(cnt) : _buttonFont(cnt),
            (cnt.type == 'photo') ? _buttonRotate(cnt) : _buttonColor(cnt),
            _buttonSizeFont(cnt),
            _buttonSizeFont(cnt, increase: false),
          ],
        ),
      ),
    );
  }

  _buttonShape(cnt) {
    print(cnt.type);
    return IconButton(
        // TODO
        icon: Icon(Icons.crop_square_sharp, color: cnt.color),
        // icon: Icon(Icons.blur_circular, color: cnt.color),
        iconSize: 38,
        onPressed: () {
          _changeShape(cnt);
        });
  }

  _buttonRotate(cnt) {
    print(cnt.type);
    return IconButton(
        icon: Icon(Icons.rotate_right, color: cnt.color),
        iconSize: 38,
        onPressed: () {
          _rotate(cnt);
        });
  }

  _buttonFont(cnt) {
    return IconButton(
        icon: Icon(FontAwesomeIcons.font, color: cnt.color),
        iconSize: 34,
        onPressed: () {
          _changeFont(cnt);
        });
  }

  _buttonSizeFont(cnt, {increase = true}) {
    return IconButton(
        icon: Icon(
            (increase)
                ? Icons.zoom_out_map_sharp
                : FontAwesomeIcons.compressArrowsAlt,
            color: cnt.color),
        iconSize: (increase) ? 36 : 28,
        onPressed: () {
          _changeSize(cnt, increase);
        });
  }

  _buttonColor(cnt) {
    return IconButton(
        icon: Icon(FontAwesomeIcons.palette, color: cnt.color),
        iconSize: 34,
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
    storage.saveData(widget.cardInfo, false);
    setState(() {});
    Navigator.pop(context);
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
    storage.saveData(cardInfo, false);
    setState(() {});
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
    storage.saveData(widget.cardInfo, false);
    setState(() {});
    Navigator.pop(context);
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

  _rotate(cnt) {
    // TODO
    print('rotacionar');
  }

  _changeShape(cnt) {
    // TODO
    print('alterar forma');
  }

  _changeSize(cnt, increase) {
    switch (cnt.type) {
      case "name":
        widget.cardInfo.scaleName = widget.cardInfo.scaleName +
            (increase
                ? 0.1
                : widget.cardInfo.scaleName > 0.6
                    ? -0.1
                    : 0.0);
        break;
      case "occupation":
        widget.cardInfo.scaleOccupation = widget.cardInfo.scaleOccupation +
            (increase
                ? 0.1
                : widget.cardInfo.scaleOccupation > 0.4
                    ? -0.1
                    : 0.0);
        break;
      case "phone":
        widget.cardInfo.scalePhone = widget.cardInfo.scalePhone +
            (increase
                ? 0.1
                : widget.cardInfo.scalePhone > 0.4
                    ? -0.1
                    : 0.0);
        break;
      case "photo":
        widget.cardInfo.scalePhoto = widget.cardInfo.scalePhoto +
            (increase
                ? 0.1
                : widget.cardInfo.scalePhoto > 0.4
                    ? -0.1
                    : 0.0);
        break;
      case "email":
        widget.cardInfo.scaleEmail = widget.cardInfo.scaleEmail +
            (increase
                ? 0.1
                : widget.cardInfo.scaleEmail > 0.4
                    ? -0.1
                    : 0.0);
        break;
      case "facebook":
        widget.cardInfo.scaleFacebook = widget.cardInfo.scaleFacebook +
            (increase
                ? 0.1
                : widget.cardInfo.scaleFacebook > 0.4
                    ? -0.1
                    : 0.0);
        break;
      case "instagram":
        widget.cardInfo.scaleInstagram = widget.cardInfo.scaleInstagram +
            (increase
                ? 0.1
                : widget.cardInfo.scaleInstagram > 0.4
                    ? -0.1
                    : 0.0);
        break;
      case "twitter":
        widget.cardInfo.scaleTwitter = widget.cardInfo.scaleTwitter +
            (increase
                ? 0.1
                : widget.cardInfo.scaleTwitter > 0.4
                    ? -0.1
                    : 0.0);
        break;
      case "linkedin":
        widget.cardInfo.scaleLinkedin = widget.cardInfo.scaleLinkedin +
            (increase
                ? 0.1
                : widget.cardInfo.scaleLinkedin > 0.4
                    ? -0.1
                    : 0.0);
        break;
      case "youtube":
        widget.cardInfo.scaleYoutube = widget.cardInfo.scaleYoutube +
            (increase
                ? 0.1
                : widget.cardInfo.scaleYoutube > 0.4
                    ? -0.1
                    : 0.0);
        break;
      case "website":
        widget.cardInfo.scaleWebsite = widget.cardInfo.scaleWebsite +
            (increase
                ? 0.1
                : widget.cardInfo.scaleWebsite > 0.4
                    ? -0.1
                    : 0.0);
        break;
    }
    storage.saveData(widget.cardInfo, false);
    setState(() {});
  }

  _buildPicture() {
    if ((widget.cardInfo.hasPhoto)) {
      return widget.profileImage != null
          ? Container(
              margin: EdgeInsets.only(top: _sizeWidth * 0.03),
              width: _sizeWidth * 0.4,
              height: _sizeWidth * 0.4,
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

  _buildCustomButton(txt, icon, action, {color: colorBack}) {
    return InkWell(
        onTap: action,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.012),
            width: MediaQuery.of(context).size.width * 0.18,
            height: MediaQuery.of(context).size.width * 0.14,
            decoration: BoxDecoration(
                color: color,
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.width * 0.04))),
            child: FittedBox(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: Functions.contentButton(txt, icon, Colors.white)),
            ),
          ),
        ));
  }
}
