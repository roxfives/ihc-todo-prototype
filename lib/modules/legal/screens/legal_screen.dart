import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_html/flutter_html.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class LegalScreen extends StatefulWidget {
  const LegalScreen({Key? key}) : super(key: key);

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        title: Text(AppLocalizations.of(context)!.legal_title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Html(
                      data:
                          "<!DOCTYPE HTML PUBLIC \"-//W3C\/\/DTD HTML 4.01 Transitional\/\/EN\"><html><head><META http-equiv=\"Content-Type\" content=\"text\/html; charset=utf-8\"><style><\/style><\/head><body><p><strong>Termos e condições gerais de uso aplicativo Todozi<\/strong><\/p><p>Os serviços do Todozi são fornecidos pela pessoa jurídica OU física com a seguinte Razão Social\/nome: Todozi, com nome fantasia Todozi, inscrito no CNPJ\/CPF sob o nº 00.236.844\/0001-36, titular da propriedade intelectual sobre software, website, aplicativos, conteúdos e demais ativos relacionados à plataforma Todozi.<\/p><p><strong>1. Do objeto<\/strong><\/p><p>A plataforma visa licenciar o uso de seu software, website, aplicativos e demais ativos de propriedade intelectual, fornecendo ferramentas para auxiliar e dinamizar o dia a dia dos seus usuários.<\/p><p>A plataforma caracteriza-se pela prestação do seguinte serviço: aplicativo.<\/p><p>A plataforma realiza a venda à distância por meio eletrônico dos seguintes produtos ou serviços: aplicativo.<\/p><p><strong>2. Da aceitação<\/strong><\/p><p>O presente Termo estabelece obrigações contratadas de livre e espontânea vontade, por tempo indeterminado, entre a plataforma e as pessoas físicas ou jurídicas, usuárias do aplicativo.<\/p><p>Ao utilizar a plataforma o usuário aceita integralmente as presentes normas e compromete-se a observá-las, sob o risco de aplicação das penalidades cabíveis.<\/p><p>A aceitação do presente instrumento é imprescindível para o acesso e para a utilização de quaisquer serviços fornecidos pela empresa. Caso não concorde com as disposições deste instrumento, o usuário não deve utilizá-los.<\/p><p><strong>3. Do acesso dos usuários<\/strong><\/p><p>Serão utilizadas todas as soluções técnicas à disposição do responsável pela plataforma para permitir o acesso ao serviço 24 (vinte e quatro) horas por dia, 7 (sete) dias por semana. No entanto, a navegação na plataforma ou em alguma de suas páginas poderá ser interrompida, limitada ou suspensa para atualizações, modificações ou qualquer ação necessária ao seu bom funcionamento.<\/p><p><strong>4. Do cadastro<\/strong><\/p><p>O acesso às funcionalidades da plataforma exigirá a realização de um cadastro prévio e, a depender dos serviços ou produtos escolhidos, o pagamento de determinado valor.<\/p><p>Ao se cadastrar o usuário deverá informar dados completos, recentes e válidos, sendo de sua exclusiva responsabilidade manter referidos dados atualizados, bem como o usuário se compromete com a veracidade dos dados fornecidos.<\/p><p>O usuário se compromete a não informar seus dados cadastrais e\/ou de acesso à plataforma a terceiros, responsabilizando-se integralmente pelo uso que deles seja feito.<\/p><p>Menores de 18 anos e aqueles que não possuírem plena capacidade civil deverão obter previamente o consentimento expresso de seus responsáveis legais para utilização da plataforma e dos serviços ou produtos, sendo de responsabilidade exclusiva dos mesmos o eventual acesso por menores de idade e por aqueles que não possuem plena capacidade civil sem a prévia autorização.<\/p><p>Mediante a realização do cadastro o usuário declara e garante expressamente ser plenamente capaz, podendo exercer e usufruir livremente dos serviços e produtos.<\/p><p>O usuário deverá fornecer um endereço de e-mail válido, através do qual o site realizará todas as comunicações necessárias.<\/p><p>Após a confirmação do cadastro, o usuário possuirá um login e uma senha pessoal, a qual assegura ao usuário o acesso individual à mesma. Desta forma, compete ao usuário exclusivamente a manutenção de referida senha de maneira confidencial e segura, evitando o acesso indevido às informações pessoais.<\/p><p>Toda e qualquer atividade realizada com o uso da senha será de responsabilidade do usuário, que deverá informar prontamente a plataforma em caso de uso indevido da respectiva senha.<\/p><p>Não será permitido ceder, vender, alugar ou transferir, de qualquer forma, a conta, que é pessoal e intransferível.<\/p><p>Caberá ao usuário assegurar que o seu equipamento seja compatível com as características técnicas que viabilize a utilização da plataforma e dos serviços ou produtos.<\/p><p>O usuário poderá, a qualquer tempo, requerer o cancelamento de seu cadastro junto ao aplicativo Todozi. O seu descadastramento será realizado o mais rapidamente possível, desde que não sejam verificados débitos em aberto.<\/p><p>O usuário, ao aceitar os Termos e Política de Privacidade, autoriza expressamente a plataforma a coletar, usar, armazenar, tratar, ceder ou utilizar as informações derivadas do uso dos serviços, do site e quaisquer plataformas, incluindo todas as informações preenchidas pelo usuário no momento em que realizar ou atualizar seu cadastro, além de outras expressamente descritas na Política de Privacidade que deverá ser autorizada pelo usuário.<\/p><p><strong>6. Dos preços<\/strong><\/p><p>A plataforma se reserva no direito de reajustar unilateralmente, a qualquer tempo, os valores dos serviços ou produtos sem consulta ou anuência prévia do usuário.<\/p><p>Os valores aplicados são aqueles que estão em vigor no momento do pedido.<\/p><p>Os preços são indicados em reais e não incluem as taxas de entrega, as quais são especificadas à parte e são informadas ao usuário antes da finalização do pedido.<\/p><p>Na contratação de determinado serviço ou produto, a plataforma poderá solicitar as informações financeiras do usuário, como CPF, endereço de cobrança e dados de cartões. Ao inserir referidos dados o usuário concorda que sejam cobrados, de acordo com a forma de pagamento que venha a ser escolhida, os preços então vigentes e informados quando da contratação. Referidos dados financeiros poderão ser armazenadas para facilitar acessos e contratações futuras.<\/p><p><strong>9. Do suporte<\/strong><\/p><p>Em caso de qualquer dúvida, sugestão ou problema com a utilização da plataforma, o usuário poderá entrar em contato com o suporte, através do email <a href=\"mailto:naoexiste@todozi.com\" target=\"_blank\" rel=\"noreferrer\">naoexiste@todozi.com<\/a>.<\/p><p>Estes serviços de atendimento ao usuário estarão disponíveis nos seguintes dias e horários: nunca.<\/p><p><strong>10. Das responsabilidades<\/strong><\/p><p>É de responsabilidade do usuário:<\/p><p>a) defeitos ou vícios técnicos originados no próprio sistema do usuário;<\/p><p>b) a correta utilização da plataforma, dos serviços ou produtos oferecidos, prezando pela boa convivência, pelo respeito e cordialidade entre os usuários;<\/p><p>c) pelo cumprimento e respeito ao conjunto de regras disposto nesse Termo de Condições Geral de Uso, na respectiva Política de Privacidade e na legislação nacional e internacional;<\/p><p>d) pela proteção aos dados de acesso à sua conta\/perfil (login e senha).<\/p><p>É de responsabilidade da plataforma Todozi:<\/p><p>a) indicar as características do serviço ou produto;<\/p><p>b) os defeitos e vícios encontrados no serviço ou produto oferecido desde que lhe tenha dado causa;<\/p><p>c) as informações que foram por ele divulgadas, sendo que os comentários ou informações divulgadas por usuários são de inteira responsabilidade dos próprios usuários;<\/p><p>d) os conteúdos ou atividades ilícitas praticadas através da sua plataforma.<\/p><p>A plataforma não se responsabiliza por links externos contidos em seu sistema que possam redirecionar o usuário ao ambiente externo a sua rede.<\/p><p>Não poderão ser incluídos links externos ou páginas que sirvam para fins comerciais ou publicitários ou quaisquer informações ilícitas, violentas, polêmicas, pornográficas, xenofóbicas, discriminatórias ou ofensivas.<\/p><p><strong>11. Dos <\/strong><strong>direitos autorais<\/strong><\/p><p>O presente Termo de Uso concede aos usuários uma licença não exclusiva, não transferível e não sublicenciável, para acessar e fazer uso da plataforma e dos serviços e produtos por ela disponibilizados.<\/p><p>A estrutura do site ou aplicativo, as marcas, logotipos, nomes comerciais, layouts, gráficos e design de interface, imagens, ilustrações, fotografias, apresentações, vídeos, conteúdos escritos e de som e áudio, programas de computador, banco de dados, arquivos de transmissão e quaisquer outras informações e direitos de propriedade intelectual da razão social Todozi, observados os termos da Lei da Propriedade Industrial (Lei nº 9.279\/96), Lei de Direitos Autorais (Lei nº 9.610\/98) e Lei do Software (Lei nº 9.609\/98), estão devidamente reservados.<\/p><p>Este Termos de Uso não cede ou transfere ao usuário qualquer direito, de modo que o acesso não gera qualquer direito de propriedade intelectual ao usuário, exceto pela licença limitada ora concedida.<\/p><p>O uso da plataforma pelo usuário é pessoal, individual e intransferível, sendo vedado qualquer uso não autorizado, comercial ou não-comercial. Tais usos consistirão em violação dos direitos de propriedade intelectual da razão social Todozi, puníveis nos termos da legislação aplicável.<\/p><p><strong>12. Das sanções<\/strong><\/p><p>Sem prejuízo das demais medidas legais cabíveis, a razão social Todozi poderá, a qualquer momento, advertir, suspender ou cancelar a conta do usuário:<\/p><p>a) que violar qualquer dispositivo do presente Termo;<\/p><p>b) que descumprir os seus deveres de usuário;<\/p><p>c) que tiver qualquer comportamento fraudulento, doloso ou que ofenda a terceiros.<\/p><p><strong>13. Da rescisão<\/strong><\/p><p>A não observância das obrigações pactuadas neste Termo de Uso ou da legislação aplicável poderá, sem prévio aviso, ensejar a imediata rescisão unilateral por parte da razão social Todozi e o bloqueio de todos os serviços prestados ao usuário.<\/p><p><strong>14. Das alterações<\/strong><\/p><p>Os itens descritos no presente instrumento poderão sofrer alterações, unilateralmente e a qualquer tempo, por parte de todos, para adequar ou modificar os serviços, bem como para atender novas exigências legais. As alterações serão veiculadas pelo aplicativo Todozi e o usuário poderá optar por aceitar o novo conteúdo ou por cancelar o uso dos serviços, caso seja assinante de algum serviço.<\/p><p><strong>15. Da política de privacidade<\/strong><\/p><p>Além do presente Termo, o usuário deverá consentir com as disposições contidas na respectiva Política de Privacidade a ser apresentada a todos os interessados dentro da interface da plataforma.<\/p><p><strong>16. Do foro<\/strong><\/p><p><strong>Para a solução de controvérsias decorrentes do presente instrumento será aplicado integralmente o Direito brasileiro.<\/strong><\/p><p><strong>Os eventuais litígios deverão ser apresentados no foro da comarca em que se encontra a sede da empresa.<\/strong><\/p><\/body><\/html>"
                          ),
          ),
        ),
      ),
    );
  }
}