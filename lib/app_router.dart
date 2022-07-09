import 'package:flutter/material.dart';
import 'package:vogon_chat/pages/chat/presentation/chat_view.dart';
import 'package:vogon_chat/pages/home/presentation/home.dart';
import 'package:vogon_chat/pages/splash_screen/splash_screen.dart';

import 'rotas.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> chaveDeNavegacao =
      GlobalKey<NavigatorState>();

  static gotoPush({required String nomeRota}) {
    switch (nomeRota) {
      case rotaHome:
        chaveDeNavegacao.currentState!
            .pushNamedAndRemoveUntil(nomeRota, (Route<dynamic> route) => false);
        break;
      default:
        chaveDeNavegacao.currentState!.pushNamed(nomeRota);
        break;
    }
  }

  static Route<dynamic> gerarRotas(RouteSettings configuracoes) {
    switch (configuracoes.name) {
      case rotaHome:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case rotaSplashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case rotaChat:
        return MaterialPageRoute(builder: (_) => const ChatView());
      default:
        return MaterialPageRoute(
            builder: (_) => _rotaNaoEncontrada(configuracoes));
    }
  }

  static Scaffold _rotaNaoEncontrada(RouteSettings configuracoes) {
    return Scaffold(
      body: Center(
        child: Text('Rota ${configuracoes.name} não encontada!'),
      ),
    );
  }
}
