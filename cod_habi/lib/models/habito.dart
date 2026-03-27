class Habito {
  final String id;
  final String nome;
  final String descricao;
  bool concluido;
  int sequenciaDias;

  Habito({
    required this.id,
    required this.nome,
    required this.descricao,
    this.concluido = false,
    this.sequenciaDias = 0,
  });
}