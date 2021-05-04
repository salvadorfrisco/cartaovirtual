// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `edit informations`
  String get editInformations {
    return Intl.message(
      'edit informations',
      name: 'editInformations',
      desc: '',
      args: [],
    );
  }

  /// `share image`
  String get shareImage {
    return Intl.message(
      'share image',
      name: 'shareImage',
      desc: '',
      args: [],
    );
  }

  /// `select images`
  String get selectImages {
    return Intl.message(
      'select images',
      name: 'selectImages',
      desc: '',
      args: [],
    );
  }

  /// `change image components`
  String get changeImageComponents {
    return Intl.message(
      'change image components',
      name: 'changeImageComponents',
      desc: '',
      args: [],
    );
  }

  /// `configure items`
  String get configureItems {
    return Intl.message(
      'configure items',
      name: 'configureItems',
      desc: '',
      args: [],
    );
  }

  /// `change background image`
  String get changeBackgroundImage {
    return Intl.message(
      'change background image',
      name: 'changeBackgroundImage',
      desc: '',
      args: [],
    );
  }

  /// `change background color`
  String get changeBackgroundColor {
    return Intl.message(
      'change background color',
      name: 'changeBackgroundColor',
      desc: '',
      args: [],
    );
  }

  /// `opacity`
  String get opacity {
    return Intl.message(
      'opacity',
      name: 'opacity',
      desc: '',
      args: [],
    );
  }

  /// `image upload`
  String get imageUpload {
    return Intl.message(
      'image upload',
      name: 'imageUpload',
      desc: '',
      args: [],
    );
  }

  /// `return`
  String get goBack {
    return Intl.message(
      'return',
      name: 'goBack',
      desc: '',
      args: [],
    );
  }

  /// `let's go`
  String get comeOn {
    return Intl.message(
      'let\'s go',
      name: 'comeOn',
      desc: '',
      args: [],
    );
  }

  /// `next`
  String get next {
    return Intl.message(
      'next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `image creator`
  String get appName {
    return Intl.message(
      'image creator',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `welcome`
  String get wt1 {
    return Intl.message(
      'welcome',
      name: 'wt1',
      desc: '',
      args: [],
    );
  }

  /// `image Creator is a platform for share your services by creating personalized images in a simple and fast way.`
  String get wc1 {
    return Intl.message(
      'image Creator is a platform for share your services by creating personalized images in a simple and fast way.',
      name: 'wc1',
      desc: '',
      args: [],
    );
  }

  /// `simple to use`
  String get wt2 {
    return Intl.message(
      'simple to use',
      name: 'wt2',
      desc: '',
      args: [],
    );
  }

  /// `you register your information contact, choose a background theme and you can now distribute your image!`
  String get wc2 {
    return Intl.message(
      'you register your information contact, choose a background theme and you can now distribute your image!',
      name: 'wc2',
      desc: '',
      args: [],
    );
  }

  /// `initial information`
  String get wt3 {
    return Intl.message(
      'initial information',
      name: 'wt3',
      desc: '',
      args: [],
    );
  }

  /// `let's create a custom initial image, don't worry, then you can change and complement the information, including a photo or logo.`
  String get wc3 {
    return Intl.message(
      'let\'s create a custom initial image, don\'t worry, then you can change and complement the information, including a photo or logo.',
      name: 'wc3',
      desc: '',
      args: [],
    );
  }

  /// `contact details`
  String get wt4 {
    return Intl.message(
      'contact details',
      name: 'wt4',
      desc: '',
      args: [],
    );
  }

  /// `rest assured, it's just to do your initial image, will not be passed on and you will not receive emails or calls.`
  String get wc4 {
    return Intl.message(
      'rest assured, it\'s just to do your initial image, will not be passed on and you will not receive emails or calls.',
      name: 'wc4',
      desc: '',
      args: [],
    );
  }

  /// `share and win!`
  String get wt5 {
    return Intl.message(
      'share and win!',
      name: 'wt5',
      desc: '',
      args: [],
    );
  }

  /// `share services with your contacts, whatsapp groups, facebook to always be remembered.`
  String get wc5 {
    return Intl.message(
      'share services with your contacts, whatsapp groups, facebook to always be remembered.',
      name: 'wc5',
      desc: '',
      args: [],
    );
  }

  /// `version`
  String get version {
    return Intl.message(
      'version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Write your name`
  String get writeYourName {
    return Intl.message(
      'Write your name',
      name: 'writeYourName',
      desc: '',
      args: [],
    );
  }

  /// `Cell Phone`
  String get cellPhone {
    return Intl.message(
      'Cell Phone',
      name: 'cellPhone',
      desc: '',
      args: [],
    );
  }

  /// `Moving forward, I declare that\nI have read and agree with the`
  String get declarationReaded {
    return Intl.message(
      'Moving forward, I declare that\nI have read and agree with the',
      name: 'declarationReaded',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use and Privacy Policy`
  String get termsOfUse {
    return Intl.message(
      'Terms of Use and Privacy Policy',
      name: 'termsOfUse',
      desc: '',
      args: [],
    );
  }

  /// `The name must be at least 5 characters`
  String get ruleName {
    return Intl.message(
      'The name must be at least 5 characters',
      name: 'ruleName',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the name`
  String get pleaseWriteYourName {
    return Intl.message(
      'Please fill in the name',
      name: 'pleaseWriteYourName',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in your cell phone`
  String get pleaseWriteYourCellPhone {
    return Intl.message(
      'Please fill in your cell phone',
      name: 'pleaseWriteYourCellPhone',
      desc: '',
      args: [],
    );
  }

  /// `Invalid cell phone`
  String get invalidCellPhone {
    return Intl.message(
      'Invalid cell phone',
      name: 'invalidCellPhone',
      desc: '',
      args: [],
    );
  }

  /// `type the name`
  String get nameHint {
    return Intl.message(
      'type the name',
      name: 'nameHint',
      desc: '',
      args: [],
    );
  }

  /// `enter profession or service`
  String get occupationHint {
    return Intl.message(
      'enter profession or service',
      name: 'occupationHint',
      desc: '',
      args: [],
    );
  }

  /// `enter cell phone`
  String get cellPhoneHint {
    return Intl.message(
      'enter cell phone',
      name: 'cellPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `email address or any text`
  String get emailAddressHint {
    return Intl.message(
      'email address or any text',
      name: 'emailAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Facebook address (optional)`
  String get facebookAddressHint {
    return Intl.message(
      'Facebook address (optional)',
      name: 'facebookAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Instagram address (optional)`
  String get instagramAddressHint {
    return Intl.message(
      'Instagram address (optional)',
      name: 'instagramAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Twitter address or any text`
  String get twitterAddressHint {
    return Intl.message(
      'Twitter address or any text',
      name: 'twitterAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Linkedin address or any text`
  String get linkedinAddressHint {
    return Intl.message(
      'Linkedin address or any text',
      name: 'linkedinAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Youtube address or any text`
  String get youtubeAddressHint {
    return Intl.message(
      'Youtube address or any text',
      name: 'youtubeAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `website address or any text`
  String get websiteAddressHint {
    return Intl.message(
      'website address or any text',
      name: 'websiteAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Tip of the day`
  String get tipOfTheDay {
    return Intl.message(
      'Tip of the day',
      name: 'tipOfTheDay',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Enhance your image`
  String get enhanceYourImage {
    return Intl.message(
      'Enhance your image',
      name: 'enhanceYourImage',
      desc: '',
      args: [],
    );
  }

  /// `Background image`
  String get backgroundImage {
    return Intl.message(
      'Background image',
      name: 'backgroundImage',
      desc: '',
      args: [],
    );
  }

  /// `Transparency`
  String get transparency {
    return Intl.message(
      'Transparency',
      name: 'transparency',
      desc: '',
      args: [],
    );
  }

  /// `Make your layout`
  String get makeYourLayout {
    return Intl.message(
      'Make your layout',
      name: 'makeYourLayout',
      desc: '',
      args: [],
    );
  }

  /// `Your content`
  String get yourContent {
    return Intl.message(
      'Your content',
      name: 'yourContent',
      desc: '',
      args: [],
    );
  }

  /// `Include photo from gallery`
  String get includePhotoFromGallery {
    return Intl.message(
      'Include photo from gallery',
      name: 'includePhotoFromGallery',
      desc: '',
      args: [],
    );
  }

  /// ` and `
  String get and {
    return Intl.message(
      ' and ',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `The icons on the left side will only appear if they are enabled`
  String get txtTip1 {
    return Intl.message(
      'The icons on the left side will only appear if they are enabled',
      name: 'txtTip1',
      desc: '',
      args: [],
    );
  }

  /// `Promote your services, invitations, feeds on social networks by sharing the image on `
  String get txtTip2 {
    return Intl.message(
      'Promote your services, invitations, feeds on social networks by sharing the image on ',
      name: 'txtTip2',
      desc: '',
      args: [],
    );
  }

  /// `Click on the button `
  String get txtTip3a {
    return Intl.message(
      'Click on the button ',
      name: 'txtTip3a',
      desc: '',
      args: [],
    );
  }

  /// `Include photo...`
  String get txtTip3b {
    return Intl.message(
      'Include photo...',
      name: 'txtTip3b',
      desc: '',
      args: [],
    );
  }

  /// ` above to include a photo from the gallery in the image `
  String get txtTip3c {
    return Intl.message(
      ' above to include a photo from the gallery in the image ',
      name: 'txtTip3c',
      desc: '',
      args: [],
    );
  }

  /// `Change the background image by clicking `
  String get txtTip4a {
    return Intl.message(
      'Change the background image by clicking ',
      name: 'txtTip4a',
      desc: '',
      args: [],
    );
  }

  /// ` select an image or upload on `
  String get txtTip4b {
    return Intl.message(
      ' select an image or upload on ',
      name: 'txtTip4b',
      desc: '',
      args: [],
    );
  }

  /// `Control the opacity of the background image, click `
  String get txtTip5a {
    return Intl.message(
      'Control the opacity of the background image, click ',
      name: 'txtTip5a',
      desc: '',
      args: [],
    );
  }

  /// ` , slide the button on the right side and see the effect `
  String get txtTip5b {
    return Intl.message(
      ' , slide the button on the right side and see the effect ',
      name: 'txtTip5b',
      desc: '',
      args: [],
    );
  }

  /// `Change the position of the information, click `
  String get txtTip6a {
    return Intl.message(
      'Change the position of the information, click ',
      name: 'txtTip6a',
      desc: '',
      args: [],
    );
  }

  /// ` hold the item and drag it to the desired location `
  String get txtTip6b {
    return Intl.message(
      ' hold the item and drag it to the desired location ',
      name: 'txtTip6b',
      desc: '',
      args: [],
    );
  }

  /// `The light gray texts are only suggestions, you can include any text to appear in the image`
  String get txtTip7 {
    return Intl.message(
      'The light gray texts are only suggestions, you can include any text to appear in the image',
      name: 'txtTip7',
      desc: '',
      args: [],
    );
  }

  /// `Click for choose image from gallery`
  String get chooseImage {
    return Intl.message(
      'Click for choose image from gallery',
      name: 'chooseImage',
      desc: '',
      args: [],
    );
  }

  /// `If you denied access to gallery, to permiss again you have reinstall de application or clear the storage data`
  String get tipAccessDenied {
    return Intl.message(
      'If you denied access to gallery, to permiss again you have reinstall de application or clear the storage data',
      name: 'tipAccessDenied',
      desc: '',
      args: [],
    );
  }

  /// `(denied)`
  String get denied {
    return Intl.message(
      '(denied)',
      name: 'denied',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
