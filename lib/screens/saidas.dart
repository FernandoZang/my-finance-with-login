import 'package:flutter/material.dart';
import 'package:my_finances/model/Transacao.dart';
import 'package:my_finances/model/progress_model.dart';
import 'package:my_finances/model/repository/TransacaoRepository.dart';
import 'package:my_finances/screens/entrada.dart';
import 'package:my_finances/screens/saida_create.dart';
import 'package:my_finances/widget/card_transacao.dart';
import 'package:provider/provider.dart';

class TelaSaidas extends StatefulWidget {

  const TelaSaidas(String s, {super.key});

  @override
  _TelaSaidasState createState() => _TelaSaidasState();

}

class _TelaSaidasState extends State {
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> TelaSaidaCreate() ) );
  }
}