import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unicons/unicons.dart';
import 'package:virtual_card/generated/l10n.dart';
import '../utils/extensions.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

formField(context, cnt, width, callback, index, callbackTap) {
  return SizedBox(
    height: getSize(cnt.type) + 18,
    width: width,
    child: TextFormField(
        initialValue: cnt.txt,
        keyboardType: getKeyboardType(cnt.type),
        cursorColor: Colors.black,
        inputFormatters: getMaskField(cnt.type),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Colors.black26, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.black45),
          ),
          contentPadding: EdgeInsets.all(8.0),
          hintText: getHint(context, cnt.type),
          hintStyle: TextStyle(
              color: Colors.black38,
              fontSize: getSize(cnt.type) - 4,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal),
          filled: true,
          fillColor: Color(0xccffffff),
          isDense: true,
        ),
        style: TextStyle(
          color: Color(0xff40526b),
          fontSize: getSize(cnt.type),
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
        ),
        onTap: callbackTap,
        onChanged: (value) {
          callback(value, index);
        }),
  );
}

getHint(context, type) {
  switch (type) {
    case "name":
      return S.of(context).nameHint.capitalize();
      break;
    case "occupation":
      return S.of(context).occupationHint.capitalize();
      break;
    case "phone":
      return S.of(context).cellPhoneHint.capitalize();
      break;
    case "email":
      return S.of(context).emailAddressHint.capitalize();
      break;
    case "facebook":
      return S.of(context).facebookAddressHint.capitalize();
      break;
    case "instagram":
      return S.of(context).instagramAddressHint.capitalize();
      break;
    case "twitter":
      return S.of(context).twitterAddressHint.capitalize();
      break;
    case "linkedin":
      return S.of(context).linkedinAddressHint.capitalize();
      break;
    case "youtube":
      return S.of(context).youtubeAddressHint.capitalize();
      break;
    case "website":
      return S.of(context).websiteAddressHint.capitalize();
      break;
  }
}

getPicture(profileImage, sizeWidth, photoCircle) {
  return Container(
        width: sizeWidth * 0.3,
        height: sizeWidth * 0.3,
        decoration: new BoxDecoration(
          shape: (photoCircle) ? BoxShape.circle : BoxShape.rectangle,
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: (profileImage != null
                ? MemoryImage(profileImage)
                : AssetImage('assets/images/transparent.png')) as ImageProvider<Object>,
          ),
        ),
      );
}

getIcon(type) {
  switch (type) {
    case "name":
      return Icons.person;
      break;
    case "occupation":
      return UniconsLine.bag_alt;
      break;
    case "phone":
      return UniconsLine.whatsapp;
      break;
    case "photo":
      return UniconsLine.camera;
      break;
    case "email":
      return UniconsLine.envelope;
      break;
    case "facebook":
      return UniconsLine.facebook;
      break;
    case "instagram":
      return UniconsLine.instagram;
      break;
    case "twitter":
      return UniconsLine.twitter;
      break;
    case "linkedin":
      return UniconsLine.linkedin;
      break;
    case "youtube":
      return UniconsLine.youtube;
      break;
    case "website":
      return UniconsLine.globe;
      break;
  }
}

getSize(type) {
  switch (type) {
    case "name":
      return 22.0;
      break;
    case "occupation":
      return 22.0;
      break;
    case "phone":
      return 22.0;
      break;
    case "email":
      return 18.0;
      break;
    case "facebook":
      return 18.0;
      break;
    case "instagram":
      return 18.0;
      break;
    case "twitter":
      return 18.0;
      break;
    case "linkedin":
      return 18.0;
      break;
    case "youtube":
      return 18.0;
      break;
    case "website":
      return 18.0;
      break;
    default:
      return 30.0;
      break;
  }
}

getKeyboardType(type) {
  switch (type) {
    case "phone":
      return TextInputType.phone;
      break;
    case "email":
      return TextInputType.emailAddress;
      break;
    case "website":
      return TextInputType.url;
      break;
    default:
      return TextInputType.text;
      break;
  }
}

List<TextInputFormatter> getMaskField(type) {
  switch (type) {
//    case "phone":
//      return [
//        MaskTextInputFormatter(\
//            mask: "## ##### ####", filter: {"#": RegExp(r'[0-9]')})
//      ];
//      break;
    default:
      // return [LengthLimitingTextInputFormatter(50), FilteringTextInputFormatter.deny(RegExp('[\\\\|\\"|\\,|\\{|\\}]'))];
      // return [LengthLimitingTextInputFormatter(50), FilteringTextInputFormatter.deny(RegExp('[\\\\|\\{|\\}]'))];
      return [LengthLimitingTextInputFormatter(50)];
      break;
  }
}
