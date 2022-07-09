import 'package:firebase_database/firebase_database.dart';
import 'package:vogon_chat/core/helpers/datetime/formatos.dart';
import 'package:vogon_chat/pages/chat/models/mensagem.dart';
import 'package:vogon_chat/pages/chat/presentation/chat_store.dart';
import 'package:vogon_chat/pages/home/models/contato.dart';

class MensagensService {
  Future enviarMensagem(
    String nomeUsuario,
    String nomeContato,
    MensagemModel mensagem,
  ) async {
    //salvar mensagem do usuario
    final firebaseRef = FirebaseDatabase.instance
        .ref()
        .child('$nomeUsuario/chat/$nomeContato/${mensagem.id}');
    firebaseRef.set(mensagem.toJson());

    //salvar mensagem do contato
    final firebaseRefContato = FirebaseDatabase.instance
        .ref()
        .child('$nomeContato/chat/$nomeUsuario/${mensagem.id}');
    firebaseRefContato.set(mensagem.toJson());
  }

  Future<List<ContatoModel>> obterMensagensFirebase(String usuario) async {
    List<ContatoModel> dadosContatos = [];
    var mensagens = <MensagemModel>[];

    final fbRef = FirebaseDatabase.instance.ref('/$usuario/chat').orderByKey();
    final response = await fbRef.once();

    var contatoModel = ContatoModel();

    if (response.snapshot.value != null) {
      Map json = response.snapshot.value as Map;

      int i = 0;
      json.values.forEach((e) {
        Map msgData = e as Map;
        contatoModel.nome = json.keys.elementAt(i);

        msgData.values.forEach((data) {
          final json = Map<String, dynamic>.from(data);
          mensagens.add(MensagemModel.fromJson(json));
        });

        contatoModel.mensagens = mensagens;
        dadosContatos.add(contatoModel);

        contatoModel = ContatoModel();
        mensagens = [];
        i++;
      });
    }

    return dadosContatos;
  }

  Future escutarNovasmensagens(
    ChatStore store,
    DateTime? ultimaDataHoraEnvio,
    String? usuario,
    String? contato,
  ) async {
    var fbRef;

    if (ultimaDataHoraEnvio != null) {
      fbRef = FirebaseDatabase.instance
          .ref('/$usuario/chat/$contato')
          .orderByChild('data_hora_envio')
          .startAfter(FormatosDataHora.formatoMSG.format(ultimaDataHoraEnvio));
    } else {
      fbRef = FirebaseDatabase.instance
          .ref('/$usuario/chat/$contato')
          .orderByChild('data_hora_envio');
    }

    fbRef.onChildAdded.listen((evt) {
      final snapshot = evt.snapshot;
      if (snapshot.value == null) return;

      final json = Map<String, dynamic>.from(snapshot.value);
      store.inserirMensagem(MensagemModel.fromJson(json));
    });
  }
}
