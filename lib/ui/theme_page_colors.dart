import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:unicons/unicons.dart';
import 'package:virtual_card/utils/functions.dart';
import 'package:virtual_card/utils/responsive.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/card_info.dart';
import 'home_page.dart';

class ThemePageColors extends StatefulWidget {
  ThemePageColors(
      {Key? key,
      this.cardInfo,
      this.imageUploaded,
      this.imageBackground,
      this.profileImage})
      : super(key: key);
  final CardInfo? cardInfo;
  final Uint8List? imageUploaded, imageBackground, profileImage;
  @override
  _ThemePageColorsState createState() => _ThemePageColorsState();
}

class _ThemePageColorsState extends State<ThemePageColors> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var textEditingController = TextEditingController();
  StorageService storage = StorageService();
  CardInfo? cardInfo = CardInfo();
  Color _appColor = Colors.white54;
  Uint8List? imageBackground, profileImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadImageBackground(widget.cardInfo!.version),
        builder: (context, snapshot) {
          return SafeArea(
              child: Scaffold(
                  key: _scaffoldKey,
                  backgroundColor: _appColor,
                  body: Stack(
                    children: <Widget>[
                      _selectModel(context),
                      Positioned(
                          top: Responsive.of(context).heightPercent(4),
                          right: 10,
                          child: Column(children: [
                            _transparencyControl(),
                            SizedBox(
                              height: 12,
                            ),
                            _buildColorChangeButton(
                                "Aplicar efeito textura fina",
                                UniconsLine.ellipsis_v,
                                'fine'),
                            SizedBox(
                              height: 12,
                            ),
                            _buildColorChangeButton(
                                "Aplicar efeito textura forte",
                                UniconsLine.draggabledots,
                                'strong'),
                          ])),
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                            ))
                          : Container(),
                    ],
                  )));
        });
  }

  _buildColorChangeButton(tip, icon, type) {
    return InkWell(
        onTap: type == 'fine'
            ? changeTextureFine
            : changeTextureStrong,
        child: Tooltip(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            message: tip,
            child: Center(
                child: Container(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              width: MediaQuery.of(context).size.width * 0.12,
              height: MediaQuery.of(context).size.width * 0.16,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  border: Border.all(
                    color: ((widget.cardInfo!.colorTextBelow == "20" &&
                        type == "fine") ||
                        (widget.cardInfo!.colorTextBelow == "40" &&
                            type == "strong"))
                        ? Colors.orangeAccent
                        : Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.width * 0.07))),
              child: FittedBox(
                child: Column(
                  children: Functions.contentButton(
                      icon,
                      ((widget.cardInfo!.colorTextBelow == "20" &&
                                  type == "fine") ||
                              (widget.cardInfo!.colorTextBelow == "40" &&
                                  type == "strong"))
                          ? Colors.orangeAccent
                          : Colors.white),
                ),
              ),
            ))));
  }

  changeTextureFine() async {

    int indexSumBelow = (widget.cardInfo!.colorTextBelow.length > 2 ? 0 : int.parse(widget.cardInfo!.colorTextBelow));
    int indexSumAbove = (widget.cardInfo!.colorTextAbove.length > 2 ? 0 : int.parse(widget.cardInfo!.colorTextAbove));

    if (widget.cardInfo!.colorTextBelow == "20")
      widget.cardInfo!.colorTextBelow = "0";
    else
      widget.cardInfo!.colorTextBelow = "20";
    storage.saveData(widget.cardInfo, false);
    int indexImg = indexSumAbove +
        1 +
    indexSumBelow;
    String img = 'assets/images/back_' +
        indexImg.toString() +
        '.' +
        (indexImg <= 20 ? 'jpg' : 'gif');
    isLoading = true;
    ByteData bytes = await rootBundle.load(img);
    var buffer = bytes.buffer;
    await saveImage(
        base64.encode(Uint8List.view(buffer)), widget.cardInfo!.version);
    setState(() {});
  }

  changeTextureStrong() async {
    if (widget.cardInfo!.colorTextBelow == "40")
      widget.cardInfo!.colorTextBelow = "0";
    else
      widget.cardInfo!.colorTextBelow = "40";
    storage.saveData(widget.cardInfo, false);
    int indexImg = int.parse(widget.cardInfo!.colorTextAbove) +
        1 +
        int.parse(widget.cardInfo!.colorTextBelow);
    String img = 'assets/images/back_' +
        indexImg.toString() +
        '.' +
        (indexImg <= 20 ? 'jpg' : 'gif');
    isLoading = true;
    ByteData bytes = await rootBundle.load(img);
    var buffer = bytes.buffer;
    await saveImage(
        base64.encode(Uint8List.view(buffer)), widget.cardInfo!.version);
    setState(() {});
  }

  _transparencyControl() {
    return RotatedBox(
        quarterTurns: 1,
        child: Tooltip(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            message: "Alterar a opacidade da imagem de fundo",
            child: Container(
              width: displayWidth(context) * 0.5,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Slider(
                  value: double.parse(cardInfo!.opacity) * 10,
                  min: 0.0,
                  max: 10.0,
                  divisions: 40,
                  activeColor: Colors.white,
                  inactiveColor: Colors.black,
                  onChanged: (double newValue) {
                    setState(() {
                      cardInfo!.opacity = (newValue / 10).toString();
                      storage.saveData(cardInfo, false);
                    });
                  }),
            )));
  }

  Widget _selectModel(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              stretch: true,
              pinned: true,
              floating: true,
              backgroundColor: Colors.transparent,
              collapsedHeight: 140,
              expandedHeight: 400,
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                stretchModes: [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground
                ],
                background: HomePage(
                    cardInfo: cardInfo,
                    imageBackground: imageBackground,
                    profileImage: widget.profileImage,
                    widthScreen: displayWidth(context) * 1,
                    withIcons: false),
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.80,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  int indexImg =
                      index + 1 + (widget.cardInfo!.colorTextBelow.length > 2 ? 0 : int.parse(widget.cardInfo!.colorTextBelow));
                  String img = 'assets/images/back_' +
                      indexImg.toString() +
                      '.' +
                      (indexImg <= 20 ? 'jpg' : 'gif');
                  return showImageCard(img, widget.cardInfo!.version, index);
                },
                childCount: 20,
              ),
            )
          ],
        ),
      ],
    );
  }

  setInitialData() {
    cardInfo = widget.cardInfo;
  }

  Future<void> loadImageBackground(version) async => await storage
      .getImage('imageBackground' + version)
      .then((img) => imageBackground = img);

  saveImage(img64, version) {
    setState(() {
      StorageService.savePhotoLocal64(img64, 'imageBackground', version);
      isLoading = false;
    });
  }

  showImageCard(url, version, index) {
    showImage() async {
      setState(() {
        isLoading = true;
      });
      ByteData bytes = await rootBundle.load(url);
      var buffer = bytes.buffer;
      await saveImage(base64.encode(Uint8List.view(buffer)), version);
      widget.cardInfo!.colorTextAbove = index.toString();
      storage.saveData(widget.cardInfo, false);
    }

    return GestureDetector(
      onTap: showImage,
      child: Card(
          color: Colors.white54,
          elevation: 5.0,
          child: Image(image: AssetImage(url), fit: BoxFit.cover)),
    );
  }

  AlertDialog buildAlertDialog(title, msg) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.red),
      ),
      content: Text(
        msg,
        style: TextStyle(fontStyle: FontStyle.normal),
      ),
    );
  }
}
