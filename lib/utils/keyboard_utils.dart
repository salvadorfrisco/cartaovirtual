import 'dart:io';

import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class KeyboardUtils {

  static KeyboardActionsConfig _buildConfig(BuildContext context, List<FocusNode> nodes) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: Colors.grey[200],
        nextFocus: false,
        actions: nodes.map((node) {
          return KeyboardActionsItem( focusNode: node,);
        }).toList()
    );
  }

  static configKeyboardActions(BuildContext context, List<FocusNode> nodes) {
    if (Platform.isIOS && nodes != null) {
      return _buildConfig(context, nodes);
      //FormKeyboardActions.setKeyboardActions(context, KeyboardUtils._buildConfig(context, nodes));
    }
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        actions: nodes.map((node) => KeyboardActionsItem(focusNode: node, displayActionBar: false)).toList()
    );
  }


  static const double kBarSize = 45.0;

  static bool keyboardIsVisible(BuildContext? context) {
    if(context != null){
      return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
    }
    return false;
  }
  static getWidgetHeight(GlobalKey key) {
    if(key.currentContext != null){
      final RenderBox renderBoxRed = key.currentContext!.findRenderObject() as RenderBox;
      return renderBoxRed.size.height;
    }
    return 0.0;
  }

  static EdgeInsets padding({BuildContext? context, GlobalKey? key}){
    if(keyboardIsVisible(context)){
      double value = getWidgetHeight(key!);
      if(!Platform.isIOS){
        value = value + kBarSize;
      }
      return EdgeInsets.only(bottom: value);
    }
    return EdgeInsets.only(bottom: 0);
  }

  static closeOnTouchOutside(BuildContext context){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if(!currentFocus.hasPrimaryFocus){
      currentFocus.unfocus();
    }
  }

}