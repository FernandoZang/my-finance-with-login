class Transacao{
  String id;
  String descricao;
  double valor;
  bool entrada;

  Transacao(this.id, this.descricao, this.valor, this.entrada);

  getEntrada(){
    return entrada;
  }
}