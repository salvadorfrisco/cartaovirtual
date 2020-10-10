import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import '../main_page.dart';
import '../services/storage_service.dart';
import 'package:flutter/material.dart';
import 'home_page_card.dart';

class CardsPage extends StatefulWidget {
  CardsPage({Key key, this.version, this.profileImage}) : super(key: key);
  final String version;
  final Uint8List profileImage;
  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  StorageService storage = StorageService();
  String _version;
  bool isLoading = false,
      formChanged = false,
      formSaved = false;

  @override
  void initState() {
    setInitialData();
    super.initState();
  }

  setInitialData() {
    _version = widget.version;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff0a1032),
//        appBar: AppBar(
//          leading: IconButton(
//            icon: Icon(Icons.arrow_back, color: Colors.white),
//            onPressed: () { _navToHome(); },
//          ),),
        body: _buildGridCards(),
      ),
    );
  }

  _navToHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => MainPage()),
      ModalRoute.withName('/'),
    );
  }

  save() {
    storage.saveVersion(_version);
    _navToHome();
  }

  _buildGridCards() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildCard("1"),
            _buildCard("2"),
          ],
        ),
        SizedBox(height: 10.0,),
        Row(
          children: <Widget>[
            _buildCard("3"),
            _buildCard("4"),
          ],
        )
      ],
    );
  }

  _buildCard(version) {
    return GestureDetector(
      onTap: () {
        _version = version;
        save();
      },
      child: Opacity(
        opacity: _version == version ? 1.0 : 0.7,
        child: Container(
          color: _version == version
              ? Colors.yellowAccent
              : Colors.transparent,
          width: MediaQuery.of(context).size.width * .9 / 2.04,
          height: MediaQuery.of(context).size.height * .8 / 1.97,
          margin: EdgeInsets.only(
              left: 10.0),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: IgnorePointer(
              child: HomePageCard(
                version: version
            ),
          ),
        ),
      ),
    ));
  }
}
