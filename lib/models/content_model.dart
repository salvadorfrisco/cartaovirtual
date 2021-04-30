import 'package:flutter/material.dart';

class ContentModel {
  String? id;
  String? type;
  String? txt;
  bool? hasIcon;
  IconData? icon;
  double? size;
  String? font;
  double? scale;
  Color? color;
  double? posX;
  double? posY;
  double angle;

  ContentModel(
    {this.id,
     this.type,
     this.txt,
     this.hasIcon,
     this.icon,
     this.size,
     this.font,
     this.scale,
     this.color,
     this.posX,
     this.posY,
     this.angle = 0.0});
}
