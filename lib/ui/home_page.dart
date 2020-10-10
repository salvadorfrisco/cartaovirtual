import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:virtual_card/models/content_model.dart';
import 'package:virtual_card/utils/functions.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../models/card_info.dart';
import 'cards_page.dart';
import 'config_page.dart';
import 'infos_page.dart';

class HomePage extends StatefulWidget {
  HomePage(
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
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _globalKey = new GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool tipVisible,
      didLoad = false,
      buttonsOn = true,
      buttonHelp = false,
      isLoading = false;
  Color _appColor = Color(0xFFF2F2F2);
  double _sizeWidth;
  List<ContentModel> contentList;
  static const Color colorShare = Color(0xCCC63252);
  static const Color colorBack = Color(0xDD123322);

  @override
  Widget build(BuildContext context) {
    _sizeWidth = widget.widthScreen;
    contentList = Functions.loadContent(widget.cardInfo);

    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        if (!isLoading) openMenu();
      },
      child: Scaffold(
          key: _scaffoldKey, backgroundColor: _appColor, body: buildBody()),
    ));
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
                                : AssetImage('assets/images/white_pixel.jpg'),
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
          isLoading ? Center(child: CircularProgressIndicator(backgroundColor: Colors.black38,)) : Container(),
          widget.withIcons
              ? AnimatedPositioned(
                  right: (buttonsOn)
                      ? (_sizeWidth * 0.054)
                      : -100.00, //_sizeWidth * 0.77,
                  bottom: _sizeWidth * 0.06,
                  duration: Duration(milliseconds: 450),
                  child: _buildCustomButton("enviar", Icons.share, _share,
                      color: colorShare))
              : Container(),
          widget.withIcons
              ? AnimatedPositioned(
                  left: _sizeWidth * 0.06,
                  bottom: (buttonsOn) ? (_sizeWidth * 0.06) : -100.00,
                  duration: Duration(milliseconds: 300),
                  child:
                      _buildCustomButton("conteúdo", Icons.person, _navInfos))
              : Container(),
          widget.withIcons
              ? AnimatedPositioned(
                  left: _sizeWidth * 0.294,
                  bottom: (buttonsOn) ? (_sizeWidth * 0.06) : -100.00,
                  duration: Duration(milliseconds: 375),
                  child: _buildCustomButton(
                      "configurar", Icons.settings, _navConfig))
              : Container(),
          widget.withIcons
              ? AnimatedPositioned(
                  left: _sizeWidth * 0.53,
                  bottom: (buttonsOn) ? (_sizeWidth * 0.06) : -100.00,
                  duration: Duration(milliseconds: 450),
                  child: _buildCustomButton(
                      "cartões", Icons.view_module, _navCards))
              : Container(),
          // widget.withIcons
          //     ? AnimatedPositioned(
          //         left: _sizeWidth * 0.77,
          //         bottom: (buttonsOn) ? (_sizeWidth * 0.06) : -100.00,
          //         duration: Duration(milliseconds: 500),
          //         child: _buildCustomButton("backup", Icons.backup, _navBackup))
          //     : Container(),
        ]),
      ),
    );
  }

  _navInfos() => _navigate('infos');
  _navConfig() => _navigate('config');
  _navCards() => _navigate('cartoes');
  // _navBackup() => _navigate('backup');

  _navigate(page) async {
    Navigator.of(context).pop();
    final result = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => page == 'cartoes'
                ? CardsPage(
                    version: widget.cardInfo.version,
                    profileImage: widget.profileImage)
                : page == 'infos'
                    ? InfosPage(
                        cardInfo: widget.cardInfo,
                        imageBackground: widget.imageBackground
            )
                    : page == 'config'
                        ? ConfigPage(
                            cardInfo: widget.cardInfo,
                            imageBackground: widget.imageBackground,
                            profileImage: widget.profileImage)
                        // : page == 'backup'
                        //     ? BackupPage(
                        //         cardInfo: widget.cardInfo,
                        //         imageBackground: widget.imageBackground,
                        //         profileImage: widget.profileImage)
                            : Container()));
    if (result != null) {
      if (result) setState(() {});
    }
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
          child: FittedBox(
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
                              size: cnt.size *
                                  (_sizeWidth / displayWidth(context)),
                            ))
                        : SizedBox(width: 0),
                (cnt.type == 'photo')
                    ? Container(width: 1, height: 1)
                    : Text(
                        cnt.txt,
                        style: TextStyle(
                            fontSize:
                                cnt.size * (_sizeWidth / displayWidth(context)),
                            color: cnt.color,
                            fontWeight: FontWeight.w500),
                      ),
              ],
            ),
          ));
    }
  }

  _buildPicture() {
    if ((widget.cardInfo.hasPhoto)) {
      return widget.profileImage != null
          ? Container(
              margin: EdgeInsets.only(top: _sizeWidth * 0.03),
              width: _sizeWidth * 0.4,
              height: _sizeWidth * 0.4,
              decoration: new BoxDecoration(
                shape: (widget.cardInfo.photoCircle) ? BoxShape.circle : BoxShape.rectangle,
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

  _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

  void openMenu() {
    setState(() {
      buttonsOn = !buttonsOn;
    });
  }

  void _share() {
    setState(() {
      isLoading = true;
      // openMenu();
    });
    _capturePng().then((img) => _shareImage(img).then((value) => setState(() {
          isLoading = false;
        })));
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
                borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.04))),
            child: FittedBox(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: Functions.contentButton(txt, icon, Colors.white)),
            ),
          ),
        ));
  }

  Future<void> _shareImage(image) async {
    try {
      await Share.file('esys image', 'esys.png', image, 'image/png',
          text:
              'Crie seu cartão digital, disponível para Android em https://bit.ly/35M2WK4, em breve na Apple Store.');
    } catch (e) {
      print('error: $e');
    }
  }
}
