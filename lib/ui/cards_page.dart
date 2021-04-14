import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:unicons/unicons.dart';
import 'package:virtual_card/utils/functions.dart';
import 'package:virtual_card/widgets/show_banner.dart';
import '../main_page.dart';
import '../services/storage_service.dart';
import 'package:flutter/material.dart';
import 'home_page_card.dart';
import 'package:virtual_card/generated/l10n.dart';

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
        backgroundColor: Color(0xfff4ffdf),
        body: _build(),
      ),
    );
  }

  _build() {
    return Stack(
      children: [
        _buildGridCards(),
        Positioned(
            top: 30.0,
            left: 10.0,
            child: Functions.buildCustomButton(_navToHome, UniconsLine.arrow_left, tip: S.of(context).goBack)),
      ],
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
            SizedBox(width: 2.0,),
            _buildCard("2"),
          ],
        ),
        SizedBox(height: 6.0,),
        Row(
          children: <Widget>[
            _buildCard("3"),
            SizedBox(width: 3.0,),
            _buildCard("4"),
          ],
        ),
        Container(
          height: 50,
          // margin: EdgeInsets.only(top: 5.0),
          child: ShowBanner(),
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
        opacity: _version == version ? 1.0 : 0.8,
        child: Container(
          color: _version == version
              ? Colors.yellowAccent
              : Colors.transparent,
          width: MediaQuery.of(context).size.width * .9 / 2.04,
          height: MediaQuery.of(context).size.height * .8 / 1.97,
          // margin: EdgeInsets.only(left: 6.0),
          child: Padding(
            padding: EdgeInsets.only(right: (version == '1') ? 4.0 : 0.0, left: (version == '3') ? 6.0 : 2.0, top: (version == '2') ? 2.0 : 4.0),
            child: IgnorePointer(
              child: Container(
                margin: EdgeInsets.all(4.0),
                child: HomePageCard(
                  version: version
            ),
              ),
          ),
        ),
      ),
    ));
  }
}
