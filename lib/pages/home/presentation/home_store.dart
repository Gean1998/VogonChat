import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:vogon_chat/app_store.dart';
import 'package:vogon_chat/pages/chat/services/mensagens_service.dart';
import 'package:vogon_chat/pages/home/models/contato.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final appStore = GetIt.I.get<AppStore>();
  final service = MensagensService();

  @observable
  ObservableList<String> contatos = ObservableList<String>();

  @observable
  List<ContatoModel> dadosContatos = [];

  TextEditingController adicionarContatoController =
      TextEditingController(text: '');

  @action
  Future init() async {
    contatos = ObservableList();
    dadosContatos = [];

    dadosContatos = await service.obterMensagensFirebase(appStore.usuario);
    dadosContatos.forEach((e) {
      contatos.add(e.nome!);
    });

    return dadosContatos;
  }

  @action
  void adicionarNovoContato() {
    var nome = adicionarContatoController.text;
    contatos.add(nome);
    appStore.contato = nome;
  }
}
