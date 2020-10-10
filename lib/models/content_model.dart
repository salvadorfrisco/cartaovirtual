import 'package:flutter/material.dart';

class ContentModel {
  String id;
  String type;
  String txt;
  bool hasIcon;
  IconData icon;
  double size;
  Color color;
  double posX;
  double posY;

  ContentModel(
      {this.id,
       this.type,
       this.txt,
       this.hasIcon,
       this.icon,
       this.size,
       this.color,
       this.posX,
       this.posY,});
}
