import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../app_store.dart';
import 'chat_store.dart';

final appStore = GetIt.I<AppStore>();
final store = ChatStore();

var globalKey = GlobalKey<AnimatedListState>();

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário: ${appStore.usuario}'),
      ),
      body: FutureBuilder(
        future: store.init(globalKey),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, size: 32.0),
                    Text(
                      'Contato: ${appStore.contato}',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: AnimatedList(
                            controller: store.scrollController,
                            key: store.msgListKey,
                            initialItemCount: store.mensagens.length,
                            itemBuilder: (_, ix, animation) {
                              if (store.mensagens.isNotEmpty &&
                                  ix < store.mensagens.length) {
                                final mensagem = store.mensagens.elementAt(ix);
                                final mensagemEhDoUsuario =
                                    store.mensagemEhDoUsuario(mensagem.id!);

                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(-1, 0),
                                      end: const Offset(0, 0),
                                    ).animate(animation),
                                    child: Container(
                                      width: double.maxFinite,
                                      margin: mensagemEhDoUsuario
                                          ? const EdgeInsets.only(
                                              left: 100.0,
                                              right: 8.0,
                                              bottom: 4.0,
                                              top: 4.0,
                                            )
                                          : const EdgeInsets.only(
                                              left: 8.0,
                                              right: 100.0,
                                              bottom: 4.0,
                                              top: 4.0,
                                            ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                        vertical: 4.0,
                                      ),
                                      decoration: BoxDecoration(
                                        color: mensagemEhDoUsuario
                                            ? Colors.red
                                            : Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Text(
                                        mensagem.mensagem!,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: store.mensagemController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  await store.enviarMensagem();
                                  FocusScope.of(context).unfocus();
                                },
                                icon: const Icon(Icons.send),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Ocorreu um erro...'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
