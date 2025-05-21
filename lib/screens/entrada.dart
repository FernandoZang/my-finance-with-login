import 'package:flutter/material.dart';
import 'package:my_finances/main.dart';
import 'package:my_finances/model/Transacao.dart';
import 'package:my_finances/model/progress_model.dart';
import 'package:my_finances/model/repository/TransacaoRepository.dart';
import 'package:my_finances/screens/entrada_create';
import 'package:my_finances/widget/card_transacao.dart';
import 'package:provider/provider.dart';

class TelaEntradas extends StatefulWidget {

  const TelaEntradas(String s, {super.key});

  @override
  _TelaEntradasState createState() => _TelaEntradasState();

}

class _TelaEntradasState extends State {
  var repository = Transacaorepository();

  static var visited = false;

  @override
  void initState() {
    if(!visited) {
      context.read<ProgressModel>().increaseProgress(0.1);
      visited = true;
    }
    super.initState();
  }
  
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TelaEntradaCreate() ) );
  }
}