import 'dart:convert';
import 'dart:typed_data';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unicons/unicons.dart';
import 'package:virtual_card/common/constants.dart';
import 'package:virtual_card/models/content_model.dart';
import 'package:virtual_card/services/storage_service.dart';
import 'package:virtual_card/ui/terms_page.dart';
import 'package:virtual_card/utils/functions.dart';
import 'package:virtual_card/utils/infos_helper.dart';
import 'package:virtual_card/utils/keyboard_utils.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../main_page.dart';
import '../models/card_info.dart';
import 'crop_page.dart';
import 'package:virtual_card/generated/l10n.dart';

class InfosPage extends StatefulWidget {
  InfosPage({Key? key, this.cardInfo, this.imageBackground}) : super(key: key);
  final CardInfo? cardInfo;
  final Uint8List? imageBackground;

  @override
  _InfosPageState createState() => _InfosPageState();
}

class _InfosPageState extends State<InfosPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<ContentModel>? contentList = [ContentModel()];
  Uint8List? profileImage;
  bool? didLoad = false,
      buttonsOn = false,
      formChanged = false,
      formSaved = false,
      isLoading = false;
  bool _photoCircle = true;
  bool canPickImage = true;
  StorageService storage = StorageService();
  CardInfo? cardInfo;
  double? _sizeWidth;
  ScrollController _scrollController = ScrollController();
  static const Color colorBack = Colors.black54;
  final ImagePicker _picker = ImagePicker();
  bool? permissionGranted;

  Future<bool> getPermission() async {
    return await Permission.storage.isGranted;
  }

  @override
  Widget build(BuildContext context) {
    _sizeWidth = displayWidth(context);
    if (didLoad!) {
      return buildBody();
    } else {
      return FutureBuilder<List<ContentModel>>(
          future: setContentList(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            contentList = snapshot.data;
            _photoCircle = cardInfo!.photoCircle;
            didLoad = true;
            isLoading = false;
            return buildBody();
          });
    }
  }

  Widget itemCard(ContentModel cnt, index) {
    return Container(
        key: Key(cnt.id!),
        margin: EdgeInsets.all(5.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildChannels(cnt, index),
            ]));
  }

  uploadAndCrop(cnt) async {
    profileImage = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CropPage(
            version: cardInfo!.version,
            imageName: 'profileImage',
          ),
        ));
    if (profileImage != null) {
      buttonsOn = !buttonsOn!;
      cnt.hasIcon = buttonsOn;
      verifyChanges();
      // setState(() {
      //   buttonsOn = false;
      //   isLoading = false;
      // });
      saveImage(base64.encode(profileImage!), widget.cardInfo!.version);
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  saveImage(img64, version) {
    setState(() {
      StorageService.savePhotoLocal64(img64, 'profileImage', version);
      cardInfo!.hasPhoto = true;
      isLoading = false;
    });
  }

  Widget buildBody() {
    return GestureDetector(
        onTap: () {
          KeyboardUtils.closeOnTouchOutside(context);
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            // resizeToAvoidBottomPadding: false,
            key: _scaffoldKey,
            body: _body()));
  }

  _body() {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Stack(fit: StackFit.expand, children: [
        Opacity(
            opacity: double.parse(cardInfo!.opacity),
            child: Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: (widget.imageBackground != null
                          ? MemoryImage(widget.imageBackground!)
                          : AssetImage('assets/images/transparent.png'))
                      as ImageProvider<Object>,
                ),
              ),
            )),
        Center(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: Column(
                children: [
                  itemCard(contentList![0], 0),
                  itemCard(contentList![1], 1),
                  itemCard(contentList![2], 2),
                  itemCard(contentList![3], 3),
                  itemCard(contentList![4], 4),
                  itemCard(contentList![5], 5),
                  itemCard(contentList![6], 6),
                  itemCard(contentList![7], 7),
                  itemCard(contentList![8], 8),
                  itemCard(contentList![9], 9),
                  itemCard(contentList![10], 10),
                  ShowTip(sizeWidth: _sizeWidth),
                  Center(
                    child: _buildMessage(S.of(context).termsOfUse, _navToTerms),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      S.of(context).version + ' 2.0.6+38',
                      style: TextStyle(
                          color: Colors.black, fontSize: _sizeWidth! * 0.03),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
            top: 30.0,
            left: 10.0,
            child: Functions.buildCustomButton(
                _actionButtonLeft, UniconsLine.arrow_left,
                tip: 'Voltar')),
      ]),
    );
  }

  _actionButtonLeft() {
    saveData();
    _navToHome();
  }

  _navToHome() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => MainPage()),
        ModalRoute.withName('/'));
  }

  _navToTerms() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) => TermsPage()),
    );
  }

  void _scrollToEnd() {
    if (!_scrollController.hasClients) {
      return;
    }

    var scrollPosition = _scrollController.position;

    if (scrollPosition.maxScrollExtent > scrollPosition.minScrollExtent) {
      _scrollController.animateTo(
        scrollPosition.maxScrollExtent,
        duration: new Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  _buildChannels(ContentModel cnt, index) {
    return FittedBox(
      child: Row(
        children: <Widget>[
          _icon(cnt),
          (cnt.type == 'photo')
              ? _picture(cnt)
              : formField(context, cnt, MediaQuery.of(context).size.width * 0.8,
                  fieldChanged, index, () {
                  if (index > 5 &&
                      MediaQuery.of(context).viewInsets.bottom == 0.0)
                    _scrollToEnd();
                }),
        ],
      ),
    );
  }

  _picture(cnt) {
    return cnt.type == "photo" && cnt.hasIcon
        ? InkWell(
            onTap: () {
              uploadAndCrop(cnt);
            },
            child: Row(
              children: [
                getPicture(profileImage, _sizeWidth, _photoCircle),
                SizedBox(
                  width: 20.0,
                ),
                GestureDetector(
                  onTap: () {
                    _photoCircle = !_photoCircle;
                    verifyChanges();
                    reload();
                  },
                  child: Container(
                    width: _sizeWidth! * 0.1,
                    height: _sizeWidth! * 0.1,
                    decoration: new BoxDecoration(
                      shape: (!_photoCircle)
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: (profileImage != null
                                ? MemoryImage(profileImage!)
                                : AssetImage('assets/images/transparent.png'))
                            as ImageProvider<Object>,
                      ),
                    ),
                  ),
                ),
              ],
            ))
        : _includePhoto(cnt);
  }

  _includePhoto(cnt) {
    return FutureBuilder<bool>(
        future: getPermission(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          permissionGranted = snapshot.data as bool;
          return Tooltip(
              message: (permissionGranted!)
                      ? S.of(context).chooseImage
                      : S.of(context).tipAccessDenied,
              child: _buildMessage(
                  (permissionGranted!)
                      ? S.of(context).includePhotoFromGallery
                      : S.of(context).includePhotoFromGallery + ' ' + S.of(context).denied,
                  () => uploadAndCrop(cnt),
                  width: 0.6));
        });
  }

  _icon(ContentModel cnt) {
    return InkWell(
      onTap: () {
        iconChanged(cnt);
      },
      child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: cnt.type != "photo"
              ? CircleAvatar(
                  backgroundColor: cnt.hasIcon!
                      ? Colors.transparent
                      : double.parse(cardInfo!.opacity) < 0.2
                          ? Colors.white
                          : Color(0xffd2c2e0),
                  radius: 15.0,
                  child: Icon(
                    getIcon(cnt.type),
                    color: cnt.hasIcon!
                        ? cnt.color
                        : double.parse(cardInfo!.opacity) < 0.2
                            ? Colors.blueGrey[100]
                            : Colors.white,
                    size: cnt.hasIcon! ? 24.0 : 24.0,
                  ))
              : cnt.hasIcon!
                  ? _buildMessage("Excluir foto", () {
                      cardInfo!.hasPhoto = false;
                      iconChanged(cnt);
                    }, width: 0.26)
                  : Container()),
    );
  }

  iconChanged(cnt) {
    cnt.hasIcon = !cnt.hasIcon;
    verifyChanges();
    reload();
  }

  fieldChanged(value, index) {
    contentList![index].txt = value;
    verifyChanges();
    reload();
  }

  _buildMessage(txt, action, {width: 0.7}) {
    return InkWell(
      onTap: action,
      child: Center(
          child: Container(
        padding: EdgeInsets.all(5.2),
        width: MediaQuery.of(context).size.width * width,
        height: MediaQuery.of(context).size.width * 0.08,
        decoration: BoxDecoration(
            color: Colors.black54,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Center(
            child: FittedBox(
                child: Text(
          txt,
          style: TextStyle(
            color: Colors.white,
          ),
        ))),
      )),
    );
  }

  verifyChanges() {
    formChanged = (cardInfo!.name != contentList![0].txt ||
            cardInfo!.occupation != contentList![1].txt ||
            cardInfo!.phone != contentList![2].txt ||
            cardInfo!.photo != contentList![3].txt ||
            cardInfo!.email != contentList![4].txt ||
            cardInfo!.facebook != contentList![5].txt ||
            cardInfo!.linkedin != contentList![6].txt ||
            cardInfo!.instagram != contentList![7].txt ||
            cardInfo!.twitter != contentList![8].txt ||
            cardInfo!.youtube != contentList![9].txt ||
            cardInfo!.website != contentList![10].txt ||
            cardInfo!.hasName != contentList![0].hasIcon ||
            cardInfo!.hasOccupation != contentList![1].hasIcon ||
            cardInfo!.hasPhone != contentList![2].hasIcon ||
            cardInfo!.hasPhoto != contentList![3].hasIcon ||
            cardInfo!.hasEmail != contentList![4].hasIcon ||
            cardInfo!.hasFacebook != contentList![5].hasIcon ||
            cardInfo!.hasLinkedin != contentList![6].hasIcon ||
            cardInfo!.hasInstagram != contentList![7].hasIcon ||
            cardInfo!.hasTwitter != contentList![8].hasIcon ||
            cardInfo!.hasYoutube != contentList![9].hasIcon ||
            cardInfo!.hasWebsite != contentList![10].hasIcon ||
            cardInfo!.photoCircle != _photoCircle)
        ? true
        : false;
    return formChanged;
  }

  setValues() {
    cardInfo!.photoCircle = _photoCircle;
    for (var i = 0; i < contentList!.length; i++) {
      switch (contentList![i].type) {
        case "name":
          cardInfo!.name = contentList![i].txt!;
          cardInfo!.hasName = contentList![i].hasIcon!;
          break;
        case "occupation":
          cardInfo!.occupation = contentList![i].txt!;
          cardInfo!.hasOccupation = contentList![i].hasIcon!;
          break;
        case "phone":
          cardInfo!.phone = contentList![i].txt!;
          cardInfo!.hasPhone = contentList![i].hasIcon!;
          break;
        // case "photo":
        //   cardInfo.photo = contentList[i].txt;
        //   cardInfo.hasPhoto = contentList[i].hasIcon;
        //   break;
        case "email":
          cardInfo!.email = contentList![i].txt!;
          cardInfo!.hasEmail = contentList![i].hasIcon!;
          break;
        case "facebook":
          cardInfo!.facebook = contentList![i].txt!;
          cardInfo!.hasFacebook = contentList![i].hasIcon!;
          break;
        case "instagram":
          cardInfo!.instagram = contentList![i].txt!;
          cardInfo!.hasInstagram = contentList![i].hasIcon!;
          break;
        case "twitter":
          cardInfo!.twitter = contentList![i].txt!;
          cardInfo!.hasTwitter = contentList![i].hasIcon!;
          break;
        case "linkedin":
          cardInfo!.linkedin = contentList![i].txt!;
          cardInfo!.hasLinkedin = contentList![i].hasIcon!;
          break;
        case "youtube":
          cardInfo!.youtube = contentList![i].txt!;
          cardInfo!.hasYoutube = contentList![i].hasIcon!;
          break;
        case "website":
          cardInfo!.website = contentList![i].txt!;
          cardInfo!.hasWebsite = contentList![i].hasIcon!;
          break;
      }
    }
  }

  reload() {
    setState(() {});
  }

  Future<List<ContentModel>> setContentList() async {
    cardInfo = widget.cardInfo;
    return await storage
        .getImage('profileImage' + cardInfo!.version)
        .then((profImage) {
      profileImage = profImage;
      return Functions.loadContent(cardInfo);
    });
  }

  saveData() {
    setValues();
    storage.saveData(cardInfo, false);
  }
}

class ShowTip extends StatelessWidget {
  ShowTip({
    Key? key,
    required double? sizeWidth,
  })   : _sizeWidth = sizeWidth,
        super(key: key);
  final double? _sizeWidth;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return SizedBox(
      height: 280.0,
      width: 360.0,
      child: CarouselSlider(
        options: CarouselOptions(
          initialPage: date.weekday,
          autoPlay: false,
          aspectRatio: 1.0,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
        items: _getList(context),
      ),
    );
  }

  _tip(context, dayNumber) {
    List<String> TIPTITLE = [
      S.of(context).tipOfTheDay,
      S.of(context).share,
      S.of(context).enhanceYourImage,
      S.of(context).backgroundImage,
      S.of(context).transparency,
      S.of(context).makeYourLayout,
      S.of(context).yourContent,
    ];

    List<Widget> TIPMESSAGE = [
      Text(
        S.of(context).txtTip1,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        textAlign: TextAlign.center,
      ),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(color: colorBack),
            children: [
              TextSpan(
                text: S.of(context).txtTip2,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              WidgetSpan(
                  child: Functions.buildMessageWidgets([
                Icon(UniconsLine.share, size: 22, color: Colors.white)
              ], 40.0, backColor: colorShare)),
            ],
          )),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(color: Colors.black87),
            children: [
              TextSpan(
                text: S.of(context).txtTip3a,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              WidgetSpan(
                  child: Functions.buildMessage(S.of(context).txtTip3b, 106.0)),
              TextSpan(
                text: S.of(context).txtTip3c,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
            ],
          )),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(color: Colors.black87),
            children: [
              TextSpan(
                text: S.of(context).txtTip4a,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              WidgetSpan(
                  child: Functions.buildMessageWidgets([
                Icon(
                  UniconsLine.setting,
                  size: 22,
                  color: Colors.orange,
                )
              ], 40.0)),
              TextSpan(
                text: S.of(context).and,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              WidgetSpan(
                  child: Functions.buildMessageWidgets([
                Icon(
                  UniconsLine.image,
                  size: 22,
                  color: Colors.white,
                )
              ], 40.0)),
              TextSpan(
                text: S.of(context).txtTip4b,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              WidgetSpan(
                  child: Functions.buildMessageWidgets([
                Icon(
                  UniconsLine.image_upload,
                  size: 22,
                  color: Colors.white,
                )
              ], 40.0)),
            ],
          )),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(color: Colors.black87),
            children: [
              TextSpan(
                text: S.of(context).txtTip5a,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              WidgetSpan(
                  child: Functions.buildMessageWidgets([
                Icon(
                  UniconsLine.setting,
                  size: 22,
                  color: Colors.orange,
                )
              ], 40.0)),
              TextSpan(
                text: S.of(context).and,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              WidgetSpan(
                  child: Functions.buildMessageWidgets([
                Icon(
                  UniconsLine.image,
                  size: 22,
                  color: Colors.white,
                )
              ], 40.0)),
              TextSpan(
                text: S.of(context).txtTip5b,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
            ],
          )),
      RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(color: Colors.black87),
            children: [
              TextSpan(
                text: S.of(context).txtTip6a,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              WidgetSpan(
                  child: Functions.buildMessageWidgets([
                Icon(
                  UniconsLine.setting,
                  size: 22,
                  color: Colors.orange,
                )
              ], 40.0)),
              TextSpan(
                text: S.of(context).and,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              WidgetSpan(
                  child: Functions.buildMessageWidgets([
                Icon(
                  Icons.color_lens,
                  size: 22,
                  color: Colors.white,
                ),
                Icon(
                  Icons.zoom_out_map_sharp,
                  size: 22,
                  color: Colors.white,
                )
              ], 40.0)),
              TextSpan(
                text: S.of(context).txtTip6b,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
            ],
          )),
      Text(
        S.of(context).txtTip7,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        textAlign: TextAlign.center,
      ),
    ];

    return Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
            color: TIPCOLOR[dayNumber],
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 80.0,
              child: Lottie.asset(
                TIPANIMATION[dayNumber],
                repeat: true,
                reverse: true,
                frameBuilder: (context, child, composition) {
                  return AnimatedOpacity(
                    child: child,
                    opacity: composition == null ? 0 : 1,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeOut,
                  );
                },
                width: _sizeWidth! * 0.5,
              ),
            ),
            Text(TIPTITLE[dayNumber],
                style: TextStyle(
                    fontSize: _sizeWidth! * 0.05, fontWeight: FontWeight.bold)),
            TIPMESSAGE[dayNumber],
          ],
        )));
  }

  List<Widget> _getList(context) {
    return [
      _tip(context, 0),
      _tip(context, 1),
      _tip(context, 2),
      _tip(context, 3),
      _tip(context, 4),
      _tip(context, 5),
      _tip(context, 6)
    ];
  }
}
