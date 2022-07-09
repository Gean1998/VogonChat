import 'package:vogon_chat/pages/chat/models/mensagem.dart';

class ContatoModel {
  ContatoModel({
    this.nome,
    this.mensagens,
  });

  String? nome;
  List<MensagemModel>? mensagens;
}
