import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:virtual_card/common/constants.dart';
import 'package:virtual_card/services/storage_service.dart';
import 'package:virtual_card/utils/sizes_helpers.dart';
import '../utils/card_navigator.dart';
import '../widgets/walkthrough.dart';
import 'package:virtual_card/generated/l10n.dart';
import '../utils/extensions.dart';

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController controller = new PageController();
  StorageService storage = StorageService();
  final _nameController = TextEditingController();
  var maskTextInputFormatter = MaskTextInputFormatter(
      mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  double _sizeWidth, _sizeHeight;

  int currentPage = 0;
  bool isLoading = false,
       firstPage = true,
       lastPage = false,
       _nameFilled = false,
       _phoneFilled = false,
       _emailFilled = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
      if (currentPage == 0) {
        firstPage = true;
      } else if (currentPage == 4) {
        firstPage = false;
        lastPage = true;
      } else {
        firstPage = false;
        lastPage = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _sizeWidth = displayWidth(context);
    _sizeHeight = displayHeight(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          color: Color(0xFFEEEEEE),
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              SizedBox(height: _sizeHeight * 0.1),
              Container(
                height: _sizeHeight * 0.6,
                child: Stack(
                  children: <Widget>[
                    PageView(
                      children: <Widget>[
                        Walkthrough(
                          title: S.of(context).wt1.capitalize(),
                          content: S.of(context).wc1.capitalize(),
                          repeatAnimation: true,
                          animationIcon: 'assets/lottiefiles/services.json',
                          withField: false,
                        ),
                        Walkthrough(
                          title: S.of(context).wt2.capitalize(),
                          content: S.of(context).wc2.capitalize(),
                          repeatAnimation: false,
                          animationIcon: 'assets/lottiefiles/done.json',
                          withField: false,
                        ),
                        Walkthrough(
                          title: S.of(context).wt3.capitalize(),
                          content: S.of(context).wc3.capitalize(),
                          repeatAnimation: true,
                          animationIcon: 'assets/lottiefiles/fill_name.json',
                          withField: true,
                        ),
                        Walkthrough(
                          title: S.of(context).wt4.capitalize(),
                          content: S.of(context).wc4.capitalize(),
                          repeatAnimation: false,
                          animationIcon: 'assets/lottiefiles/fill_cell.json',
                          withField: true,
                        ),
                        Walkthrough(
                          title: S.of(context).wt5.capitalize(),
                          content: S.of(context).wc5.capitalize(),
                          repeatAnimation: false,
                          animationIcon: 'assets/lottiefiles/trophy.json',
                          withField: false,
                        ),
                      ],
                      controller: controller,
                      onPageChanged: _onPageChanged,
                    ),
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Container(),
                    currentPage == 2
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: _sizeWidth * 0.14, top: _sizeHeight * 0.3, right: _sizeWidth * 0.14),
                            child: _buildTextField(
                                S.of(context).writeYourName.capitalize(),
                                _nameController,
                                _sizeWidth * 0.07,
                                'Latu',
                                '',
                                TextInputType.name))
                        : Container(),
                    currentPage == 3
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: _sizeWidth * 0.14, top: _sizeHeight * 0.3, right: _sizeWidth * 0.14),
                            child: Column(
                              children: <Widget>[
                                _buildTextField(
                                    S.of(context).cellPhone.capitalize(),
                                    _phoneController,
                                    _sizeWidth * 0.072,
                                    'Latu',
                                    maskTextInputFormatter,
                                    TextInputType.number),
                              ],
                            ))
                        : Container(),
                  ],
                ),
              ),
              Column(children: <Widget>[
                Container(
                  height: _sizeHeight * 0.12,
                  child: firstPage ? _readTerms() : Container(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    firstPage
                        ? Container()
                        : FlatButton(
                            child: Text(S.of(context).goBack.capitalize(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: _sizeWidth * 0.046)),
                            onPressed: () {
                              controller.jumpToPage(currentPage - 1);
                            }),
                    FlatButton(
                      child: Text(lastPage ? S.of(context).comeOn.capitalize() : S.of(context).next.capitalize(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: _sizeWidth * 0.046)),
                      onPressed: () => lastPage ? _goHome() : _nextPage(),
                    ),
                  ],
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _readTerms() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(S.of(context).declarationReaded,
      style: TextStyle(
        color: Colors.blue,
        fontSize: _sizeWidth * 0.038),),
        GestureDetector(
            onTap: () => CardNavigator.navToTerms(context),
            child: Text(S.of(context).termsOfUse,
            style: TextStyle(
              color: Colors.blue,
              fontSize: _sizeWidth * 0.04,
              decoration: TextDecoration.underline,),)),
      ],
    );
  }

  Widget _buildTextField(
      labelText, controller, fntSize, fntFamily, maskTxt, txtInputType) {
    return Padding(
        padding: EdgeInsets.only(left: 16),
        child: SizedBox(
            width: _sizeWidth * 0.7,
            child: TextFormField(
                // inputFormatters: (maskTxt != '') ? [maskTxt] : [FilteringTextInputFormatter.deny(RegExp('[\\\\|\\"|\\,|\\{|\\}]'))],
                inputFormatters: (maskTxt != '') ? [maskTxt] : [LengthLimitingTextInputFormatter(50)],
                autofocus: true,
                onFieldSubmitted: (v) {
                  if (v.isEmpty) {
                    _showSnackBar(S.of(context).writeYourName);
                  } else if (v.length < 5) {
                    _showSnackBar(S.of(context).ruleName);
                  }
                },
                style: TextStyle(
                    fontSize: fntSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                keyboardType: txtInputType,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: labelText,
                  labelStyle: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.normal),
                ))));
  }

  bool _validateName() {
    _nameFilled = false;
    if (_nameController.text.length >= 5) {
      _nameFilled = true;
    } else if (_nameController.text.length == 0) {
      _showSnackBar(S.of(context).pleaseWriteYourName);
    } else {
      _showSnackBar(S.of(context).ruleName);
    }
    return _nameFilled;
  }

  bool _validatePhone() {
    _phoneFilled = false;
    if (_phoneController.text.length == 15) {
      _phoneFilled = true;
    } else if (_phoneController.text.length == 0) {
      _showSnackBar(S.of(context).pleaseWriteYourCellPhone);
    } else {
      _showSnackBar(S.of(context).invalidCellPhone);
    }
    return _phoneFilled;
  }

  void _showSnackBar(String message, {backColor: Colors.teal}) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        content: Text(message),
        backgroundColor: backColor,
      ),
    );
  }

  _nextPage() {
    if (currentPage == 2) {
      _initializeCards();
      if (_validateName()) controller.jumpToPage(currentPage + 1);
    } else if (currentPage == 3) {
      if (_validatePhone())
        controller.jumpToPage(currentPage + 1);
    } else {
      controller.jumpToPage(currentPage + 1);
    }
  }

  _goHome() {
    _initializeInfos()
        .then((_) => CardNavigator.navToHome(context));
  }

  _initializeCards() async {
    return await storage.initializeCards();
  }

  _initializeInfos() async {
    return await storage.initializeInfos(_nameController.text, _phoneController.text, displaySize(context));
  }
}
