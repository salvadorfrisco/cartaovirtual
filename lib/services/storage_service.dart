import 'dart:convert';
import 'dart:typed_data';
import 'package:virtual_card/common/string_images.dart';
import 'package:virtual_card/utils/photo_helper.dart';
import '../models/card_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class StorageService {
  initializeCards() async {
    await _saveImageBackground(1);
    await _saveImageBackground(2);
    await _saveImageBackground(3);
    await _saveImageBackground(4);
  }

  initializeInfos(name, phone, sizeScreen) async {
    saveVersion("1");
    CardInfo card = CardInfo();
    card.version = '1';
    card.name = name;
    card.occupation = '';
    card.phone = phone;
    card.photo = 'photo';
    card.email = '';
    card.facebook = '';
    card.instagram = '';
    card.twitter = '';
    card.linkedin = '';
    card.youtube = '';
    card.website = '';
    card.nameIcon = 'name';
    card.occupationIcon = 'occupation';
    card.phoneIcon = 'phone';
    card.photoIcon = 'photo';
    card.emailIcon = 'email';
    card.facebookIcon = 'facebook';
    card.instagramIcon = 'instagram';
    card.twitterIcon = 'twitter';
    card.linkedinIcon = 'linkedin';
    card.youtubeIcon = 'youtube';
    card.websiteIcon = 'website';
    card.hasName = false;
    card.hasOccupation = false;
    card.hasPhone = true;
    card.hasPhoto = false;
    card.photoCircle = true;
    card.hasEmail = false;
    card.hasFacebook = false;
    card.hasInstagram = false;
    card.hasTwitter = false;
    card.hasLinkedin = false;
    card.hasYoutube = false;
    card.hasWebsite = false;
    card.posXName = 20;
    card.posXOccupation = 20;
    card.posXPhone = 20;
    card.posXPhoto = sizeScreen.width * 0.32;
    card.posXEmail = 20;
    card.posXFacebook = 20;
    card.posXLinkedin = 20;
    card.posXInstagram = 20;
    card.posXTwitter = 20;
    card.posXYoutube = 20;
    card.posXWebsite = 20;
    card.posYName = sizeScreen.height * 0.05;
    card.posYOccupation = sizeScreen.height * 0.15;
    card.posYPhone = sizeScreen.height * 0.25;
    card.posYPhoto = sizeScreen.height * 0.30;
    card.posYEmail = sizeScreen.height * 0.6;
    card.posYFacebook = sizeScreen.height * 0.64;
    card.posYLinkedin = sizeScreen.height * 0.68;
    card.posYInstagram = sizeScreen.height * 0.72;
    card.posYTwitter = sizeScreen.height * 0.76;
    card.posYYoutube = sizeScreen.height * 0.8;
    card.posYWebsite = sizeScreen.height * 0.84;
    card.scaleName = 1.0;
    card.scaleOccupation = 1.0;
    card.scalePhone = 1.0;
    card.scalePhoto = 1.0;
    card.scaleEmail = 1.0;
    card.scaleFacebook = 1.0;
    card.scaleLinkedin = 1.0;
    card.scaleInstagram = 1.0;
    card.scaleTwitter = 1.0;
    card.scaleYoutube = 1.0;
    card.scaleWebsite = 1.0;
    card.fontName = 'Arial';
    card.fontOccupation = 'Arial';
    card.fontPhone = 'Arial';
    card.fontPhoto = 'Arial';
    card.fontEmail = 'Arial';
    card.fontFacebook = 'Arial';
    card.fontLinkedin = 'Arial';
    card.fontInstagram = 'Arial';
    card.fontTwitter = 'Arial';
    card.fontYoutube = 'Arial';
    card.fontWebsite = 'Arial';
    card.opacity = '0.9';
    await _saveCard('1', card)
        .then((_) => _saveCard('2', card))
        .then((_) => _saveCard('3', card))
        .then((_) => _saveCard('4', card));
  }

  _saveImageBackground(version) {
    PhotoHelper.savePhotoLocal64(base64.encode(IMGBACK[version - 1]), 'imageBackground', version.toString());
  }

  _saveCard(_version, card) async {
    card.version = _version;
    card.colorTextAbove = (_version == '1') ? 'ffffffff' : (_version == '2') ? 'ffff0000' : (_version == '3') ? 'ffffff00' : 'ffffffff';
    card.colorTextBelow = (_version == '1') ? 'ff00ccff' : (_version == '2') ? 'ff000000' : (_version == '3') ? 'ff996600' : 'ffffff00';
    await saveDataInitial(card, _version, false)
        .then((_) => saveDataInitial(card, _version, true));
  }

  hasKey(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<String> getVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('actualVersion')
        ? prefs.getString('actualVersion')
        : "0";
  }

  Future<bool> saveVersion(version) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('actualVersion', version);
    return true;
  }

  getActualCardInfo() async {
    return await getVersion()
        .then((actualVersion) => getCardInfo(version: actualVersion));
  }

  getCardInfo({version, backup = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _nameKey = 'cardInfo' + version + backup.toString();
    Map cardMap = json.decode(prefs.getString(_nameKey));
    return CardInfo.fromJson(cardMap);
  }

  saveDataInitial(CardInfo card, version, backup) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _nameKey = 'cardInfo' + version + backup.toString();
    card.colorName = card.colorTextAbove;
    card.colorOccupation = card.colorTextAbove;
    card.colorPhone = card.colorTextAbove;
    card.colorPhoto = card.colorTextAbove;
    card.colorEmail = card.colorTextBelow;
    card.colorFacebook = card.colorTextBelow;
    card.colorInstagram = card.colorTextBelow;
    card.colorTwitter = card.colorTextBelow;
    card.colorLinkedin = card.colorTextBelow;
    card.colorYoutube = card.colorTextBelow;
    card.colorWebsite = card.colorTextBelow;
    prefs.setString(_nameKey, jsonEncode(card).toString());
  }

  saveData(cardInfo, backup) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await getVersion().then((version) => prefs.setString(
        'cardInfo' + version + backup.toString(),
        jsonEncode(cardInfo).toString()));
  }

  Future<Uint8List> getImage(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) {
      final ByteData bytes = await rootBundle.load('assets/images/black_pixel.jpg');
      return bytes.buffer.asUint8List();
    }
    Uint8List image = base64.decode(prefs.getString(key));
    return image;
  }
}
