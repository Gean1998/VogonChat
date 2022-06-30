import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../app_store.dart';

final appStore = GetIt.I<AppStore>();

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário: ${appStore.usuario}'),
      ),
    );
  }
}
