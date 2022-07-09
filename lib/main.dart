import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vogon_chat/app_store.dart';

import 'app.dart';
import 'pages/home/presentation/home_store.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  GetIt.I.registerSingleton(AppStore());
  GetIt.I.registerSingleton(HomeStore());

  runApp(const App());

  final fbAuth = FirebaseAuth.instance;
  await fbAuth
      .signInWithEmailAndPassword(
          email: 'geancarlos482@gmail.com', password: '123456')
      .timeout(const Duration(seconds: 3));
}
