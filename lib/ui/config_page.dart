import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:virtual_card/ui/colors_page.dart';
import 'package:virtual_card/ui/position_page.dart';
import 'package:virtual_card/ui/theme_page.dart';
import 'package:virtual_card/ui/theme_page_colors.dart';
import 'package:virtual_card/utils/functions.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../main_page.dart';
import '../models/card_info.dart';

class ConfigPage extends StatefulWidget {
  ConfigPage({Key key, this.cardInfo, this.imageUploaded, this.imageBackground, this.profileImage}) : super(key: key);
  final CardInfo cardInfo;
  final Uint8List imageUploaded, imageBackground, profileImage;

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  int _indexPage = 0;
  double _sizeWidth, _sizeHeight, _dy;
  bool alreadyShowMessage = false;

  @override
  Widget build(BuildContext context) {
    _sizeWidth = displayWidth(context);
    _sizeHeight = displayHeight(context);
    if (_dy == null) _dy = 20;
    return SafeArea(
        child: Scaffold(
            body: Stack(
      children: <Widget>[
        _buildScreen(),
        Positioned(
            bottom: _dy,
            child: Draggable(
              child: Container(child: _buildMenu()),
              feedback: Material(
                child: Container(
                  color: Colors.teal,
                  child: _buildMenu(),
                ),
              ),
              onDraggableCanceled: (velocity, offset) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject();
                  _dy = (_sizeHeight - renderBox.globalToLocal(offset).dy)
                     - _sizeHeight * 0.12;
                  if (_dy < 0)
                    _dy = 0;
                  else if (_dy + 90 > _sizeHeight)
                    _dy = _sizeHeight - 90;
                });
              },
            )),
        Positioned(
            top: 30.0,
            left: 10.0,
            child: Functions.buildCustomButton(_navToHome, UniconsLine.arrow_left, tip: 'Voltar')),
      ],
    )));
  }

  _buildMenu() {
    return Container(
      height: _sizeHeight * 0.09,
      width: _sizeWidth,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildCustomButton(
              "Alterar fonte, formato, cor, rotacionar, tamanho",
            UniconsLine.font,
              () => setState(() {
                    _indexPage = 0;
                  }),
              actual: _indexPage == 0,
            icon2: Icons.color_lens,
            icon3: Icons.zoom_out_map_sharp,
            icon4: Icons.rotate_right,),
          _buildCustomButton(
              "Imagem de fundo, opacidade, com upload de imagem",
              UniconsLine.image,
                  () => setState(() {
                _indexPage = 1;
              }),
              actual: _indexPage == 1),
          _buildCustomButton(
              "Alterar cor de fundo, opacidade",
              UniconsLine.palette,
                  () => setState(() {
                _indexPage = 2;
              }),
              actual: _indexPage == 2),
        ],
      ),
    );
  }

  _navToHome() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => MainPage()),
        ModalRoute.withName('/'));
  }

  _buildScreen() {
    switch (_indexPage) {
      case 0:
        return ColorsPage(
          cardInfo: widget.cardInfo,
          profileImage: widget.profileImage,
        );
        break;
      case 1:
        return ThemePage(
          cardInfo: widget.cardInfo,
          profileImage: widget.profileImage,
        );
        break;
      case 2:
        return ThemePageColors(
          cardInfo: widget.cardInfo,
          profileImage: widget.profileImage,
        );
        break;
    }
  }

  _buildCustomButton(tip, icon, action, {actual: false, icon2, icon3, icon4}) {
    return InkWell(
        onTap: action,
        child: Tooltip(
          decoration: BoxDecoration(
            color: Colors.teal,
          ),
          message: tip,
          child: Center(
            child: Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.012),
              width: MediaQuery.of(context).size.width * 0.17,
              height: MediaQuery.of(context).size.width * 0.14,
              decoration: BoxDecoration(
                  color: Colors.black54,
                  border: Border.all(
                    color: actual ? Colors.blueAccent : Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width * 0.04))),
              child: FittedBox(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: (icon2 == null) ?
                    Functions.contentButton(icon, actual ? Colors.orange : Colors.white) :
                    Functions.contentButton4(icon, icon2, icon3, icon4, actual ? Colors.orange : Colors.white)),
            ),
            ),
          ),
        ));
  }
}
