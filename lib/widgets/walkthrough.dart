import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';

class Walkthrough extends StatefulWidget {
  final title;
  final content;
  final animationIcon;
  final repeatAnimation;
  final animationBelow;
  final withField;

  Walkthrough(
      {this.title,
      this.content,
      this.animationIcon,
      this.repeatAnimation,
      this.animationBelow,
      this.withField});

  @override
  WalkthroughState createState() {
    return WalkthroughState();
  }
}

class WalkthroughState extends State<Walkthrough>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 500));
    animation = Tween(begin: 250.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut));
    animation.addListener(() => setState(() {}));
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Material(
        animationDuration: Duration(milliseconds: 600),
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              widget.animationIcon,
              repeat: widget.repeatAnimation,
              frameBuilder: (context, child, composition) {
                return AnimatedOpacity(
                  child: child,
                  opacity: composition == null ? 0 : 1,
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeOut,
                );
              },
              width: widget.withField ? displayWidth(context) * 0.3 : displayWidth(context) * 0.4,
            ),
            Padding(
              padding: EdgeInsets.only(top: displayWidth(context) * 0.04),
              child: Transform(
                transform:
                    Matrix4.translationValues(animation.value, 0.0, 0.0),
                child: FittedBox(
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: displayHeight(context) * 0.032,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(height: widget.withField ? displayHeight(context) * 0.14 : 0),
            Padding(
              padding: EdgeInsets.only(top: widget.withField ? 0 : displayHeight(context) * 0.04),
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.content,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15.0,
                          color: Colors.black)),
                ),
              ),
            ),
            widget.animationBelow != null
                ? Lottie.asset(
                    widget.animationBelow,
                    frameBuilder: (context, child, composition) {
                      return AnimatedOpacity(
                        child: child,
                        opacity: composition == null ? 0 : 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                      );
                    },
                    width: 100.0,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
