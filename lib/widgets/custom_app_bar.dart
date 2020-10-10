import 'package:flutter/material.dart';

import '../main_page.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool formChanged;
  final bool formSaved;
  final Function actionSave;
  final Function actionBack;
  const CustomAppBar(
      {Key key,
      this.title,
      this.formChanged = false,
      this.formSaved = false,
      this.actionSave,
      this.actionBack})
      : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60.0);
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false, _clickedWithoutSave = false;
  final TextEditingController textController = TextEditingController();
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            }
          });

    return AppBar(
      title: Stack(
        children: <Widget>[
          FittedBox(
            child: Text(
              widget.title,
              style: TextStyle(color: Colors.white),
            ),
          ),
          _isLoading
              ? SizedBox(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlue),
                  height: 40.0,
                  width: 40.0,
                )
              : Container(),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            if (widget.formChanged && !_clickedWithoutSave) {
              if (widget.actionBack != null) {
                widget.actionBack();
                _navToHome(context);
              }
            else {
                controller.forward(from: 0.0);
                _clickedWithoutSave = true;
              }
            } else {
              _navToHome(context);
            }
          }),
      actions: <Widget>[
        (widget.formChanged && widget.actionBack == null)
            ? GestureDetector(
                onTap: widget.actionSave,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Column(
                    children: <Widget>[
                      AnimatedBuilder(
                          animation: offsetAnimation,
                          builder: (buildContext, child) {
                            return Container(
                                padding: EdgeInsets.only(
                                    left: offsetAnimation.value + 24.0,
                                    right: 24.0 - offsetAnimation.value),
                                child: Icon(
                                  Icons.save,
                                  size: 34,
                                  color: Colors.redAccent,
                                  semanticLabel: "salvar",
                                ));
                          }),
                      Text(
                        "salvar",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            : widget.formSaved
                ? Padding(
                  padding: const EdgeInsets.only(top: 6.0, right: 20.0),
                  child: Icon(
                    Icons.check,
                    size: 38,
                    color: Colors.greenAccent,
                  ),
                )
                : Container(),
      ],
    );
  }

  _navToHome(context) {
    FocusScope.of(context).requestFocus(FocusNode());
    _isLoading = true;
    setState(() {});
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => MainPage()),
      ModalRoute.withName('/'),
    );
  }
}
