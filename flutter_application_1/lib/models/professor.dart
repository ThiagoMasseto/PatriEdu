class Professor {
  final String id;
  final String nome;
  final String matricula;
  final String cpf;
  final String email;
  final String telefone;
  final String disciplina;
  final String turno;
  final String cargaHoraria;
  final String cargo;
  final String lotacao;
  final String dataAdmissao;
  final String? photoUrl;
  final int totalBens;
  final List<String> bensVinculadosNomes;

  const Professor({
    required this.id,
    required this.nome,
    required this.matricula,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.disciplina,
    required this.turno,
    required this.cargaHoraria,
    this.cargo = 'Professor PEB II - Efetivo',
    this.lotacao = 'E.E. Cecília Meireles',
    this.dataAdmissao = '14/03/2019',
    this.photoUrl,
    this.totalBens = 0,
    this.bensVinculadosNomes = const [],
  });
}
