import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../app_store.dart';
import 'chat_store.dart';

final appStore = GetIt.I<AppStore>();
final store = GetIt.I.get<ChatStore>();

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário: ${appStore.usuario}'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: store.mensagemController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              suffixIcon: IconButton(
                onPressed: () async {
                  await store.enviarMensagem();
                },
                icon: const Icon(Icons.send),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
