import 'dart:typed_data';
import 'package:virtual_card/blocs/colors_bloc.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/card_info.dart';
import 'change_params_font.dart';

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

class ColorsPage extends StatefulWidget {
  ColorsPage({Key key, this.cardInfo, this.profileImage}) : super(key: key);
  final CardInfo cardInfo;
  final Uint8List profileImage;
  @override
  _ColorsPageState createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StorageService storage = StorageService();
  CardInfo cardInfo = CardInfo();
  Color _fontColor, _backColor, _color, _appColor = Colors.blueGrey;
  bool isLoading = false, didLoad = false;
  Uint8List profileImage, imageBackground;
  ColorsBloc colorsBloc = ColorsBloc();

  @override
  void dispose() {
    colorsBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setInitialData();
    _initListeners();
    super.initState();
  }

  _initListeners() {
    colorsBloc.colorsStream.listen((card) {
      setState(() {
        cardInfo.opacity = card.opacity;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadImageBackground(widget.cardInfo.version),
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

  _transparencyControl() {
    return RotatedBox(
        quarterTurns: 1,
        child: Container(
          width: displayWidth(context) * 0.6,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.black38,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Slider(
              value: double.parse(cardInfo.opacity) * 10,
              min: 0.0,
              max: 10.0,
              divisions: 40,
              activeColor: Colors.white,
              inactiveColor: Colors.black,
              onChanged: (double newValue) {
                cardInfo.opacity = (newValue / 10).toString();
                colorsBloc.updateOpacity(cardInfo);
              }),
        ));
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
