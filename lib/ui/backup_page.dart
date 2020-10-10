import 'dart:typed_data';

import 'package:virtual_card/utils/sizes_helpers.dart';
import 'package:virtual_card/widgets/custom_app_bar.dart';
import '../services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/card_info.dart';
import 'home_page.dart';

class BackupPage extends StatefulWidget {
  BackupPage({Key key, this.cardInfo, this.imageUploaded, this.imageBackground, this.profileImage}) : super(key: key);
  final CardInfo cardInfo;
  final Uint8List imageUploaded, imageBackground, profileImage;
  @override
  _BackupPageState createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  CardInfo cardInfo = CardInfo();
  StorageService storage = StorageService();
  String messageLoading = "", _titleAppBar = "Backup e Restauração";
  bool isLoading = false, formChanged = false, formSaved = false;

  @override
  void initState() {
    setInitialData();
    super.initState();
  }

  setInitialData() {
    cardInfo = widget.cardInfo;
    formChanged = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xff0a1032),
            appBar: CustomAppBar(
                title: _titleAppBar,
                formChanged: formChanged,
                formSaved: formSaved,
                actionSave: saveData,
                actionBack: save),
            body: _buildBody()));
  }

  _buildBody() {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xff0a1032),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: displayHeight(context) * 0.53,
              width: displayWidth(context) * 0.6,
              child: HomePage(
                cardInfo: cardInfo,
                imageBackground: widget.imageBackground,
                profileImage: widget.profileImage,
                widthScreen: displayWidth(context) * 0.53,
                withIcons: false,
              ),
            ),
            SizedBox(height: displayHeight(context) * 0.02),
            LimitedBox(
              maxHeight: displayWidth(context) * 0.45,
              child: _buildButtons(),
            ),
          ],
        ),
        isLoading ? Center(child: CircularProgressIndicator()) : Container(),
      ],
    );
  }

  _buildButtons() {
    return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                _restore();
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.save_alt,
                    size: displayWidth(context) * 0.2,
                    color: Colors.white,
                    semanticLabel: 'Restaurar os dados',
                  ),
                  Text(
                    "Restaurar\nanterior",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: displayWidth(context) * 0.05,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: displayWidth(context) * 0.2),
            InkWell(
              onTap: () {
//                _backup = true;
                _backup();
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.backup,
                    size: displayWidth(context) * 0.2,
                    color: Colors.white,
                    semanticLabel: 'Backup dos dados',
                  ),
                  Text(
                    "Efetuar\nbackup",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: displayWidth(context) * 0.05,
                    ),
                  ),
                ],
              ),
            ),
          ]);
  }

  saveData({backup: false}) {
    storage.saveData(cardInfo, backup);
    formChanged = false;
    formSaved = true;
    setState(() {});
    Future.delayed(const Duration(seconds: 1), () {
      formSaved = false;
      _titleAppBar = "Backup e Restauração";
      setState(() {});
    });
  }

  save() {
    storage.saveData(cardInfo, false);
  }

  Future _restore() async {
    formChanged = true;
    _titleAppBar = "Confirmar restauração";
    cardInfo =
        await storage.getCardInfo(version: cardInfo.version, backup: true);
    setState(() {});
  }

  Future _backup() async {
    await saveData(backup: true);
  }
}
