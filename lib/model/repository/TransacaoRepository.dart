import 'package:flutter/widgets.dart';
import 'package:my_finances/model/Transacao.dart';

class Transacaorepository {

  late final _transacoes = [];

  Transacaorepository() {
    populateDB();
  }

  void populateDB(){
    _transacoes.add(Transacao(UniqueKey().toString(), 'Salario', 10000.00, true ));
    _transacoes.add(Transacao(UniqueKey().toString(), 'Auxilio Home Office', 300.00, true ));
    _transacoes.add(Transacao(UniqueKey().toString(), 'Pix Fulano', 100.00, true ));
    _transacoes.add(Transacao(UniqueKey().toString(), 'Pix Beltrano', 50.00, true ));

    _transacoes.add(Transacao(UniqueKey().toString(), 'Café da Manhã', 5.00, false ));
    _transacoes.add(Transacao(UniqueKey().toString(), 'Almoço UTFPR', 3.50, false ));
    _transacoes.add(Transacao(UniqueKey().toString(), 'Lanche da tarde', 10.00, false ));
    _transacoes.add(Transacao(UniqueKey().toString(), 'Janta', 10.00, false ));
 }

  entradas() {
    return _transacoes.where((item) => item.entrada == true).toList();
  }

  saidas() {
    return _transacoes.where((item) => item.entrada == false).toList();
  }
}