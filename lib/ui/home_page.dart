import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:unicons/unicons.dart';
import 'package:virtual_card/models/content_model.dart';
import 'package:virtual_card/utils/functions.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../models/card_info.dart';
import 'cards_page.dart';
import 'config_page.dart';
import 'infos_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:virtual_card/generated/l10n.dart';

class HomePage extends StatefulWidget {
  HomePage(
      {Key? key,
      this.cardInfo,
      this.imageBackground,
      this.profileImage,
      this.widthScreen,
      this.withIcons = true})
      : super(key: key);
  final CardInfo? cardInfo;
  final Uint8List? imageBackground, profileImage;
  final double? widthScreen;
  final bool withIcons;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _globalKey = new GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late bool tipVisible,
      didLoad = false,
      buttonsOn = true,
      buttonHelp = false,
      isLoading = false;
  Color _appColor = Color(0xFFF2F2F2);
  double? _sizeWidth;
  late List<ContentModel> contentList;
  static const Color colorShare = Color(0xCC32C652);
  static const Color colorBack = Colors.black54;

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
                      opacity: double.parse(widget.cardInfo!.opacity),
                      child: Container(
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: (widget.imageBackground != null
                                ? MemoryImage(widget.imageBackground!)
                                : AssetImage('assets/images/transparent.png')) as ImageProvider<Object>,
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
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Colors.black38,
                ))
              : Container(),
          widget.withIcons
              ? AnimatedPositioned(
                  right: (buttonsOn)
                      ? (_sizeWidth! * 0.054)
                      : -100.00, //_sizeWidth * 0.77,
                  bottom: _sizeWidth! * 0.06,
                  duration: Duration(milliseconds: 450),
                  child: _buildCustomButton(S.of(context).shareImage, UniconsLine.share, _share,
                      color: colorShare))
              : Container(),
          widget.withIcons
              ? AnimatedPositioned(
                  left: _sizeWidth! * 0.06,
                  bottom: (buttonsOn) ? (_sizeWidth! * 0.06) : -100.00,
                  duration: Duration(milliseconds: 300),
                  child: _buildCustomButton(S.of(context).editInformations, UniconsLine.edit_alt, _navInfos,
                      colorIcon: Colors.greenAccent))
              : Container(),
          widget.withIcons
              ? AnimatedPositioned(
                  left: _sizeWidth! * 0.294,
                  bottom: (buttonsOn) ? (_sizeWidth! * 0.06) : -100.00,
                  duration: Duration(milliseconds: 375),
                  child: _buildCustomButton(S.of(context).configureItems, UniconsLine.setting, _navConfig,
                      colorIcon: Colors.orange))
              : Container(),
          widget.withIcons
              ? AnimatedPositioned(
                  left: _sizeWidth! * 0.53,
                  bottom: (buttonsOn) ? (_sizeWidth! * 0.06) : -100.00,
                  duration: Duration(milliseconds: 450),
                  child: _buildCustomButton(S.of(context).selectImages, UniconsLine.apps, _navCards,
                      colorIcon: Colors.yellow))
              : Container(),
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
                    version: widget.cardInfo!.version,
                    profileImage: widget.profileImage)
                : page == 'infos'
                    ? InfosPage(
                        cardInfo: widget.cardInfo,
                        imageBackground: widget.imageBackground)
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
    // late String? fnt_item;
    // fnt_item = cnt.font;
    if ((cnt.txt == '')) {
      return Container(
        height: 0,
      );
    } else {
      return Positioned(
          top: cnt.posY! * (_sizeWidth! / displayWidth(context)),
          left: cnt.posX! * (_sizeWidth! / displayWidth(context)),
          child: RotationTransition(
              turns: new AlwaysStoppedAnimation(cnt.angle! / 360),
              child: (cnt.type == 'photo')
                  ? _buildPicture(cnt)
                  : Row(
                      children: [
                        (cnt.icon != null)
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Functions.buildIcon(cnt.type),
                                  color: cnt.color,
                                  size: cnt.size! *
                                      (_sizeWidth! / displayWidth(context)) *
                                      cnt.scale!,
                                ))
                            : SizedBox(width: 0),
                        Text(
                          cnt.txt!,
                          textScaleFactor: cnt.scale,
                          style: GoogleFonts.getFont(cnt.font!,
                              fontSize: cnt.size! *
                                  (_sizeWidth! / displayWidth(context)),
                              color: cnt.color,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )));
    }
  }

  _buildPicture(cnt) {
    if (widget.cardInfo!.hasPhoto) {
      return widget.profileImage != null
          ? Container(
              margin: EdgeInsets.only(top: _sizeWidth! * 0.03),
              width: _sizeWidth! * 0.4 * cnt.scale,
              height: _sizeWidth! * 0.4 * cnt.scale,
              decoration: new BoxDecoration(
                shape: widget.cardInfo!.photoCircle
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(widget.profileImage!),
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
          _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await (image.toByteData(format: ui.ImageByteFormat.png));
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File("$dir/" + 'myimage' + ".jpg");
      await file.writeAsBytes(pngBytes);
      return file.path;
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
    _capturePng()
        .then((imgPath) => _shareImage(imgPath).then((value) => setState(() {
              isLoading = false;
            })));
  }

  _buildCustomButton(tip, icon, action,
      {color: colorBack, colorIcon: Colors.white}) {
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
                  color: color,
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(
                      MediaQuery.of(context).size.width * 0.044))),
              child: FittedBox(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: Functions.contentButton(icon, colorIcon)),
              ),
            ),
          ),
        ));
  }

  Future<void> _shareImage(imagePath) async {
    try {
      if (Platform.isAndroid) {
        await Share.shareFiles([imagePath],
            text:
                'Crie imagens personalizadas, baixe o app em http://onelink.to/imagecreator');
      } else {
        await Share.shareFiles([imagePath]);
      }
    } catch (e) {
      print('error: $e');
    }
  }
}
