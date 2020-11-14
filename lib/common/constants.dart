library constants;

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_card/utils/functions.dart';

const String NAME = "imagem Digital";
const String VERSION = "Versão";
const String WT1 = "Bem-vindo!";
const String WC1 =
    "Image Creator é uma plataforma para\ndivulgação dos seus serviços através da\ncriação de imagens personalizadas de\nforma simples e rápida.";
const String WT2 = "Simples de usar";
const String WC2 =
    "Você cadastra suas informações de\ncontato, escolhe um tema de fundo e\njá pode distribuir seu imagem!";
const String WT3 = "Informações iniciais";
const String WC3 =
    "Vamos criar um imagem personalizada inicial,\nnão se preocupe, depois você poderá alterar\ne complementar as informações, inclusive\numa foto ou logotipo.";
const String WT4 = "Dados para contato";
const String WC4 =
    "Fique tranquilo, é apenas para fazer\nseu imagem inicial, não será repassado e\nvocê não receberá emails ou ligações.";
const String WT5 = "Divulgue e ganhe!";
const String WC5 =
    "Compartilhe os serviços com seus\ncontatos, grupos de whatsapp, facebook\npara ser sempre lembrado.";
const String BACK = "Voltar";
const String SKIP = "Pular";
const String NEXT = "Avançar";
const String GOTIT = "Vamos lá!";

const List<String> TIPTITLE = [
  'Dica do dia',
  'Compartilhe',
  'Imcremente sua imagem',
  'Imagem de fundo',
  'Transparência',
  'Faça seu layout',
  'Seu conteúdo',
];

const Color colorShare = Color(0xCC32C652);
const Color colorBack = Colors.black54;

List<Widget> TIPMESSAGE = [
  Text(
    'Os ícones do lado esquerdo aparecerão somente se estiverem habilitados',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
    textAlign: TextAlign.center,
  ),
  RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: colorBack),
        children: [
          TextSpan(
            text: 'Divulgue seus serviços, convites, feeds em redes sociais compartilhando a imagem em ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          WidgetSpan(child: Functions.buildMessageWidgets(
              [Icon(Icons.share, size: 22, color: Colors.white)], 40.0, backColor: colorShare)),
        ],
      )),
  RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: Colors.black87),
        children: [
          TextSpan(
            text: 'Clique no botão ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          WidgetSpan(child: Functions.buildMessage(
              "Incluir foto...", 106.0)),
          TextSpan(
            text: ' acima para incluir uma foto da galeria na imagem ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
        ],
      )),
  RichText(
    textAlign: TextAlign.center,
      text: TextSpan(
    style: TextStyle(color: Colors.black87),
    children: [
      TextSpan(
        text: 'Troque a imagem de fundo clicando em ',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      ),
      WidgetSpan(child: Functions.buildMessageWidgets(
          [Icon(Icons.settings, size: 22, color: Colors.white,)], 40.0)),
      TextSpan(
        text: ' e ',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      ),
      WidgetSpan(child: Functions.buildMessageWidgets(
          [Icon(Icons.panorama, size: 22, color: Colors.white,)], 40.0)),
      TextSpan(
        text: ' selecione uma imagem ou faça upload em ',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
      ),
      WidgetSpan(child: Functions.buildMessageWidgets(
          [Icon(Icons.file_upload, size: 22, color: Colors.white,)], 40.0)),
    ],
  )),
  RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: Colors.black87),
        children: [
          TextSpan(
            text: 'Controle a opacidade da imagem de fundo, clique em  ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          WidgetSpan(child: Functions.buildMessageWidgets(
              [Icon(Icons.settings, size: 22, color: Colors.white,)], 40.0)),
          TextSpan(
            text: ' e ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          WidgetSpan(child: Functions.buildMessageWidgets(
              [Icon(Icons.panorama, size: 22, color: Colors.white,)], 40.0)),
          TextSpan(
            text: ' , deslize o botão do lado direito e veja o efeito ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
        ],
      )),

  RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: Colors.black87),
        children: [
          TextSpan(
            text: 'Altere a posição das informações, clique em  ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          WidgetSpan(child: Functions.buildMessageWidgets(
              [Icon(Icons.settings, size: 22, color: Colors.white,)], 40.0)),
          TextSpan(
            text: ' e ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
          WidgetSpan(child: Functions.buildMessageWidgets(
              [Icon(Icons.color_lens, size: 22, color: Colors.white,), Icon(Icons.zoom_out_map_sharp, size: 22, color: Colors.white,)], 40.0)),
          TextSpan(
            text: ' segure o item e arraste para o local desejado ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
        ],
      )),
  Text(
    'Os textos em cinza claro são apenas sugestões, você pode incluir qualquer texto para aparecer na imagem',
    style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
    textAlign: TextAlign.center,
  ),
];

const List<Color> TIPCOLOR = [
  Color(0xcc88cc55),
  Color(0xccffff88),
  Color(0xddffdead),
  Color(0xcc7fffd4),
  Color(0xcc55dfef),
  Color(0xccff82f6),
  Color(0xcc66a2e4),
];

const List<String> TIPANIMATION = [
  'assets/lottiefiles/five-stars.json',
  'assets/lottiefiles/share.json',
  'assets/lottiefiles/fill_cell.json',
  'assets/lottiefiles/background.json',
  'assets/lottiefiles/swipe-left-to-right.json',
  'assets/lottiefiles/position.json',
  'assets/lottiefiles/done.json',
];
