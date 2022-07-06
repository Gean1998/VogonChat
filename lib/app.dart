import 'package:flutter/material.dart';
import 'package:vogon_chat/app_router.dart';
import 'package:vogon_chat/core/theme/tema_light.dart';
import 'package:vogon_chat/rotas.dart';

import 'core/theme/tema_light.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vogon Chat',
      debugShowCheckedModeBanner: false,
      theme: temaLight(),
      initialRoute: rotaSplashScreen,
      navigatorKey: AppRouter.chaveDeNavegacao,
      onGenerateRoute: AppRouter.gerarRotas,
    );
  }
}
