// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore on _ChatStoreBase, Store {
  late final _$mensagemControllerAtom =
      Atom(name: '_ChatStoreBase.mensagemController', context: context);

  @override
  TextEditingController get mensagemController {
    _$mensagemControllerAtom.reportRead();
    return super.mensagemController;
  }

  @override
  set mensagemController(TextEditingController value) {
    _$mensagemControllerAtom.reportWrite(value, super.mensagemController, () {
      super.mensagemController = value;
    });
  }

  late final _$mensagensAtom =
      Atom(name: '_ChatStoreBase.mensagens', context: context);

  @override
  ObservableList<MensagemModel> get mensagens {
    _$mensagensAtom.reportRead();
    return super.mensagens;
  }

  @override
  set mensagens(ObservableList<MensagemModel> value) {
    _$mensagensAtom.reportWrite(value, super.mensagens, () {
      super.mensagens = value;
    });
  }

  late final _$scrollControllerAtom =
      Atom(name: '_ChatStoreBase.scrollController', context: context);

  @override
  ScrollController get scrollController {
    _$scrollControllerAtom.reportRead();
    return super.scrollController;
  }

  @override
  set scrollController(ScrollController value) {
    _$scrollControllerAtom.reportWrite(value, super.scrollController, () {
      super.scrollController = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_ChatStoreBase.init', context: context);

  @override
  Future<dynamic> init(GlobalKey<AnimatedListState> key) {
    return _$initAsyncAction.run(() => super.init(key));
  }

  late final _$enviarMensagemAsyncAction =
      AsyncAction('_ChatStoreBase.enviarMensagem', context: context);

  @override
  Future<dynamic> enviarMensagem() {
    return _$enviarMensagemAsyncAction.run(() => super.enviarMensagem());
  }

  late final _$_obterMensagensAsyncAction =
      AsyncAction('_ChatStoreBase._obterMensagens', context: context);

  @override
  Future<dynamic> _obterMensagens() {
    return _$_obterMensagensAsyncAction.run(() => super._obterMensagens());
  }

  late final _$_ChatStoreBaseActionController =
      ActionController(name: '_ChatStoreBase', context: context);

  @override
  bool mensagemEhDoUsuario(String id) {
    final _$actionInfo = _$_ChatStoreBaseActionController.startAction(
        name: '_ChatStoreBase.mensagemEhDoUsuario');
    try {
      return super.mensagemEhDoUsuario(id);
    } finally {
      _$_ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mensagemController: ${mensagemController},
mensagens: ${mensagens},
scrollController: ${scrollController}
    ''';
  }
}
