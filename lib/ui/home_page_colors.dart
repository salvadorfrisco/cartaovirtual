import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:virtual_card/models/content_model.dart';
import 'package:virtual_card/utils/block_picker.dart';
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

class HomePageColors extends StatefulWidget {
  HomePageColors(
      {Key key,
      this.cardInfo,
      this.imageBackground,
      this.profileImage,
      this.widthScreen,
      this.withIcons = true})
      : super(key: key);
  final CardInfo cardInfo;
  final Uint8List imageBackground, profileImage;
  final double widthScreen;
  final bool withIcons;
  @override
  _HomePageColorsState createState() => _HomePageColorsState();
}

class _HomePageColorsState extends State<HomePageColors> {
  final _globalKey = new GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _buttonsOn = false, isLoading = false;
  Color _appColor = Color(0xFFF2F2F2);
  double _sizeWidth, _positionColor;
  List<ContentModel> contentList;
  static const Color colorShare = Color(0xCCC63252);
  static const Color colorBack = Color(0xDD123322);
  String _field;

  @override
  Widget build(BuildContext context) {
    _sizeWidth = widget.widthScreen;
    contentList = Functions.loadContent(widget.cardInfo);

    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey, backgroundColor: _appColor, body: buildBody()));
  }

  Widget buildBody() {
    return SafeArea(
      child: Scaffold(
        body: Stack(fit: StackFit.expand, children: [
          RepaintBoundary(
              key: _globalKey,
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
          top: cnt.posY * (_sizeWidth / displayWidth(context)),
          left: cnt.posX * (_sizeWidth / displayWidth(context)),
          child: (cnt.type == 'photo')
              ? _buildPicture()
              : GestureDetector(
                  onTap: () {
                    print(cnt.type);
                    setState(() {
                      _field = cnt.type;
                      _positionColor = cnt.posY + 40;
                      _buttonsOn = true;
                    });
                  },
                  child: Column(
                    children: [
                      Row(
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
                            style: TextStyle(
                                fontSize: cnt.size *
                                    (_sizeWidth / displayWidth(context)),
                                color: cnt.color,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      (_buttonsOn && _field == cnt.type)
                          ? _buildButtons(cnt)
                          : SizedBox(),
                    ],
                  ),
                ));
    }
  }

  _buildButtons(cnt) {
    return Row(
      children: [
        SizedBox(
          height: 28.0,
          child: RaisedButton(
            elevation: 4,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Selecione a cor'),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: cnt.color,
                        above: true, // TODO
                        availableColors: _defaultColors,
                        onColorChanged: changeColorFont,
                      ),
                    ),
                  );
                },
              );
            },
            color: cnt.color,
            child: SizedBox(
              height: 1.0,
            ),
            padding: EdgeInsets.all(0.0),
            shape: CircleBorder(),
          ),
        ),
        IconButton(icon: Icon(Icons.font_download), iconSize: 32, onPressed: null),
        IconButton(icon: Icon(Icons.arrow_drop_up), iconSize: 60, onPressed: null),
        IconButton(icon: Icon(Icons.arrow_drop_down), iconSize: 60, onPressed: null),
      ],
    );
  }

  changeColorFont({Color color, bool above}) {
    // if (above) {
    //   _fontColor = color;
    //   cardInfo.colorTextAbove = colorToString(color);
    // } else {
    //   _backColor = color;
    //   cardInfo.colorTextBelow = colorToString(color);
    // }
    // save();
    // Navigator.pop(context);

    print("AQUI nas CORES");

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
