import 'package:flutter/material.dart';
import 'package:my_finances/main.dart';
import 'package:my_finances/model/progress_model.dart';
import 'package:my_finances/model/repository/TransacaoRepository.dart';
import 'package:my_finances/screens/saidas.dart';
import 'package:my_finances/widget/card_transacao.dart';
import 'package:my_finances/widget/form_text_form_field.dart';
import 'package:provider/provider.dart';

class TelaSaidaCreate extends StatefulWidget {

  const TelaSaidaCreate({super.key});

  @override
  _TelaSaidaCreateState createState() => _TelaSaidaCreateState();

}

class _TelaSaidaCreateState extends State<TelaSaidaCreate> {
  var repository = Transacaorepository();

  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _valorController = TextEditingController();

    static var visited = false;

  @override
  void initState() {
    if(!visited) {
      context.read<ProgressModel>().increaseProgress(0.2);
      visited = true;
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Saida"),
        backgroundColor: const Color.fromARGB(255, 206, 55, 198)
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  FormTextFormField(
                    controller: _descricaoController,
                    label: 'Descrição',
                    hintText: 'Informe Descrição'
                  ),

                  SizedBox(height: 10),

                  FormTextFormField(
                    controller: _valorController,
                    label: 'Valor',
                    hintText: 'Informe Valor',
                    keyboardType: TextInputType.text,            
                  ),

                  SizedBox(height: 10),

                  ElevatedButton(onPressed: _cadastrarSaida, child: Text('Cadastrar Entrada'))
                ],
              )
            )
          ]
        )// Column
      )// Container
    );



  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  void _cadastrarSaida() {
    repository.addSaida(_descricaoController.text, double.parse(_valorController.text));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: 'Minhas Finanças')));
  }

}