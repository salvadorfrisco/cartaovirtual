import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

formField(cnt, width, callback, index, callbackTap) {
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
          hintText: getHint(cnt.type),
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

getPicture(profileImage, sizeWidth, photoCircle) {
  return Container(
        width: sizeWidth * 0.3,
        height: sizeWidth * 0.3,
        decoration: new BoxDecoration(
          shape: (photoCircle) ? BoxShape.circle : BoxShape.rectangle,
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: profileImage != null
                ? MemoryImage(profileImage)
                : AssetImage('assets/images/white_pixel.jpg'),
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
      return Icons.business_center;
      break;
    case "phone":
      return FontAwesomeIcons.whatsapp;
      break;
    case "photo":
      return Icons.camera_alt;
      break;
    case "email":
      return Icons.email;
      break;
    case "facebook":
      return FontAwesomeIcons.facebook;
      break;
    case "instagram":
      return FontAwesomeIcons.instagram;
      break;
    case "twitter":
      return FontAwesomeIcons.twitter;
      break;
    case "linkedin":
      return FontAwesomeIcons.linkedin;
      break;
    case "youtube":
      return FontAwesomeIcons.youtube;
      break;
    case "website":
      return FontAwesomeIcons.globeAmericas;
      break;
  }
}

getHint(type) {
  switch (type) {
    case "name":
      return "digite o nome";
      break;
    case "occupation":
      return "digite a profissão ou serviço";
      break;
    case "phone":
      return "digite o telefone celular";
      break;
    case "email":
      return "endereço do e-mail ou qualquer texto";
      break;
    case "facebook":
      return "endereço do Facebook (opcional)";
      break;
    case "instagram":
      return "endereço do Instagram (opcional)";
      break;
    case "twitter":
      return "endereço do Twitter ou qualquer texto";
      break;
    case "linkedin":
      return "endereço do Linkedin ou qualquer texto";
      break;
    case "youtube":
      return "endereço do Youtube ou qualquer texto";
      break;
    case "website":
      return "endereço do site ou qualquer texto";
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
