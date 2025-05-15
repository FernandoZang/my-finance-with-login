import 'package:flutter/material.dart';

class CardTransacao extends StatefulWidget {
  const CardTransacao({
    Key? key,
    required this.id,
    required this.descricao,
    required this.valor,
    required this.entrada,

  }) : super(key: key);

  final String id;
  final String descricao;
  final double valor;
  final bool entrada;

  @override
  State<CardTransacao> createState() => _CardTransacaoState();
}

class _CardTransacaoState extends State<CardTransacao> {
  

  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: GestureDetector(
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.id,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
            ),
            Text(
              widget.descricao,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            Text(
              'R\$ ${widget.valor.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            

          ]
        ),
      ) 
      ),
    );
  }
}