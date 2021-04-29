import 'package:flutter/material.dart';
import 'package:virtual_card/models/content_model.dart';

class ColorPicker extends StatefulWidget {

   final ContentModel cnt;
   final Function onColorChanged;

   const ColorPicker({
     required this.cnt,
     required this.onColorChanged
   });

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {

  List colorsData = [
    Colors.yellowAccent,
    Colors.limeAccent,
    Colors.amberAccent,
    Colors.orangeAccent,
    Colors.deepOrangeAccent,
    Colors.red,
    Colors.pink,
    Colors.purpleAccent,
    Colors.purple,
    Colors.deepPurple,
    Colors.lightBlueAccent,
    Colors.blueAccent,
    Colors.indigoAccent,
    Colors.indigo,
    Colors.deepPurpleAccent,
    Colors.lightGreenAccent,
    Colors.cyanAccent,
    Colors.tealAccent,
    Colors.greenAccent,
    Colors.cyan,
    Colors.lime,
    Colors.lightGreen,
    Colors.green,
    Colors.teal,
    Colors.brown,
    Colors.white,
    Colors.white70,
    Colors.grey,
    Colors.blueGrey,
    Colors.black
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
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: colorsData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5 ,childAspectRatio:1),
            itemBuilder: (BuildContext context,int index){

              return Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: new FloatingActionButton(
                  onPressed: (){
                    setState(() {
                      widget.onColorChanged(color: colorsData[index], cnt: widget.cnt);
                    });
                  },
                  child: Icon(Icons.done,color: colorsData[index] == widget.cnt.color ? Colors.white : colorsData.elementAt(index), size: 38),
                  backgroundColor: colorsData.elementAt(index),
                  elevation: 0.0,
                  heroTag: null,
                ),
              );
            },
            shrinkWrap: true,
          ),
        );
  }
}
