import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:virtual_card/utils/functions.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_card/utils/photo_helper.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';

import '../services/storage_service.dart';
import '../widgets/model_selected.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/card_info.dart';
import 'crop_page.dart';

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
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    setInitialData();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

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

  _buildPictureUploaded(version) {
    return InkWell(
      onTap: () => imageUploaded != null
          ? saveImage(base64.encode(imageUploaded), version)
          : {},
      child: Container(
        width: _sizeWidth * 0.32,
        height: _sizeWidth * 0.44,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: imageUploaded != null
                ? MemoryImage(imageUploaded)
                : AssetImage('assets/images/white_pixel.jpg'),
          ),
        ),
      ),
    );
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

  _buildUploadButton(txt, icon) {
    return InkWell(
        onTap: upload,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.012),
            width: MediaQuery.of(context).size.width * 0.18,
            height: MediaQuery.of(context).size.width * 0.14,
            decoration: BoxDecoration(
                color: Colors.black54,
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

  Widget _selectModel(BuildContext context) {
    // Use LayoutBuilder to get the hero header size while keeping the image aspect-ratio
    return Stack(
      children: <Widget>[
        Container(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverPersistentHeader(
                pinned: true,
                delegate: ModelSelected(
                    minExtent: _sizeHeight * 0.54,
                    maxExtent: _sizeHeight * 0.54,
                    cardInfo: cardInfo,
                    imageBackground: imageBackground,
                    profileImage: widget.profileImage),
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
                    String img =
                        'https://picsum.photos/seed/$index/$_sizeWidth/$_sizeHeight';
                    return (_connectionStatus == 'ConnectivityResult.none' &&
                            index > 0)
                        ? Center(
                            child: Text(
                            "Para carregar as imagens é necessário se conectar á internet.",
                            style: TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ))
                        : showImageCard(img, widget.cardInfo.version, index);
                  },
                  childCount: (_connectionStatus == 'ConnectivityResult.none')
                      ? 2
                      : 1000,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: displayHeight(context) * 0.636,
          left: displayWidth(context) * 0.076,
          child: _buildUploadButton("upload", Icons.file_upload),
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
      PhotoHelper.savePhotoLocal64(img64, 'imageBackground', version);
      isLoading = false;
    });
  }

  showImageCard(url, version, index) {
    showImage() async {
      setState(() {
        isLoading = true;
      });
      if (index > 0) {
        await http.get(url).then((http.Response response) =>
            saveImage(base64.encode(response.bodyBytes), version));
      }
    }

    return GestureDetector(
      onTap: showImage,
      child: Card(
        color: Colors.white54,
        child: index > 0
            ? Image.network(url, fit: BoxFit.cover)
            : _buildPictureUploaded(version),
      ),
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        String wifiName, wifiBSSID, wifiIP;

        try {
          if (!kIsWeb && Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiName = await _connectivity.getWifiName();
            } else {
              wifiName = await _connectivity.getWifiName();
            }
          } else {
            wifiName = await _connectivity.getWifiName();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiName = "Failed to get Wifi Name";
        }

        try {
          if (!kIsWeb && Platform.isIOS) {
            LocationAuthorizationStatus status =
                await _connectivity.getLocationServiceAuthorization();
            if (status == LocationAuthorizationStatus.notDetermined) {
              status =
                  await _connectivity.requestLocationServiceAuthorization();
            }
            if (status == LocationAuthorizationStatus.authorizedAlways ||
                status == LocationAuthorizationStatus.authorizedWhenInUse) {
              wifiBSSID = await _connectivity.getWifiBSSID();
            } else {
              wifiBSSID = await _connectivity.getWifiBSSID();
            }
          } else {
            wifiBSSID = await _connectivity.getWifiBSSID();
          }
        } on PlatformException catch (e) {
          print(e.toString());
          wifiBSSID = "Failed to get Wifi BSSID";
        }

        try {
          wifiIP = await _connectivity.getWifiIP();
        } on PlatformException catch (e) {
          print(e.toString());
          wifiIP = "Failed to get Wifi IP";
        }

        setState(() {
          _connectionStatus = '$result\n'
              'Wifi Name: $wifiName\n'
              'Wifi BSSID: $wifiBSSID\n'
              'Wifi IP: $wifiIP\n';
        });
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
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