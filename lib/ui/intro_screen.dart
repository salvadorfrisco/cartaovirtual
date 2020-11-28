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
                          title: WT1,
                          content: WC1,
                          repeatAnimation: true,
                          animationIcon: 'assets/lottiefiles/services.json',
                          withField: false,
                        ),
                        Walkthrough(
                          title: WT2,
                          content: WC2,
                          repeatAnimation: false,
                          animationIcon: 'assets/lottiefiles/done.json',
                          withField: false,
                        ),
                        Walkthrough(
                          title: WT3,
                          content: WC3,
                          repeatAnimation: true,
                          animationIcon: 'assets/lottiefiles/fill_name.json',
                          withField: true,
                        ),
                        Walkthrough(
                          title: WT4,
                          content: WC4,
                          repeatAnimation: false,
                          animationIcon: 'assets/lottiefiles/fill_cell.json',
                          withField: true,
                        ),
                        Walkthrough(
                          title: WT5,
                          content: WC5,
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
                                "Digite seu nome",
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
                                    "celular",
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
      children: <Widget>[
        Text("Ao avançar declaro que li e concordo com os",
      style: TextStyle(
        color: Colors.blue,
        fontSize: _sizeWidth * 0.038),),
        GestureDetector(
            onTap: () => CardNavigator.navToTerms(context),
            child: Text("Termos de Uso e Política de Privacidade",
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
                    _showSnackBar('Digite seu nome');
                  } else if (v.length < 5) {
                    _showSnackBar('O nome deve ter no mínimo 5 caracteres');
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
      _showSnackBar('Favor preencher o nome');
    } else {
      _showSnackBar('O nome deve ter no mínimo 5 letras');
    }
    return _nameFilled;
  }

  bool _validatephone() {
    _phoneFilled = false;
    if (_phoneController.text.length == 15) {
      _phoneFilled = true;
    } else if (_phoneController.text.length == 0) {
      _showSnackBar('Favor preencher seu celular');
    } else {
      _showSnackBar('Celular inválido');
    }
    return _phoneFilled;
  }

  bool _validateEmail() {
    _emailFilled = false;
    if (_emailController.text.length < 5) {
      _emailFilled = true;
    } else if (_emailController.text.length == 0) {
      _showSnackBar('Favor preencher seu email');
    } else {
      _showSnackBar('Email inválido');
    }
    return _emailFilled;
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
      if (_validatephone() || _validateEmail())
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
