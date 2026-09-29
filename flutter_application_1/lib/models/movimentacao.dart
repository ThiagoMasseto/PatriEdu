import 'package:flutter/material.dart';

enum TipoMovimentacao { saidaEmUso, devolucao, manutencao, tombamento, alerta }

class MovimentacaoRecente {
  final String id;
  final String codigoPatrimonio;
  final String nomeItem;
  final TipoMovimentacao tipo;
  final String tempoAtras;
  final String professorNome;
  final String professorDisciplina;
  final String? observacao;
  final String? destinoOuOrigem;
  final IconData icon;

  const MovimentacaoRecente({
    required this.id,
    required this.codigoPatrimonio,
    required this.nomeItem,
    required this.tipo,
    required this.tempoAtras,
    required this.professorNome,
    required this.professorDisciplina,
    this.observacao,
    this.destinoOuOrigem,
    required this.icon,
  });
}

class HistoricoItem {
  final String id;
  final String dataHora;
  final String titulo;
  final String descricao;
  final String? badgeTexto;
  final String? idValidacao;
  final List<String> tags;
  final IconData icon;
  final Color corIcone;
  final Color corFundoIcone;

  const HistoricoItem({
    required this.id,
    required this.dataHora,
    required this.titulo,
    required this.descricao,
    this.badgeTexto,
    this.idValidacao,
    this.tags = const [],
    required this.icon,
    required this.corIcone,
    required this.corFundoIcone,
  });
}
