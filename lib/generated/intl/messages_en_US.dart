// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en_US';

  static m0(servingSize) => "*Based on ${servingSize} fl. oz serving.";

  static m1(quantity, formattedNumber) => "${Intl.plural(quantity, one: 'One serving.', other: '${formattedNumber} servings in your system at one time.')}";

  static m2(quantity, formattedNumber) => "${Intl.plural(quantity, one: 'One serving per day.', other: '${formattedNumber} servings per day.')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appName" : MessageLookupByLibrary.simpleMessage("image creator"),
    "cellPhone" : MessageLookupByLibrary.simpleMessage("Cell Phone"),
    "changeBackgroundColor" : MessageLookupByLibrary.simpleMessage("change background color"),
    "changeBackgroundImage" : MessageLookupByLibrary.simpleMessage("change background image"),
    "changeImageComponents" : MessageLookupByLibrary.simpleMessage("change image components"),
    "comeOn" : MessageLookupByLibrary.simpleMessage("let\'s go"),
    "configureItems" : MessageLookupByLibrary.simpleMessage("configure items"),
    "declarationReaded" : MessageLookupByLibrary.simpleMessage("Moving forward, I declare that\nI have read and agree with the"),
    "editInformations" : MessageLookupByLibrary.simpleMessage("edit informations"),
    "firstSuggestedDrinkName" : MessageLookupByLibrary.simpleMessage("Drip Coffee (Cup)"),
    "formPageActionButtonTitle" : MessageLookupByLibrary.simpleMessage("CALCULATE"),
    "formPageAppBarTitle" : MessageLookupByLibrary.simpleMessage("Death by Caffeine Calculator"),
    "formPageCustomDrinkCaffeineAmountInputLabel" : MessageLookupByLibrary.simpleMessage("Caffeine"),
    "formPageCustomDrinkCaffeineAmountInputSuffix" : MessageLookupByLibrary.simpleMessage("mg"),
    "formPageCustomDrinkRadioTitle" : MessageLookupByLibrary.simpleMessage("Other"),
    "formPageCustomDrinkServingSizeInputLabel" : MessageLookupByLibrary.simpleMessage("Serving Size"),
    "formPageCustomDrinkServingSizeInputSuffix" : MessageLookupByLibrary.simpleMessage("fl. oz"),
    "formPageRadioListLabel" : MessageLookupByLibrary.simpleMessage("Choose a drink"),
    "formPageWeightInputLabel" : MessageLookupByLibrary.simpleMessage("Body Weight"),
    "formPageWeightInputSuffix" : MessageLookupByLibrary.simpleMessage("pounds"),
    "goBack" : MessageLookupByLibrary.simpleMessage("return"),
    "imageUpload" : MessageLookupByLibrary.simpleMessage("image upload"),
    "invalidCellPhone" : MessageLookupByLibrary.simpleMessage("Invalid cell phone"),
    "next" : MessageLookupByLibrary.simpleMessage("next"),
    "opacity" : MessageLookupByLibrary.simpleMessage("opacity"),
    "pleaseWriteYourCellPhone" : MessageLookupByLibrary.simpleMessage("Please fill in your cell phone"),
    "pleaseWriteYourName" : MessageLookupByLibrary.simpleMessage("Please fill in the name"),
    "resultsPageAppBarTitle" : MessageLookupByLibrary.simpleMessage("Dosages"),
    "resultsPageFirstDisclaimer" : m0,
    "resultsPageLethalDosageMessage" : m1,
    "resultsPageLethalDosageTitle" : MessageLookupByLibrary.simpleMessage("Lethal Dosage"),
    "resultsPageSafeDosageMessage" : m2,
    "resultsPageSafeDosageTitle" : MessageLookupByLibrary.simpleMessage("Daily Safe Maximum"),
    "resultsPageSecondDisclaimer" : MessageLookupByLibrary.simpleMessage("*Applies to age 18 and over. This calculator does not replace professional medical advice."),
    "ruleName" : MessageLookupByLibrary.simpleMessage("The name must be at least 5 characters"),
    "secondSuggestedDrinkName" : MessageLookupByLibrary.simpleMessage("Espresso (Shot)"),
    "selectImages" : MessageLookupByLibrary.simpleMessage("select images"),
    "shareImage" : MessageLookupByLibrary.simpleMessage("share image"),
    "termsOfUse" : MessageLookupByLibrary.simpleMessage("Terms of Use and Privacy Policy"),
    "thirdSuggestedDrinkName" : MessageLookupByLibrary.simpleMessage("Latte (Mug)"),
    "version" : MessageLookupByLibrary.simpleMessage("version"),
    "wc1" : MessageLookupByLibrary.simpleMessage("image Creator is a platform for share your services by creating personalized images in a simple and fast way."),
    "wc2" : MessageLookupByLibrary.simpleMessage("you register your information contact, choose a background theme and you can now distribute your image!"),
    "wc3" : MessageLookupByLibrary.simpleMessage("let\'s create a custom initial image, don\'t worry, then you can change and complement the information, including a photo or logo."),
    "wc4" : MessageLookupByLibrary.simpleMessage("rest assured, it\'s just to do your initial image, will not be passed on and you will not receive emails or calls."),
    "wc5" : MessageLookupByLibrary.simpleMessage("share services with your contacts, whatsapp groups, facebook to always be remembered."),
    "writeYourName" : MessageLookupByLibrary.simpleMessage("Write your name"),
    "wt1" : MessageLookupByLibrary.simpleMessage("welcome"),
    "wt2" : MessageLookupByLibrary.simpleMessage("simple to use"),
    "wt3" : MessageLookupByLibrary.simpleMessage("initial information"),
    "wt4" : MessageLookupByLibrary.simpleMessage("contact details"),
    "wt5" : MessageLookupByLibrary.simpleMessage("share and win!")
  };
}
