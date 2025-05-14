import 'package:flutter/material.dart';
import 'package:my_finances/model/Transacao.dart';
import 'package:my_finances/model/repository/TransacaoRepository.dart';
import 'package:my_finances/card_transacao.dart';

class TelaEntradas extends StatefulWidget {

  const TelaEntradas(String s, {super.key});

  @override
  _TelaEntradasState createState() => _TelaEntradasState();

}

class _TelaEntradasState extends State {
  var repository = Transacaorepository();
  
  @override
  Widget build(BuildContext context) {
    var transacoes = repository.entradas();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Entradas"),
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
        onPressed: _addEntrada,
        tooltip: 'Adicionar Entrada',
        child: const Icon(Icons.add),
      )
    );
  }



  void _addEntrada(){
      print('Adicionando entrada');
  }
}