import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
import 'package:vogon_chat/app_store.dart';
import 'package:vogon_chat/pages/chat/models/mensagem.dart';
import 'package:vogon_chat/pages/chat/services/mensagens_service.dart';
import 'package:vogon_chat/pages/home/presentation/home_store.dart';
part 'chat_store.g.dart';

class ChatStore = _ChatStoreBase with _$ChatStore;

abstract class _ChatStoreBase with Store {
  final service = MensagensService();
  final appStore = GetIt.I.get<AppStore>();

  @observable
  TextEditingController mensagemController = TextEditingController(text: '');

  var inicializado = false;

  @observable
  ObservableList<MensagemModel> mensagens = ObservableList<MensagemModel>();

  @observable
  ScrollController scrollController = ScrollController();

  GlobalKey<AnimatedListState>? msgListKey;

  @action
  Future init(GlobalKey<AnimatedListState> key) async {
    msgListKey = key;

    if (inicializado) {
      return mensagens;
    }

    mensagens = ObservableList<MensagemModel>();
    await _obterMensagens();
    _ordenarListaMensagens();

    final ultimaDataHora =
        mensagens.isNotEmpty ? mensagens.last.dataHoraEnvio : null;
    service.escutarNovasmensagens(
      this as ChatStore,
      ultimaDataHora,
      appStore.usuario,
      appStore.contato,
    );

    inicializado = true;
    return mensagens;
  }

  @action
  Future enviarMensagem() async {
    if (mensagemController.text.isNotEmpty) {
      await service.enviarMensagem(
        appStore.usuario,
        appStore.contato,
        MensagemModel(
          id: const Uuid().v4(),
          mensagem: mensagemController.text,
          dataHoraEnvio: DateTime.now(),
          nomeEnvio: appStore.usuario,
        ),
      );
      mensagemController.text = '';
    }
  }

  @action
  Future _obterMensagens() async {
    final store = GetIt.I.get<HomeStore>();
    if (store.dadosContatos.isNotEmpty) {
      final contato =
          store.dadosContatos.firstWhere((e) => e.nome == appStore.contato);
      contato.mensagens?.forEach((e) => mensagens.add(e));
    }
  }

  void _ordenarListaMensagens() {
    if (mensagens.isNotEmpty) {
      mensagens.sort((x, y) => x.dataHoraEnvio!.compareTo(y.dataHoraEnvio!));
    }
  }

  @action
  bool mensagemEhDoUsuario(String id) {
    if (mensagens.isNotEmpty) {
      final ix = mensagens.indexWhere((e) => e.id == id);
      if (ix > -1) {
        return mensagens[ix].nomeEnvio == appStore.usuario;
      } else {
        return false;
      }
    }

    return false;
  }

  void inserirMensagem(MensagemModel mensagemModel) {
    if (mensagens.isNotEmpty) {
      int ix = mensagens.indexWhere((e) => e.id == mensagemModel.id);
      if (ix > -1) {
        mensagens.removeAt(ix);
      }
    }

    mensagens.add(mensagemModel);
    _ordenarListaMensagens();
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
    msgListKey!.currentState?.insertItem(
      mensagens.indexOf(mensagemModel),
      duration: const Duration(milliseconds: 500),
    );
  }
}
