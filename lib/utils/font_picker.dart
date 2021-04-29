import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:virtual_card/models/content_model.dart';

class FontPicker extends StatefulWidget {
  final ContentModel cnt;
  final Function onFontChanged;

  const FontPicker({required this.cnt, required this.onFontChanged});

  @override
  _FontPickerState createState() => _FontPickerState();
}

class _FontPickerState extends State<FontPicker> {
  String font = 'Arapey';

  List<String> fonts = [
    'Lato',
    'Lobster',
    'Architects Daughter',
    'Dancing Script',
    'Jomhuria',
    'Amatic SC',
    'Montserrat',
    'Raleway',
    'Arvo',
    'Prata',
    'Orbitron',
    'Monoton',
    'Ultra'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Dialog(
      elevation: 0,
      backgroundColor: Colors.white,
      child: _buildDialogContent(context),
    ));
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.black12,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: fonts.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                widget.onFontChanged(font: fonts[index], cnt: widget.cnt);
              });
            },
            child: Container(
              height: 60.0,
              alignment: Alignment.bottomCenter,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: fonts[index],
                          style: GoogleFonts.getFont(fonts[index],
                              fontSize: 38, color: Colors.black87),
                        ),
                        WidgetSpan(
                            child: fonts[index] == widget.cnt.font
                                ? Icon(Icons.done,
                                    color: Colors.green, size: 50)
                                : SizedBox(
                                    width: 0,
                                  )),
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}
