enum StatusPatrimonio {
  emUso,
  disponivel,
  emManutencao,
  baixaInativo;

  String get label {
    switch (this) {
      case StatusPatrimonio.emUso:
        return 'Em Uso';
      case StatusPatrimonio.disponivel:
        return 'Disponível';
      case StatusPatrimonio.emManutencao:
        return 'Em Manutenção';
      case StatusPatrimonio.baixaInativo:
        return 'Baixa / Inativo';
    }
  }
}

enum CategoriaPatrimonio {
  informatica('Informática & TI', 'computer'),
  audiovisual('Audiovisual & Multimídia', 'videocam'),
  mobiliario('Mobiliário Escolar', 'chair'),
  laboratorio('Laboratório de Ciências', 'science'),
  esportivo('Esportivo', 'sports_soccer');

  final String label;
  final String iconName;
  const CategoriaPatrimonio(this.label, this.iconName);
}

class Patrimonio {
  final String id;
  final String codigo;
  final String nome;
  final String marca;
  final String modelo;
  final String serialNumber;
  final CategoriaPatrimonio categoria;
  final StatusPatrimonio status;
  final String localizacao;
  final String dataAquisicao;
  final double valorEstimado;
  final String origemRecurso;
  final String? notaFiscal;
  final String? professorResponsavel;
  final String? professorId;
  final String? professorMatricula;
  final String? dataAtribuicao;
  final List<String> acessorios;
  final String? imageUrl;
  final String? observacaoManutencao;
  final String? numeroOS;

  const Patrimonio({
    required this.id,
    required this.codigo,
    required this.nome,
    required this.marca,
    required this.modelo,
    required this.serialNumber,
    required this.categoria,
    required this.status,
    required this.localizacao,
    required this.dataAquisicao,
    required this.valorEstimado,
    required this.origemRecurso,
    this.notaFiscal,
    this.professorResponsavel,
    this.professorId,
    this.professorMatricula,
    this.dataAtribuicao,
    this.acessorios = const [],
    this.imageUrl,
    this.observacaoManutencao,
    this.numeroOS,
  });

  Patrimonio copyWith({
    String? id,
    String? codigo,
    String? nome,
    String? marca,
    String? modelo,
    String? serialNumber,
    CategoriaPatrimonio? categoria,
    StatusPatrimonio? status,
    String? localizacao,
    String? dataAquisicao,
    double? valorEstimado,
    String? origemRecurso,
    String? notaFiscal,
    String? professorResponsavel,
    String? professorId,
    String? professorMatricula,
    String? dataAtribuicao,
    List<String>? acessorios,
    String? imageUrl,
    String? observacaoManutencao,
    String? numeroOS,
  }) {
    return Patrimonio(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      serialNumber: serialNumber ?? this.serialNumber,
      categoria: categoria ?? this.categoria,
      status: status ?? this.status,
      localizacao: localizacao ?? this.localizacao,
      dataAquisicao: dataAquisicao ?? this.dataAquisicao,
      valorEstimado: valorEstimado ?? this.valorEstimado,
      origemRecurso: origemRecurso ?? this.origemRecurso,
      notaFiscal: notaFiscal ?? this.notaFiscal,
      professorResponsavel: professorResponsavel ?? this.professorResponsavel,
      professorId: professorId ?? this.professorId,
      professorMatricula: professorMatricula ?? this.professorMatricula,
      dataAtribuicao: dataAtribuicao ?? this.dataAtribuicao,
      acessorios: acessorios ?? this.acessorios,
      imageUrl: imageUrl ?? this.imageUrl,
      observacaoManutencao: observacaoManutencao ?? this.observacaoManutencao,
      numeroOS: numeroOS ?? this.numeroOS,
    );
  }
}
