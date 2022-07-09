import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:vogon_chat/app_router.dart';
import 'package:vogon_chat/app_store.dart';
import 'package:vogon_chat/rotas.dart';

import 'home_store.dart';

final store = GetIt.I.get<HomeStore>();

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vogon Chat'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return SimpleDialog(
                  children: [
                    const Text('Adicionar Contato'),
                    TextFormField(
                      controller: store.adicionarContatoController,
                      decoration: const InputDecoration(
                        hintText: 'Nome do Contato',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        store.adicionarNovoContato();
                        Navigator.of(context).pop();
                      },
                      child: Text('Salvar'),
                    ),
                  ],
                );
              });
        },
      ),
      body: FutureBuilder(
        future: store.init(),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return Observer(
              builder: (_) {
                return ListView.builder(
                  itemCount: store.contatos.length,
                  itemBuilder: (_, ix) {
                    if (store.contatos.length > ix) {
                      var contato = store.contatos.elementAt(ix);
                      return ListTile(
                        title: Text(contato),
                        onTap: () {
                          GetIt.I.get<AppStore>().definirNomeContato(contato);
                          AppRouter.gotoPush(nomeRota: rotaChat);
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Ocorreu um erro...'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
