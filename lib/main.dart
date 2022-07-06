import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vogon_chat/app_store.dart';

import 'app.dart';
import 'pages/home/presentation/home_store.dart';

void main() {
  runApp(const App());
  GetIt.I.registerSingleton(() => AppStore());
  GetIt.I.registerSingleton(() => HomeStore());
}
