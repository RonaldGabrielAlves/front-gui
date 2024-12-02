import 'package:flutter/material.dart';
import '../widget/bottom_navigation_widget.dart';

class AboutApp extends StatefulWidget {
  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
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
          'Sobre o App',
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
O Achados e Perdidos Unifor é uma solução digital criada para facilitar a vida dos membros da comunidade acadêmica da Universidade de Fortaleza (Unifor). O aplicativo tem como objetivo conectar estudantes, professores e colaboradores para que possam registrar e localizar itens perdidos ou encontrados dentro do campus de forma prática e eficiente.

O que o aplicativo oferece?

• Registro de itens perdidos: Descreva o que você perdeu, incluindo detalhes como cor, tamanho e localização aproximada.
• Registro de itens encontrados: Compartilhe informações sobre objetos que encontrou, ajudando o dono a recuperá-los.
• Conexão segura entre usuários: Comunique-se diretamente com outros membros da comunidade para combinar a devolução dos itens.
• Interface simples e intuitiva: Encontre ou cadastre itens rapidamente, sem complicações.

Por que usar o Achados e Perdidos Unifor?

• Comodidade: Não é mais necessário se deslocar até pontos físicos para registrar ou procurar itens. Tudo pode ser feito de forma digital e instantânea.
• Colaboração comunitária: Contribuímos para fortalecer a união e o cuidado mútuo entre os membros da Unifor.
• Segurança: O acesso é restrito aos usuários com e-mail institucional, garantindo um ambiente confiável.

Quem pode usar?

O aplicativo é exclusivo para estudantes, professores e colaboradores da Unifor, promovendo uma rede interna de ajuda e suporte.

Nosso compromisso

O Achados e Perdidos Unifor foi desenvolvido pensando em otimizar o dia a dia da comunidade acadêmica, oferecendo uma plataforma segura e acessível para todos. Juntos, podemos garantir que a perda de um item não seja motivo de estresse e que encontrar algo perdido seja mais simples do que nunca.

Baixe agora e ajude a construir uma comunidade mais conectada e solidária!
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
