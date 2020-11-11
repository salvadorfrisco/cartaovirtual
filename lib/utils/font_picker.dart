import 'dart:async';
import 'package:virtual_card/models/content_model.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import 'package:flutter/material.dart';

typedef PickerLayoutBuilder = Widget Function(
    BuildContext context, List<String> fonts, PickerItem child, String fontSelected);
typedef PickerItem = Widget Function(String font);
typedef PickerItemBuilder = Widget Function(
    String font, bool isCurrentFont, Function changeFont);

class FontPicker extends StatefulWidget {
  const FontPicker({
    @required this.cnt,
    @required this.pickerFont,
    @required this.onFontChanged,
    this.availableFonts,
    this.layoutBuilder = defaultLayoutBuilder,
    this.itemBuilder = defaultItemBuilder,
  });

  final ContentModel cnt;
  final String pickerFont;
  final Function onFontChanged;
  final List<String> availableFonts;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  static Widget defaultLayoutBuilder(
      BuildContext context, List<String> fonts, PickerItem child, String fontSelected) {
    Orientation orientation = MediaQuery.of(context).orientation;
    final _controller = ScrollController();

    Timer(
      Duration(milliseconds: 1),
          () => _controller.animateTo(  fonts.indexOf(fontSelected).toDouble() * 50,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 500)),
    );

    return Container(
      width: displayWidth(context) * 0.94,
      height: displayHeight(context) * 0.56,
      color: Colors.black87,
      child: ListView(
        controller: _controller,
        children: fonts.map((String font) {
          return child(font);
        }).toList(),
      ),
    );
  }

  static Widget defaultItemBuilder(
      String font, bool isCurrentFont, Function changeFont) {
    return Container(
      margin: EdgeInsets.all(2.0),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(50.0),
      //   // color: color,
      //   boxShadow: [
      //     BoxShadow(
      //       // color: color.withOpacity(0.8),
      //       offset: Offset(1.0, 2.0),
      //       blurRadius: 3.0,
      //     ),
      //   ],
      // ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeFont,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            height: 50.0,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                font,
                style: TextStyle(
                    fontFamily: font,
                    fontSize: 32.0,
                    color: isCurrentFont ? Colors.blue : Colors.white,
                    // fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
          // child: AnimatedOpacity(
          //   duration: const Duration(milliseconds: 210),
          //   opacity: isCurrentFont ? 1.0 : 0.0,
          //   child: CircleAvatar(radius: 20),
          // ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _FontPickerState();
}

class _FontPickerState extends State<FontPicker> {
  String _currentFont;
  ScrollController _controller;

  @override
  void initState() {
    _currentFont = widget.pickerFont;
    _controller = ScrollController();
    super.initState();
  }

  void changeFont(String font, ContentModel cnt) {
    setState(() => _currentFont = font);
    widget.onFontChanged(font: font, cnt: cnt);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(
      context,
      widget.availableFonts,
          (String font, [bool _, Function __]) => widget.itemBuilder(
          font, _currentFont == font, () => changeFont(font, widget.cnt)),
      widget.pickerFont
    );
  }

}
