import 'dart:typed_data';
import 'package:virtual_card/blocs/colors_bloc.dart';
import 'package:virtual_card/blocs/theme_bloc.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../utils/block_picker.dart';
import '../services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../utils/converter_functions.dart';
import '../models/card_info.dart';
import 'home_page_stateless.dart';

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
  ColorsPage({Key key, this.cardInfo, this.imageBackground, this.profileImage})
      : super(key: key);
  final CardInfo cardInfo;
  final Uint8List imageBackground, profileImage;
  @override
  _ColorsPageState createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StorageService storage = StorageService();
  CardInfo cardInfo = CardInfo();
  Color _fontColor, _backColor, _color, _appColor = Colors.blueGrey;
  bool isLoading = false;
  double _sizeHeight;
  Uint8List profileImage, imageBackground;
  ColorsBloc colorsBloc = ColorsBloc();
  ThemeBloc themeBloc = ThemeBloc();

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

  _initListeners(){
    colorsBloc.colorsStream.listen((card) {
      setState(() {
        cardInfo.opacity = card.opacity;
      });
     });
  }

  @override
  Widget build(BuildContext context) {
    _sizeHeight = displayHeight(context);
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: _appColor,
            body: Stack(
              children: <Widget>[
                StreamBuilder<dynamic>(
                  // initialData: imageBackground,
                  stream: themeBloc.themeStream,
                  builder: (context, snapshot) {




                    return HomePageStateLess(
                        cardInfo: cardInfo,
                        imageBackground: (snapshot.data) ? snapshot.data : imageBackground,
                        profileImage: widget.profileImage,
                        widthScreen: displayWidth(context));
                  }
                ),
                Center(
                    // left: 14,
                    // top: _sizeHeight / 2,
                    child: _controlColors()),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(),
              ],
            )));
  }

  _buildSetFontColor(above) {
    _color = above ? _fontColor : _backColor;
    return 
     Padding(padding: EdgeInsetsDirectional.only(top: 20.0, bottom: 20.0),
     child:
     RaisedButton(
      elevation: 6,
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Selecione a cor'),
              content: SingleChildScrollView(
                child: BlockPicker(
                  pickerColor: _color,
                  above: above,
                  availableColors: _defaultColors,
                  onColorChanged: changeColorFont,
                ),
              ),
            );
          },
        );
      },
      color: _color,
      child: SizedBox(
        height: 15.0,
      ),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    ));
  }

  _controlColors() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSetFontColor(true),
        Container(
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
            }
            //   cardInfo.opacity = (newValue.round() / 10).toString();
            //   save();
            //   setState(() {});
            // },
          ),
        ),
        _buildSetFontColor(false),
      ],
    );
  }

  changeColorFont({Color color, bool above}) {
    if (above) {
      _fontColor = color;
      cardInfo.colorTextAbove = colorToString(color);
    } else {
      _backColor = color;
      cardInfo.colorTextBelow = colorToString(color);
    }
    save();
    Navigator.pop(context);
  }

  save() {
    storage.saveData(cardInfo, false);
    setState(() {});
  }

  setInitialData() {
    cardInfo = widget.cardInfo;
    if ((cardInfo.colorTextAbove ?? '').length > 0)
      _fontColor = intelligentCast<Color>(cardInfo.colorTextAbove);
    else
      _fontColor = Color(0xffEBF6aa);
    if ((cardInfo.colorTextBelow ?? '').length > 0)
      _backColor = intelligentCast<Color>(cardInfo.colorTextBelow);
    else
      _backColor = Color(0xff3b73de);
    imageBackground = widget.imageBackground;
    loadLocalImages();
  }

  loadLocalImages() async {
    imageBackground =
        await storage.getImage('imageBackground' + cardInfo.version);
    profileImage = await storage.getImage('profileImage' + cardInfo.version);
  }
}
