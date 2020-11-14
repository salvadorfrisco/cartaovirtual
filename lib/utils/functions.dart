import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:virtual_card/models/content_model.dart';

import 'converter_functions.dart';

class Functions {
  static AlertDialog buildAlertDialog(title, msg) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      content: Text(
        msg,
        style: TextStyle(fontStyle: FontStyle.normal),
      ),
    );
  }

  static buildIcon(txt) {
    if (txt == 'name') return Icons.person;
    if (txt == 'occupation') return Icons.business_center;
    if (txt == 'phone') return FontAwesomeIcons.whatsapp;
    if (txt == 'photo') return Icons.camera_alt;
    if (txt == 'email') return Icons.email;
    if (txt == 'facebook') return FontAwesomeIcons.facebook;
    if (txt == 'instagram') return FontAwesomeIcons.instagram;
    if (txt == 'twitter') return FontAwesomeIcons.twitter;
    if (txt == 'linkedin') return FontAwesomeIcons.linkedin;
    if (txt == 'youtube') return FontAwesomeIcons.youtube;
    if (txt == 'website') return FontAwesomeIcons.globeAmericas;
  }

  static buildCustomButton(txt, icon, colorBack) {
    return Center(
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
                  children: Functions.contentButton(txt, icon, Colors.white)),
            ),
          ),
        );
  }

  static contentButton(txt, icon, color, {txtSize: 15.0}) {
    List<Widget> list = [];
    if (icon != null) list.add(Icon(icon, color: color, size: (txt == '') ? 20.0 : 26.0,));
    if (txt != "")
      list.add(
          FittedBox(child: Text(txt, style: TextStyle(fontSize: txtSize, color: color))));
    return list;
  }

  static contentButton2(txt, icon, icon2, color) {
    List<Widget> list = [];
    list.add(Row(children:[
      Icon(icon, color: color, size: (txt == '') ? 20.0 : 26.0,),
      Icon(icon2, color: color, size: (txt == '') ? 20.0 : 26.0,),
    ]));
    if (txt != "")
      list.add(
          FittedBox(child: Text(txt, style: TextStyle(fontSize: 15.0, color: color))));
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
      icon: (cardInfo.hasPhoto) ? Icons.camera_alt : null,
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
      icon: (cardInfo.hasPhone) ? FontAwesomeIcons.whatsapp : null,
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
      icon: (cardInfo.hasFacebook) ? FontAwesomeIcons.facebook : null,
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
      icon: (cardInfo.hasLinkedin) ? FontAwesomeIcons.linkedin : null,
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
      icon: (cardInfo.hasInstagram) ? FontAwesomeIcons.instagram : null,
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
      icon: (cardInfo.hasTwitter) ? FontAwesomeIcons.twitter : null,
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
      icon: (cardInfo.hasYoutube) ? FontAwesomeIcons.youtube : null,
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
      icon: (cardInfo.hasWebsite) ? FontAwesomeIcons.globeAmericas : null,
    ));
    return cntList;
  }
}
