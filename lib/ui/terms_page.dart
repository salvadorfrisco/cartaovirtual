import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  final Color _appColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: _appColor,
        appBar: AppBar(title: FittedBox(child: Text("Termos e Política de Privacidade"))),
        body: Container(
          margin: EdgeInsets.all(12.0),
          child: ListView(
            children: <Widget>[
              _text('TERMOS DE USO E POLÍTICA DE PRIVACIDADE', ''),
              _text(
                  '',
                  '\nEstes são os Termo de Uso e Política de Privacidade, aqui denominado apenas como "TERMO", '
                      'da Frisk Ltd, aqui denominada apenas como \"Frisk\", em que '
                      'explicamos como tratamos os dados que você, usuário, fornece para nós.'),
              _text(
                  '',
                  '\nLeia atentamente o seguinte TERMO, pois ele se aplica ao seu acesso e forma de uso das '
                      'informações, materiais, itens e funções contidas neste Aplicativo.\n\n'
                      ' Ao acessar este Aplicativo, você estará concordando e declarando estar ciente com este TERMO.\n'),
              _text('1. DEFINIÇÕES\n', ''),
              _text('1.1. ', 'Para os fins deste TERMO, consideram-se:'),
              _text(
                  '   (i) ',
                  ' Endereço de Protocolo de Internet (Endereço IP): o código atribuído a um Terminal de '
                      'uma rede para permitir sua identificação, definido segundo parâmetros internacionais.'),
              _text(
                  '   (ii) ',
                  ' Internet: o sistema constituído do conjunto de protocolos lógicos, estruturado em escala '
                      'mundial para uso público e irrestrito, com a finalidade de possibilitar a comunicação de dados '
                      'entre terminais por meio de diferentes redes.'),
              _text(
                  '   (iii) ',
                  ' Aplicativo: aplicativo da Frisk por meio dos quais o usuário acessa os serviços e '
                      'conteúdos disponibilizados pela Frisk, aqui também denominado como "Plataforma".'),
              _text(
                  '   (iv) ',
                  ' Terminais: computadores, notebooks, netbooks, smartphones, tablets, palm tops e quaisquer '
                      'outros dispositivos que se conectem a Internet.'),
              _text(
                  '   (v) ',
                  ' usuários todas as pessoas físicas que utilizarão os Aplicativos, maiores de 18 '
                      '(dezoito) anos ou emancipadas e totalmente capazes de praticar os atos da vida civil ou os '
                      'absolutamente ou relativamente incapazes devidamente representados ou assistidos.\n'),
              _text('1.2. ',
                  ' Este TERMO deverá ser regido e interpretado de acordo com os seguintes princípios:'),
              _text(
                  '   (i) ',
                  ' os cabeçalhos e títulos servem apenas para conveniência de referência e não limitarão ou '
                      'afetarão o significado das cláusulas, parágrafos ou itens aos quais se aplicam;'),
              _text(
                  '   (ii) ',
                  'Toda vez que houver menção aos termos “Frisk”, “nós” ou “nossos” '
                      'estaremos nos referindo à Frisk Ltd; bem como toda vez que houver menção aos '
                      'termos “você”, “usuário”, “seu”, “sua”, estaremos nos referindo a você '
                      'usuário, que está consentindo com estes Termos de Uso e com a Política de '
                      'Dados para fazer uso e acesso à Plataforma.'),
              _text(
                  '   (iii) ',
                  ' os termos “inclusive”, “incluindo” e outros termos semelhantes serão interpretados como se '
                      'estivessem acompanhados da frase “a título meramente exemplificativo” e “sem limitação”;'),
              _text(
                  '   (iv) ',
                  ' sempre que exigido pelo contexto, as definições contidas neste TERMO serão aplicadas '
                      'tanto no singular quanto no plural e o gênero masculino incluirá o feminino e vice-versa, sem '
                      'alteração de significado;'),
              _text(
                  '   (v) ',
                  ' referências a qualquer documento ou outros instrumentos incluem todas as suas alterações, '
                      'substituições e consolidações e respectivas complementações, salvo se expressamente disposto '
                      'de forma diferente neste TERMO;\n'),
              _text('2. DO OBJETO\n', ''),
              _text(
                  '2.1 ',
                  ' Este Termo de Uso apresenta as condições gerais aplicáveis ao uso do '
                      'Aplicativo Image Creator oferecidos pela Frisk.\n'),
              _text('3. FUNCIONAMENTO DO APLICATIVO\n', ''),
              _text(
                  '3.1 ',
                  ' O Aplicativo Image Creator possui áreas de conteúdo aberto para que o usuário acesse conteúdo e possa cadastrar '
                      'alguns dados pessoais, tais como: nome completo, e-mail, telefone, celular, profissão, inclusive outros dados para '
                      'divulgação de canais para contato, incluindo endereços de redes sociais e conteúdos livres.'),
              _text(
                  '   (i) ',
                  ' O usuário se responsabiliza pela precisão e veracidade dos dados informados e reconhece '
                      'que a inconsistência destes poderá implicar a impossibilidade de utilizar o Aplicativo.'),
              _text(
                  '   (ii) ',
                  ' O usuário assume inteira responsabilidade pelos dados informados e a boa utilização do Aplicativo, '
                      'isentando a Frisk de qualquer responsabilidade.'),
              _text(
                  '   (iii) ',
                  ' O usuário poderá, a qualquer momento, desinstalar o Aplicativo por sua conta, sendo que os dados informados '
                      'serão automaticamente excluídos de forma permanente.\n'),
              _text('4. PRIVACIDADE\n', ''),
              _text(
                  '4.1. ',
                  ' CONTEÚDOS ENVIADOS PELOS usuárioS:\n\n'
                      '   O Aplicativo permite o envio e/ou transmissão de conteúdos pelos usuários,'
                      'tais como imagens e mensagens, fotografias, obras audiovisuais, marcas, textos, etc. '
                      '(“Conteúdos”) para divulgação em áreas de conteúdo aberto do Aplicativo.\nNeste '
                      'caso, o usuário declara estar ciente e expressamente concordar que as informações cadastradas, '
                      'bem como quaisquer Conteúdos por ele enviados e/ou transmitidos pelo Aplicativo poderão ser acessados e visualizados '
                      'por quaisquer outros usuários, observadas as normas que dispõem sobre o sigilo bancário, sem que Frisk tenha qualquer '
                      'responsabilidade sobre tais Conteúdos.\n'),
              _text('4.2. ', ' INFORMAÇÕES DOS usuárioS\n'),
              _text('4.2.1. ',
                  ' Existem 02 (duas) formas de coleta de informações dos usuários (“Informações”):'),
              _text(
                  '    (i) ',
                  ' por meio do cadastro realizado pelo próprio usuário no Aplicativo, conforme item 3 e '
                      'subitens acima (“Funcionamento do Aplicativo”);'),
              _text(
                  '    (ii) ',
                  ' por meio do uso de cookies ou de outra tecnologia'
                      'que permita armazenar informações a respeito da navegação do usuário no Aplicativo'
                      '(“Registros de Navegação”).'),
              _text(
                  '4.2.2. ',
                  ' As Informações dos usuários são coletadas, armazenadas, tratadas, processadas e '
                      'utilizadas pela Frisk com as seguintes finalidades:'),
              _text('    (i) ',
                  ' desenvolver, manter e aperfeiçoar os recursos e funcionalidades do Aplicativo;'),
              _text('    (ii) ',
                  ' possibilitar o acesso e o uso dos recursos e funcionalidades do Aplicativo pelos usuários;'),
              _text(
                  '    (iii) ',
                  ' analisar o desempenho do Aplicativo, medir a audiência do Aplicativo,'
                      'verificar os hábitos de navegação dos usuários no Aplicativo, a forma pela qual '
                      'chegaram na página do Aplicativo (por exemplo, através de links de outros sites, '
                      'buscadores ou diretamente pelo endereço), avaliar estatísticas relacionadas ao número de '
                      'acessos e uso do Aplicativo, seus recursos e funcionalidades;'),
              _text('    (iv) ',
                  ' análises relacionadas à segurança do Aplicativo, aperfeiçoamento e desenvolvimento de ferramentas antifraude;'),
              _text('    (v) ',
                  ' melhorar as experiências de navegação dos usuários no Aplicativo;'),
              _text(
                  '    (vi) ',
                  ' permitir o fornecimento de serviços mais personalizados e adequados às necessidades dos'
                      'usuários, tais como páginas de perfil, atualizações, conteúdos e anúncios relevantes;'),
              _text('    (vii) ',
                  ' permitir a comunicação entre os usuários e a Frisk, inclusive mediante o envio e recebimento de e-mails;'),
              _text('    (viii) ',
                  ' identificar os perfis, hábitos e necessidades para eventuais ofertas de serviços e estratégias da Frisk.'),
              _text(
                  '4.2.3. ',
                  ' A Frisk preserva a privacidade dos usuários e não compartilha seus dados e'
                      'informações com terceiros, salvo mediante consentimento do próprio usuário, por força de lei ou ordem judicial.'),
              _text(
                  '4.2.4. ',
                  ' O usuário está ciente e autoriza que os seus Registros de Navegação no Site e/ou '
                      'Aplicativo sejam fornecidos pela Frisk a seus respectivos parceiros ou contratados para '
                      'prestar qualquer serviço relativo ao Aplicativo, sem indicação individualizada do '
                      'usuário que permita sua identificação e para as finalidades previstas no item 3.2.2.\n'),
              _text('5. COOKIES\n', ''),
              _text(
                  '5.1. ',
                  ' Os cookies são pequenos arquivos que podem ou não ser adicionados no seu Terminal e'
                      'que permitem armazenar e reconhecer dados da sua navegação.'),
              _text('5.2. ',
                  ' Em sua navegação no Aplicativo, poderão ser utilizados 04 (quatro) tipos de cookies:'),
              _text(
                  '    (i) ',
                  ' Cookies de Autenticação: servem para reconhecer um determinado usuário, possibilitando '
                      'o acesso e utilização do Aplicativo com conteúdo e/ou serviços restritos e'
                      'proporcionando experiências de navegação mais personalizadas.'),
              _text(
                  '    (ii) ',
                  ' Cookies de Segurança: são utilizados para ativar recursos de segurança dos Sites e/ou '
                      'Aplicativos, com a finalidade de auxiliar o monitoramento e/ou detecção de atividades '
                      'maliciosas ou vedadas por estes Termos de Uso e Política de Privacidade, bem como de '
                      'proteger as informações do usuário do acesso por terceiros não autorizados.'),
              _text(
                  '    (iii) ',
                  ' Cookies de Pesquisa, Análise e Desempenho: a finalidade deste tipo de cookie é ajudar a '
                      'entender o desempenho do Aplicativo, medir a audiência do Aplicativo, '
                      'verificar os hábitos de navegação dos usuários no Aplicativo, bem como a forma pela '
                      'qual chegou na página do Aplicativo (por exemplo, através de links de outros sites, '
                      'buscadores ou diretamente pelo endereço).'),
              _text(
                  '    (iv) ',
                  ' Cookies de Propaganda: são usados para apresentar publicidade relevante ao usuário, '
                      'tanto dentro quanto fora do Aplicativo ou em sites de parceiros, bem como para saber '
                      'se os usuários que visualizaram a publicidade visitaram o Aplicativo após terem visto '
                      'a publicidade. Os Cookies de Propaganda também podem ser utilizados para lembrar eventuais '
                      'pesquisas realizadas pelos usuários no Aplicativo e, com base nas pesquisas realizadas '
                      'pelos usuários no Aplicativo, apresentar aos usuários anúncios relacionados aos seus interesses.'),
              _text(
                  '5.3. ',
                  ' Para os fins descritos no item 4.2, a Frisk poderá coletar, armazenar, tratar, processar e'
                      'utilizar as seguintes informações a respeito da navegação do usuário no Aplicativo,'
                      'que integram os “Registros de Navegação”:'),
              _text('    (i) ',
                  ' Galeria de fotos – permite acessar a galeria de fotos para efetuar upload de arquivos para compor a '
                      'imagem no Aplicativo;'),
              _text('    (ii) ',
                  ' Câmera – permite usar a câmera para tirar foto para compor a imagem no Aplicativo;'),
              _text(
                  '    (iii) ',
                  ' Conta e Contatos - Permissão necessária para funcionalidade compartilhar o aplicativo com '
                      'amigos, para que o Aplicativo possa acessar contas pessoais;'),
              _text(
                  '    (iv) ',
                  ' Armazenamento local - Permite que a aplicação grave arquivos no celular. Utilizamos para '
                      'salvar as informações cadastradas;'),
              _text(
                  '    (v) ', ' Sistema operacional utilizado pelo usuário;'),
              _text('    (vi) ', ' Navegador e suas respectivas versões;'),
              _text('    (vii) ', ' Resolução de tela;'),
              _text('    (viii) ',
                  ' Dart, Kotlin, Swift (linguagens de programação);'),
              _text('    (ix) ',
                  ' Código ID (IMEI) do aparelho mobile pelo qual o usuário acessou o Aplicativo;'),
              _text('    (x) ',
                  ' Informações referentes à data e hora de uso do Aplicativo por um determinado usuário, a partir de um ID do aparelho;'),
              _text('    (xi) ',
                  ' Informações referentes às quantidades e localização de toques e tentativas de uso do Aplicativo, bem como de páginas acessadas pelo usuário.\n'),
              _text(
                  '5.4. ',
                  ' O usuário poderá desabilitar o armazenamento local de dados por meio das opções de configuração do seu'
                      'aparelho. Contudo, ao decidir pela proibição, o usuário está ciente e reconhece que é possível que o Aplicativo '
                      'não desempenhe todas as suas funcionalidades.\n'),
              _text('6. RESPONSABILIDADES\n', ''),
              _text(
                  '6.1. ',
                  ' O usuário não poderá praticar as seguintes ações com relação ao Aplicativo, no'
                      'todo ou em parte, sem prejuízo de outras que sejam consideradas ilegais, contrariem a ordem'
                      'pública ou atentem contra a moral e os bons costumes:'),
              _text(
                  '    (i) ',
                  'prática de quaisquer atos ilícitos e/ou violação da legislação vigente, inclusive '
                      'das disposições da Lei 9.613/98 e da Lei 12.846/13;'),
              _text(
                  '    (ii) ',
                  'Utilizar o Aplicativo e/ou qualquer conteúdo dele constante, no todo ou em parte, '
                      'sob qualquer meio ou forma, com propósito diverso daquele a que este se destina e de forma '
                      'diversa da prevista neste TERMO, inclusive divulgando, a qualquer título, a terceiros que não '
                      'tenham ou não devam ter acesso ao Aplicativo;'),
              _text(
                  '    (iii) ',
                  'Apagar, deturpar, corromper, alterar, editar, adaptar, transmitir ou de qualquer forma '
                      'modificar, sob qualquer meio ou forma, no todo ou em parte, o Aplicativo, e/ou qualquer conteúdo dele constante;'),
              _text(
                  '    (iv) ',
                  'Fazer publicidade ou marketing associando sua imagem a Frisk, ou a qualquer empresa '
                      'afiliada, controlada, coligada ou pertencente ao seu grupo econômico, para qualquer divulgação dos dados '
                      'contidos neste site, bem como de suas marcas, recomendamos o contato via e-mail com salvadorfrisco70@gmail.com;'),
              _text(
                  '    (v) ',
                  'Carregar, enviar e/ou transmitir qualquer conteúdo de cunho erótico, pornográfico, obsceno, '
                      'difamatório ou calunioso ou que façam apologia ao crime, uso de drogas, consumo de bebidas '
                      'alcoólicas ou de produtos fumígenos, violência física ou moral;'),
              _text(
                  '    (vi) ',
                  'Carregar, enviar e/ou transmitir qualquer conteúdo que promova ou incite o preconceito '
                      '(inclusive de origem, raça, sexo, cor, orientação sexual e idade) ou qualquer forma de '
                      'discriminação, bem como o ódio ou atividades ilegais;'),
              _text('    (vii) ',
                  'Ameaçar, coagir, ou causar constrangimento físico ou moral aos demais usuários;'),
              _text(
                  '    (viii) ',
                  'Realizar atos que causem ou propiciem a contaminação ou prejudiquem quaisquer '
                      'equipamentos da Frisk, de suas empresas e/ou de terceiros, inclusive por meio de vírus, '
                      'trojans, malware, worm, bot, backdoor, spyware, rootkit, ou por quaisquer outros dispositivos '
                      'que venham a ser criados;'),
              _text(
                  '    (ix) ',
                  'Praticar quaisquer atos em relação ao Aplicativo, direta ou indiretamente, no todo '
                      'ou em parte, que possam causar prejuízo à Frisk, a qualquer usuário e/ou a quaisquer terceiros;'),
              _text('6.2. ', 'O usuário é exclusivamente responsável:'),
              _text('    (i) ',
                  'Por todos e quaisquer atos ou omissões por ele realizados no ambiente do Aplicativo;'),
              _text(
                  '    (ii) ',
                  'Pela reparação de todos e quaisquer danos, diretos ou indiretos, que sejam causados '
                      'à Frisk, a qualquer outro usuário, ou, ainda, a qualquer terceiro, inclusive em virtude do '
                      'descumprimento do disposto neste TERMO. Sem prejuízo de outras medidas, '
                      'a Frisk poderá, por si ou por terceiros, a qualquer tempo, a seu exclusivo critério, sem '
                      'necessidade de qualquer aviso ou notificação prévia, suspender o acesso ao Aplicativo '
                      'de qualquer usuário, a qualquer tempo, caso este descumpra qualquer disposição '
                      'deste TERMO e demais políticas do Aplicativo ou da legislação vigente aplicável.'),
              _text('6.3. ', 'Em nenhuma hipótese, a Frisk será responsável:'),
              _text(
                  '    (i) ',
                  'Pelo pagamento de custos ou danos, inclusive danos diretos, indiretos, específicos, acidentais '
                      'ou emergentes, decorrentes do acesso ou uso, impossibilidade de acesso ou uso deste Site e/ou '
                      'Aplicativo ou de alguma de suas funções ou partes, inclusive com o fim de consultar ou baixar '
                      'informações, dados, textos, imagens ou outros materiais acessíveis por meio deste Aplicativo;'),
              _text('    (ii) ',
                  'Por qualquer ato ou omissão realizado e/ou dano causado pelo usuário neste Site e/ou Aplicativo;'),
              _text(
                  '    (iii) ',
                  'Pela instalação no equipamento do usuário ou de terceiros, de vírus, trojans, malware, '
                      'worm, bot, backdoor, spyware, rootkit, ou de quaisquer outros dispositivos que venham a ser '
                      'criados, em decorrência da navegação na Internet pelo usuário.'),
              _text(
                  '    (iv) ',
                  'Pelo uso indevido por qualquer usuário ou terceiros do Aplicativo, no todo ou em '
                      'parte, por qualquer meio ou forma, incluindo, mas não se limitando à reprodução e/ou '
                      'divulgação em quaisquer meios;'),
              _text('    (v) ',
                  'Pela suspensão, interrupção ou remoção do Aplicativo.'),
              _text(
                  '    (vi) ',
                  'por qualquer dano direto, indireto, acidental, excepcional ou resultante do uso ou inaptidão '
                      'do desfrute dos seus serviços, ou pelo custo da aquisição de serviços substitutos.'),
              _text(
                  '6.4. ',
                  'Fica certo desde já que a Frisk não será responsabilizada pelo não funcionamento do aplicativo '
                      'decorrente de falha ou interrupção de qualquer serviço de telecomunicação, conexão à internet, '
                      'provedor de acesso à internet ou de qualquer outro provedor de comunicações, caso fortuito, força '
                      'maior ou de qualquer outra falha ou problema não atribuíveis à Frisk;'),
              _text(
                  '6.7. ',
                  'A responsabilidade de fornecimento da prestação do serviço é do usuário, sendo certo que o '
                      'Aplicativo apenas funciona como o canal digital de divulgação (publicidade).\n'),
              _text('7. PROPRIEDADE INTELECTUAL\n', ''),
              _text(
                  '7.1. ',
                  'Pertencem à Frisk todos e quaisquer direitos intelectuais sobre o Aplicativo, '
                      'incluindo, mas não se limitando a:'),
              _text(
                  '    (i) ',
                  'Todo e qualquer software, aplicativo ou funcionalidade empregado pela Frisk para '
                      'manter e melhorar o funcionamento do Aplicativo;'),
              _text('    (ii) ', 'Identidade visual do Aplicativo; e'),
              _text('    (iii) ',
                  'Todo e qualquer conteúdo criado e produzido exclusivamente pela Frisk, por si ou por terceiros.\n'),
              _text('8. DISPOSIÇÕES GERAIS.\n', ''),
              _text('8.1 ',
                  'Os links deste Aplicativo para outros sites são fornecidos exclusivamente para sua informação e conveniência.'),
              _text('8.2 ',
                  'A Frisk não assume nenhuma responsabilidade por nenhum site cadastradon este Aplicativo.'),
              _text(
                  '8.3 ',
                  'Um link deste Aplicativo para outro site não constitui, necessariamente, uma '
                      'recomendação, patrocínio, aprovação, propaganda ou oferta.'),
              _text(
                  '8.4 ',
                  'A tolerância quanto ao eventual descumprimento de quaisquer das disposições '
                      'deste TERMO deste Aplicativo por qualquer usuário não constituirá renúncia ao '
                      'direito de exigir o cumprimento da obrigação.'),
              _text('8.5. ',
                  'A Frisk poderá, a qualquer tempo, a seu exclusivo critério e sem necessidade de qualquer aviso prévio:'),
              _text('    (i) ', 'Tirar o Aplicativo do ar;'),
              _text('    (ii) ',
                  'Alterar e/ou atualizar no todo ou em parte este TERMO'),
              _text('    (iii) ',
                  'Alterar e/ou atualizar as políticas presentes no Aplicativo,'),
              _text(
                  '8.6. ',
                  'A Frisk reserva a si o direito de reexaminar e corrigir os termos e condições desse '
                      'acordo a qualquer momento. Qualquer correção será obrigatória e válida imediatamente após a '
                      'postagem do acordo modificado em nosso Aplicativo. A continuidade do uso do Aplicativo '
                      'implica em concordância com qualquer alteração nos termos e condições e deverá ser '
                      'integralmente observada pelos usuários.'),
              _text(
                  '8.7. ',
                  'As marcas registradas, nomes, logotipos e marcas de serviços mostrados são legalmente, '
                      'reconhecidos ou não, do proprietário. Nada contido nesse site deve ser entendido como uma '
                      'forma de conceder licença ou direito de usar qualquer marca registrada sem a autorização prévia '
                      'escrita do dono. O conteúdo textual apresentado nesse site é propriedade de seu respectivo autor '
                      'e não pode ser reproduzido total ou parcialmente sem sua expressa permissão escrita.'),
              _text(
                  '8.8. ',
                  ' O usuário está ciente e concorda com a coleta, armazenamento, tratamento, '
                      'processamento e uso das Informações enviadas e/ou transmitidas pelo usuário nos termos aqui estabelecidos.'),
              _text(
                  '8.9. ',
                  ' A Frisk poderá, a qualquer momento, alterar as disposições constantes neste termo, se '
                      'comprometendo a dar a devida publicidade às modificações efetivadas mediante a '
                      'disponibilização de avisos e alertas no Aplicativo.'),
              _text(
                  '8.10. ',
                  ' A Frisk poderá divulgar notificações ou mensagens através do Aplicativo para informar '
                      'os usuários a respeito de mudanças nos serviços ou no Termo de Uso, Navegação, Política, '
                      'Privacidade e Compartilhamento, ou outros assuntos relevantes.'),
              _text(
                  '',
                  'Este TERMO é regido de acordo com a legislação brasileira. Quaisquer disputas ou '
                      'controvérsias oriundas de quaisquer atos praticados no âmbito do Aplicativos pelos '
                      'usuários, inclusive com relação ao descumprimento deste TERMO, e/ou demais políticas do '
                      'Aplicativo, serão processadas na Comarca da Capital do Estado de São Paulo.\n'),
              _text(
                  'DECLARO QUE AO UTILIZAR O APLICATIVO LI E CONCORDO COM O CONTEÚDO DO TERMO DE USO E POLÍTICA DE PRIVACIDADE\n',
                  ''),
            ],
          ),
        ),
      ),
    );
  }

  _text(txtBold, txtNormal, {color: Colors.black}) {
    var text = Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: color),
          children: [
            TextSpan(
              text: txtBold,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: txtNormal,
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
    return text;
  }
}
