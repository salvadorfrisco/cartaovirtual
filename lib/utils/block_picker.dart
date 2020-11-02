import 'package:virtual_card/models/content_model.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
/// Block Color Picker

import 'package:flutter/material.dart';

typedef PickerLayoutBuilder = Widget Function(
    BuildContext context, List<Color> colors, PickerItem child);
typedef PickerItem = Widget Function(Color color);
typedef PickerItemBuilder = Widget Function(
    Color color, bool isCurrentColor, Function changeColor);

class BlockPicker extends StatefulWidget {
  const BlockPicker({
    @required this.cnt,
    @required this.pickerColor,
    @required this.onColorChanged,
    this.availableColors,
    this.layoutBuilder = defaultLayoutBuilder,
    this.itemBuilder = defaultItemBuilder,
  });

  final ContentModel cnt;
  final Color pickerColor;
  final Function onColorChanged;
  final List<Color> availableColors;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  static Widget defaultLayoutBuilder(
      BuildContext context, List<Color> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      width: displayWidth(context) * 0.8,
      height: displayHeight(context) * 0.56,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait ? 4 : 6,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        children: colors.map((Color color) => child(color)).toList(),
      ),
    );
  }

  static Widget defaultItemBuilder(
      Color color, bool isCurrentColor, Function changeColor) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.8),
            offset: Offset(1.0, 2.0),
            blurRadius: 3.0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(50.0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 210),
            opacity: isCurrentColor ? 1.0 : 0.0,
            child: CircleAvatar(radius: 20),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _BlockPickerState();
}

class _BlockPickerState extends State<BlockPicker> {
  Color _currentColor;

  @override
  void initState() {
    _currentColor = widget.pickerColor;
    super.initState();
  }

  void changeColor(Color color, ContentModel cnt) {
    setState(() => _currentColor = color);
    widget.onColorChanged(color: color, cnt: cnt);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(
      context,
      widget.availableColors,
          (Color color, [bool _, Function __]) => widget.itemBuilder(
          color, _currentColor.value == null, () => changeColor(color, widget.cnt)),
    );
  }
}
