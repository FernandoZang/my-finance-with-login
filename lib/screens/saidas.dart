import 'package:flutter/material.dart';
import 'package:my_finances/model/Transacao.dart';
import 'package:my_finances/model/repository/TransacaoRepository.dart';
import 'package:my_finances/card_transacao.dart';

class TelaSaidas extends StatefulWidget {

  const TelaSaidas(String s, {super.key});

  @override
  _TelaSaidasState createState() => _TelaSaidasState();

}

class _TelaSaidasState extends State {
  var repository = Transacaorepository();
  
  @override
  Widget build(BuildContext context) {
    var transacoes = repository.saidas();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Saidas"),
        backgroundColor: const Color.fromARGB(255, 206, 55, 198),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: transacoes.length,
        itemBuilder: (context, index) {
          if(index<transacoes.length) {
            Transacao transacao = transacoes[index] as Transacao;
            return CardTransacao(id: transacao.id, descricao: transacao.descricao, valor: transacao.valor, entrada: transacao.entrada,);
          }
          return null;
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSaida,
        tooltip: 'Adicionar Saida',
        child: const Icon(Icons.add),
      )
    );
  }

  void _addSaida(){
      print('Adicionando saida');
  }
}