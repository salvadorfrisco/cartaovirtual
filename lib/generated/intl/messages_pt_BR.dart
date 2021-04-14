// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_BR locale. All the
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
  String get localeName => 'pt_BR';

  static m0(servingSize) => "*Baseado em uma porção de ${servingSize} fl. oz.";

  static m1(quantity, formattedNumber) => "${Intl.plural(quantity, one: 'Uma porção.', other: '${formattedNumber} porções no seu sistema de uma vez.')}";

  static m2(quantity, formattedNumber) => "${Intl.plural(quantity, one: 'Uma porção por dia.', other: '${formattedNumber} porções por dia.')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appName" : MessageLookupByLibrary.simpleMessage("criador de imagens"),
    "cellPhone" : MessageLookupByLibrary.simpleMessage("celular"),
    "changeBackgroundColor" : MessageLookupByLibrary.simpleMessage("alterar cor do fundo"),
    "changeBackgroundImage" : MessageLookupByLibrary.simpleMessage("alterar imagem de fundo"),
    "changeImageComponents" : MessageLookupByLibrary.simpleMessage("alterar componentes da imagem"),
    "comeOn" : MessageLookupByLibrary.simpleMessage("vamos lá"),
    "configureItems" : MessageLookupByLibrary.simpleMessage("configurar ítens"),
    "declarationReaded" : MessageLookupByLibrary.simpleMessage("Ao avançar declaro que li e concordo com os"),
    "editInformations" : MessageLookupByLibrary.simpleMessage("editar informações"),
    "firstSuggestedDrinkName" : MessageLookupByLibrary.simpleMessage("Café Coado (Xícara)"),
    "formPageActionButtonTitle" : MessageLookupByLibrary.simpleMessage("CALCULAR"),
    "formPageAppBarTitle" : MessageLookupByLibrary.simpleMessage("Calculadora de Morte por Cafeína"),
    "formPageCustomDrinkCaffeineAmountInputLabel" : MessageLookupByLibrary.simpleMessage("Cafeína"),
    "formPageCustomDrinkCaffeineAmountInputSuffix" : MessageLookupByLibrary.simpleMessage("mg"),
    "formPageCustomDrinkRadioTitle" : MessageLookupByLibrary.simpleMessage("Outra"),
    "formPageCustomDrinkServingSizeInputLabel" : MessageLookupByLibrary.simpleMessage("Tamanho"),
    "formPageCustomDrinkServingSizeInputSuffix" : MessageLookupByLibrary.simpleMessage("fl. oz"),
    "formPageRadioListLabel" : MessageLookupByLibrary.simpleMessage("Escolha uma bebida"),
    "formPageWeightInputLabel" : MessageLookupByLibrary.simpleMessage("Peso Corporal"),
    "formPageWeightInputSuffix" : MessageLookupByLibrary.simpleMessage("libras"),
    "goBack" : MessageLookupByLibrary.simpleMessage("voltar"),
    "imageUpload" : MessageLookupByLibrary.simpleMessage("upload de imagem"),
    "invalidCellPhone" : MessageLookupByLibrary.simpleMessage("Celular inválido"),
    "next" : MessageLookupByLibrary.simpleMessage("avançar"),
    "opacity" : MessageLookupByLibrary.simpleMessage("opacidade"),
    "pleaseWriteYourCellPhone" : MessageLookupByLibrary.simpleMessage("Favor preencher seu celular"),
    "pleaseWriteYourName" : MessageLookupByLibrary.simpleMessage("Favor preencher o nome"),
    "resultsPageAppBarTitle" : MessageLookupByLibrary.simpleMessage("Dosagens"),
    "resultsPageFirstDisclaimer" : m0,
    "resultsPageLethalDosageMessage" : m1,
    "resultsPageLethalDosageTitle" : MessageLookupByLibrary.simpleMessage("Dose Letal"),
    "resultsPageSafeDosageMessage" : m2,
    "resultsPageSafeDosageTitle" : MessageLookupByLibrary.simpleMessage("Limite Seguro Diário"),
    "resultsPageSecondDisclaimer" : MessageLookupByLibrary.simpleMessage("*Se aplica a pessoas com 18 anos ou mais. Essa calculadora não substitui conselhos médicos profissionais."),
    "ruleName" : MessageLookupByLibrary.simpleMessage("O nome deve ter no mínimo 5 caracteres"),
    "secondSuggestedDrinkName" : MessageLookupByLibrary.simpleMessage("Espresso (Shot)"),
    "selectImages" : MessageLookupByLibrary.simpleMessage("selecionar imagens"),
    "shareImage" : MessageLookupByLibrary.simpleMessage("compartilhar a imagem"),
    "termsOfUse" : MessageLookupByLibrary.simpleMessage("Termos de Uso e Política de Privacidade"),
    "thirdSuggestedDrinkName" : MessageLookupByLibrary.simpleMessage("Latte (Caneca)"),
    "version" : MessageLookupByLibrary.simpleMessage("versão"),
    "wc1" : MessageLookupByLibrary.simpleMessage("Image Creator é uma plataforma para divulgação dos seus serviços através da criação de imagens personalizadas de forma simples e rápida."),
    "wc2" : MessageLookupByLibrary.simpleMessage("você cadastra suas informações de contato, escolhe um tema de fundo e já pode distribuir seu imagem!"),
    "wc3" : MessageLookupByLibrary.simpleMessage("vamos criar um imagem personalizada inicial, não se preocupe, depois você poderá alterar e complementar as informações, inclusive uma foto ou logotipo."),
    "wc4" : MessageLookupByLibrary.simpleMessage("fique tranquilo, é apenas para fazer seu imagem inicial, não será repassado e você não receberá emails ou ligações."),
    "wc5" : MessageLookupByLibrary.simpleMessage("compartilhe os serviços com seus contatos, grupos de whatsapp, facebook para ser sempre lembrado."),
    "writeYourName" : MessageLookupByLibrary.simpleMessage("Digite seu nome"),
    "wt1" : MessageLookupByLibrary.simpleMessage("bem vindo"),
    "wt2" : MessageLookupByLibrary.simpleMessage("simples de usar"),
    "wt3" : MessageLookupByLibrary.simpleMessage("informações iniciais"),
    "wt4" : MessageLookupByLibrary.simpleMessage("dados para contato"),
    "wt5" : MessageLookupByLibrary.simpleMessage("divulgue e ganhe!")
  };
}
