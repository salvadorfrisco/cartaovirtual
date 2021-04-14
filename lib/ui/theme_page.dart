import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
// import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:unicons/unicons.dart';
import 'package:virtual_card/utils/functions.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_card/utils/responsive.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/card_info.dart';
import 'crop_page.dart';
import 'home_page.dart';

class ThemePage extends StatefulWidget {
  ThemePage(
      {Key key,
      this.cardInfo,
      this.imageUploaded,
      this.imageBackground,
      this.profileImage})
      : super(key: key);
  final CardInfo cardInfo;
  final Uint8List imageUploaded, imageBackground, profileImage;
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var textEditingController = TextEditingController();
  StorageService storage = StorageService();
  CardInfo cardInfo = CardInfo();
  Color _appColor = Colors.white54;
  int _sizeWidth, _sizeHeight;
  Uint8List imageUploaded, imageBackground, profileImage;
  bool isLoading = false;
  String _connectionStatus = 'Unknown';
  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    setInitialData();
    // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // @override
  // void dispose() {
  //   _connectivitySubscription.cancel();
  //   super.dispose();
  // }

  // Future<void> initConnectivity() async {
  //   ConnectivityResult result;
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //   }
  //   if (!mounted) {
  //     return Future.value(null);
  //   }
  //   return _updateConnectionStatus(result);
  // }

  @override
  Widget build(BuildContext context) {
    _sizeWidth = int.parse(displayWidth(context).toStringAsFixed(0));
    _sizeHeight = int.parse(displayHeight(context).toStringAsFixed(0));
    return FutureBuilder(
        future: loadImageBackground(widget.cardInfo.version),
        builder: (context, snapshot) {
          return FutureBuilder(
              future: loadImageUploaded(widget.cardInfo.version),
              builder: (context, snapshot) {
                return SafeArea(
                    child: Scaffold(
                        key: _scaffoldKey,
                        backgroundColor: _appColor,
                        body: Stack(
                          children: <Widget>[
                            _selectModel(context),
                            Positioned(
                                top: Responsive.of(context).heightPercent(8),
                                right: 4,
                                child: Column(children: [
                                  _transparencyControl(),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  _buildUploadButton(
                                      "Fazer upload de imagem da galeria",
                                      UniconsLine.image_upload),
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
        });
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
                  value: double.parse(cardInfo.opacity) * 10,
                  min: 0.0,
                  max: 10.0,
                  divisions: 40,
                  activeColor: Colors.white,
                  inactiveColor: Colors.black,
                  onChanged: (double newValue) {
                    setState(() {
                      cardInfo.opacity = (newValue / 10).toString();
                      storage.saveData(cardInfo, false);
                    });
                  }),
            )));
  }

  uploadAndCrop() async {
    imageUploaded = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CropPage(
            version: cardInfo.version,
            imageName: 'imageUploaded',
          ),
        ));
    if (imageUploaded != null) {
      setState(() {
        isLoading = true;
      });
      saveImage(base64.encode(imageUploaded), widget.cardInfo.version);
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  upload() async {
    await uploadAndCrop();
  }

  _buildUploadButton(tip, icon) {
    return InkWell(
        onTap: upload,
        child: Tooltip(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            message: tip,
            child: Center(
              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.018),
                width: MediaQuery.of(context).size.width * 0.15,
                height: MediaQuery.of(context).size.width * 0.16,
                decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(
                        MediaQuery.of(context).size.width * 0.07))),
                child: FittedBox(
                  child: Column(
                      children: Functions.contentButton(icon, Colors.orange)),
                ),
              ),
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
              collapsedHeight: 100,
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
                  int indexImg = index + 1;
                  String img =
                      'https://picsum.photos/seed/$indexImg/$_sizeWidth/$_sizeHeight';
                  return (_connectionStatus == 'ConnectivityResult.none' &&
                          index > 0)
                      ? Center(
                          child: Text(
                          "Para carregar as imagens é necessário se conectar a internet.",
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ))
                      : showImageCard(img, widget.cardInfo.version, index);
                },
                childCount:
                    (_connectionStatus == 'ConnectivityResult.none') ? 2 : 1000,
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

  Future<void> loadImageUploaded(version) async => await storage
      .getImage('imageUploaded' + version)
      .then((img) => imageUploaded = img);

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
      await http.get(url).then((http.Response response) =>
          saveImage(base64.encode(response.bodyBytes), version));
    }

    return GestureDetector(
      onTap: showImage,
      child: Card(
        color: Colors.white54,
        child:
            // index >= 0
            // ?
            Image.network(url, fit: BoxFit.cover)
        // : _buildPictureUploaded(version)
        ,
      ),
    );
  }

  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   switch (result) {
  //     case ConnectivityResult.wifi:
  //     case ConnectivityResult.mobile:
  //     case ConnectivityResult.none:
  //       setState(() => _connectionStatus = result.toString());
  //       break;
  //     default:
  //       setState(() => _connectionStatus = 'Failed to get connectivity.');
  //       break;
  //   }
  // }

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
