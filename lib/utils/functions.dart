import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:virtual_card/models/content_model.dart';
import 'converter_functions.dart';
import 'package:get/get.dart';

class Functions {

  static buildAlertDialog(context, title, msg, {confirmButton = true}) {
    return showDialog(
        context:  context,
        builder:  (BuildContext context) {

          return AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      content: Text(
        msg,
        style: TextStyle(fontStyle: FontStyle.normal),
      ),
            actions: <Widget>[
              // define os botões na base do dialogo
              new TextButton(
                child: new Text("Ok".tr),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
    );
  });}

  static buildIcon(txt) {
    if (txt == 'name') return Icons.person;
    if (txt == 'occupation') return UniconsLine.bag_alt;
    if (txt == 'phone') return UniconsLine.whatsapp;
    if (txt == 'photo') return UniconsLine.camera;
    if (txt == 'email') return UniconsLine.envelope;
    if (txt == 'facebook') return UniconsLine.facebook;
    if (txt == 'instagram') return UniconsLine.instagram;
    if (txt == 'twitter') return UniconsLine.twitter;
    if (txt == 'linkedin') return UniconsLine.linkedin;
    if (txt == 'youtube') return UniconsLine.youtube;
    if (txt == 'website') return UniconsLine.globe;
  }

  static buildCustomButton(action, icon, {colorBack: Colors.black38, tip: ''}) {
    return InkWell(
        onTap: action,
        child: Tooltip(
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            message: tip,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(6.0),
                width: 54.0,
                height: 50.0,
                decoration: BoxDecoration(
                    color: colorBack,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                child: FittedBox(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: Functions.contentButton(icon, Colors.white)),
                ),
              ),
            )));
  }

  static contentButton(icon, color, {txt: '', txtSize: 15.0}) {
    List<Widget> list = [];
    if (icon != null)
      list.add(Icon(
        icon,
        color: color,
        size: (txt == '') ? 20.0 : 26.0,
      ));
    if (txt != "")
      list.add(FittedBox(
          child: Text(txt, style: TextStyle(fontSize: txtSize, color: color))));
    return list;
  }

  static contentButton4(icon1, icon2, icon3, icon4, color) {
    List<Widget> list = [];
    list.add(Column(children: [ Row(children: [
      Icon(
        icon1,
        color: color,
        size: 26.0,
      ),
      Icon(
        icon2,
        color: color,
        size: 26.0,
      ),]),
      Row(children: [
      Icon(
        icon3,
        color: color,
        size: 26.0,
      ),
      Icon(
        icon4,
        color: color,
        size: 26.0,
      ),
      ]),]),);
    return list;
  }

  static loadContent(cardInfo) {
    List<ContentModel> cntList = [];
    cntList.add(ContentModel(
      id: '0',
      hasIcon: cardInfo.hasPhoto,
      type: cardInfo.photoIcon,
      txt: cardInfo.photo,
      posX: cardInfo.posXPhoto,
      posY: cardInfo.posYPhoto,
      scale: cardInfo.scalePhoto,
      icon: (cardInfo.hasPhoto) ? Icons.camera_alt : null,
      angle: cardInfo.anglePhoto,
    ));
    cntList.add(ContentModel(
      id: '1',
      hasIcon: cardInfo.hasName,
      type: cardInfo.nameIcon,
      txt: cardInfo.name,
      posX: cardInfo.posXName,
      posY: cardInfo.posYName,
      size: 25,
      font: cardInfo.fontName,
      scale: cardInfo.scaleName,
      color: intelligentCast<Color>(cardInfo.colorName),
      icon: (cardInfo.hasName) ? Icons.person : null,
      angle: cardInfo.angleName,
    ));
    cntList.add(ContentModel(
      id: '2',
      hasIcon: cardInfo.hasOccupation,
      type: cardInfo.occupationIcon,
      txt: cardInfo.occupation,
      posX: cardInfo.posXOccupation,
      posY: cardInfo.posYOccupation,
      size: 24,
      font: cardInfo.fontOccupation,
      scale: cardInfo.scaleOccupation,
      color: intelligentCast<Color>(cardInfo.colorOccupation),
      icon: (cardInfo.hasOccupation) ? Icons.business_center : null,
      angle: cardInfo.angleOccupation,
    ));
    cntList.add(ContentModel(
      id: '3',
      hasIcon: cardInfo.hasPhone,
      type: cardInfo.phoneIcon,
      txt: cardInfo.phone,
      posX: cardInfo.posXPhone,
      posY: cardInfo.posYPhone,
      size: 28,
      font: cardInfo.fontPhone,
      scale: cardInfo.scalePhone,
      color: intelligentCast<Color>(cardInfo.colorPhone),
      icon: (cardInfo.hasPhone) ? UniconsLine.whatsapp : null,
      angle: cardInfo.anglePhone,
    ));
    cntList.add(ContentModel(
      id: '4',
      hasIcon: cardInfo.hasEmail,
      type: cardInfo.emailIcon,
      txt: cardInfo.email,
      posX: cardInfo.posXEmail,
      posY: cardInfo.posYEmail,
      size: 18,
      font: cardInfo.fontEmail,
      scale: cardInfo.scaleEmail,
      color: intelligentCast<Color>(cardInfo.colorEmail),
      icon: (cardInfo.hasEmail) ? Icons.email : null,
      angle: cardInfo.angleEmail,
    ));
    cntList.add(ContentModel(
      id: '5',
      hasIcon: cardInfo.hasFacebook,
      type: cardInfo.facebookIcon,
      txt: cardInfo.facebook,
      posX: cardInfo.posXFacebook,
      posY: cardInfo.posYFacebook,
      size: 18,
      font: cardInfo.fontFacebook,
      scale: cardInfo.scaleFacebook,
      color: intelligentCast<Color>(cardInfo.colorFacebook),
      icon: (cardInfo.hasFacebook) ? UniconsLine.facebook : null,
      angle: cardInfo.angleFacebook,
    ));
    cntList.add(ContentModel(
      id: '6',
      hasIcon: cardInfo.hasLinkedin,
      type: cardInfo.linkedinIcon,
      txt: cardInfo.linkedin,
      posX: cardInfo.posXLinkedin,
      posY: cardInfo.posYLinkedin,
      size: 18,
      font: cardInfo.fontLinkedin,
      scale: cardInfo.scaleLinkedin,
      color: intelligentCast<Color>(cardInfo.colorLinkedin),
      icon: (cardInfo.hasLinkedin) ? UniconsLine.linkedin : null,
      angle: cardInfo.angleLinkedin,
    ));
    cntList.add(ContentModel(
      id: '7',
      hasIcon: cardInfo.hasInstagram,
      type: cardInfo.instagramIcon,
      txt: cardInfo.instagram,
      posX: cardInfo.posXInstagram,
      posY: cardInfo.posYInstagram,
      size: 18,
      font: cardInfo.fontInstagram,
      scale: cardInfo.scaleInstagram,
      color: intelligentCast<Color>(cardInfo.colorInstagram),
      icon: (cardInfo.hasInstagram) ? UniconsLine.instagram : null,
      angle: cardInfo.angleInstagram,
    ));
    cntList.add(ContentModel(
      id: '8',
      hasIcon: cardInfo.hasTwitter,
      type: cardInfo.twitterIcon,
      txt: cardInfo.twitter,
      posX: cardInfo.posXTwitter,
      posY: cardInfo.posYTwitter,
      size: 18,
      font: cardInfo.fontTwitter,
      scale: cardInfo.scaleTwitter,
      color: intelligentCast<Color>(cardInfo.colorTwitter),
      icon: (cardInfo.hasTwitter) ? UniconsLine.twitter : null,
      angle: cardInfo.angleTwitter,
    ));
    cntList.add(ContentModel(
      id: '9',
      hasIcon: cardInfo.hasYoutube,
      type: cardInfo.youtubeIcon,
      txt: cardInfo.youtube,
      posX: cardInfo.posXYoutube,
      posY: cardInfo.posYYoutube,
      size: 18,
      font: cardInfo.fontYoutube,
      scale: cardInfo.scaleYoutube,
      color: intelligentCast<Color>(cardInfo.colorYoutube),
      icon: (cardInfo.hasYoutube) ? UniconsLine.youtube : null,
      angle: cardInfo.angleYoutube,
    ));
    cntList.add(ContentModel(
      id: '10',
      hasIcon: cardInfo.hasWebsite,
      type: cardInfo.websiteIcon,
      txt: cardInfo.website,
      posX: cardInfo.posXWebsite,
      posY: cardInfo.posYWebsite,
      size: 18,
      font: cardInfo.fontWebsite,
      scale: cardInfo.scaleWebsite,
      color: intelligentCast<Color>(cardInfo.colorWebsite),
      icon: (cardInfo.hasWebsite) ? UniconsLine.globe : null,
      angle: cardInfo.angleWebsite,
    ));
    return cntList;
  }

  static buildMessage(txt, width) {
    return Container(
      width: width,
      padding: EdgeInsets.all(4),
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
    );
  }

  static buildMessageWidgets(List<Widget> widgets, width,
      {backColor: Colors.black54}) {
    return Container(
      width: width,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: backColor,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Center(
          child: FittedBox(
              child: Row(
        children: widgets,
      ))),
    );
  }

  // static textFlexible(text, {padding: const EdgeInsets.only(right: 16), style: const TextStyle(fontSize: 14.0)}) {
  //   return Flexible(
  //       child: Padding(
  //         padding: padding,
  //         child: RichText(
  //           text,
  //           softWrap: true,
  //           maxLines: 5,
  //           style: style,
  //         ),
  //       ));
  // }
}
