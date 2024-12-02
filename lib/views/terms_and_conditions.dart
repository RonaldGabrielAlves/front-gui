import 'package:flutter/material.dart';
import '../widget/bottom_navigation_widget.dart';

class TermsAndConditions extends StatefulWidget {
  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = 0;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bottomHeight = kBottomNavigationBarHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 17, 197),
        title: Text(
          'Termos e CondiçÕes',
          style: TextStyle(
              fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight + 20, bottom: bottomHeight, left: 16, right: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '''
Bem-vindo(a) ao aplicativo Achados e Perdidos Unifor, desenvolvido para facilitar a comunicação entre os membros da comunidade acadêmica da Universidade de Fortaleza (Unifor) para o registro e recuperação de itens perdidos ou encontrados. Antes de usar este serviço, leia atentamente os seguintes termos e condições. Ao utilizar o aplicativo, você concorda integralmente com eles.

1. Objetivo do Aplicativo

1.1 O aplicativo tem como finalidade exclusiva conectar estudantes, professores e colaboradores da Unifor para reportar e localizar itens perdidos ou encontrados dentro do campus da universidade.
1.2 O serviço é restrito à comunidade acadêmica da Unifor e deve ser utilizado apenas para os fins mencionados.

2. Cadastro e Uso

2.1 O acesso ao aplicativo requer um cadastro utilizando e-mail institucional (@unifor.br).
2.2 Cada usuário é responsável por manter suas credenciais de login seguras e atualizadas.
2.3 Informações falsas ou inadequadas no cadastro poderão acarretar na suspensão ou exclusão da conta.

3. Responsabilidades do Usuário

3.1 Ao cadastrar um item como perdido ou encontrado, o usuário deve fornecer informações verdadeiras, detalhadas e relevantes.
3.2 É proibido o uso do aplicativo para qualquer propósito ilícito, como fraudes, vendas ou outras práticas comerciais.
3.3 O usuário é responsável por qualquer informação ou conteúdo enviado, incluindo imagens ou descrições, e garante que não infringe direitos de terceiros.

4. Funcionamento do Sistema

4.1 O aplicativo oferece as seguintes funcionalidades:
	•	Registro de itens perdidos.
	•	Registro de itens encontrados.
	•	Comunicação entre usuários para devolução dos itens.
4.2 O aplicativo não se responsabiliza pela veracidade das informações fornecidas pelos usuários.

5. Limitações de Responsabilidade

5.1 A Unifor e os desenvolvedores do aplicativo não são responsáveis por:
	•	Danos ou perdas decorrentes do uso do aplicativo.
	•	Qualquer disputa entre os usuários do aplicativo.
	•	O não retorno de itens perdidos.
5.2 O aplicativo atua apenas como intermediário e não garante a recuperação de itens.

6. Privacidade

6.1 As informações coletadas pelo aplicativo, incluindo dados pessoais, serão utilizadas exclusivamente para o funcionamento do serviço e não serão compartilhadas com terceiros.
6.2 Ao utilizar o aplicativo, você concorda com o uso de seus dados conforme a nossa Política de Privacidade.

7. Proibição de Uso Indevido

7.1 É estritamente proibido:
	•	Inserir informações falsas.
	•	Enviar mensagens abusivas ou ofensivas.
	•	Utilizar o aplicativo para fins não relacionados à proposta de achados e perdidos.

8. Suspensão e Encerramento

8.1 O descumprimento de qualquer item destes Termos e Condições poderá resultar na suspensão ou exclusão da conta do usuário.
8.2 A Unifor se reserva o direito de modificar, suspender ou encerrar o aplicativo a qualquer momento, sem aviso prévio.

9. Alterações nos Termos

9.1 Estes Termos e Condições podem ser atualizados periodicamente.
9.2 As atualizações serão informadas pelo aplicativo, e o uso contínuo após as alterações implicará na aceitação das novas condições.

10. Disposições Gerais

10.1 Este aplicativo é uma iniciativa interna e gratuita da Unifor.
10.2 Qualquer dúvida ou problema deve ser reportado através do suporte disponível no aplicativo ou pelo e-mail institucional fornecido.

Ao utilizar o aplicativo Achados e Perdidos Unifor, você concorda com estes Termos e Condições. Obrigado por colaborar com a comunidade acadêmica!
                ''',
                style: TextStyle(fontSize: 16, height: 1.5),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: StaticBottomNavigation(activeIcon: 4),
    );
  }
}
