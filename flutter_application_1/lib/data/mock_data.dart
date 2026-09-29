import 'package:flutter/material.dart';
import '../models/patrimonio.dart';
import '../models/professor.dart';
import '../models/movimentacao.dart';

class MockData {
  static final MockData _instance = MockData._internal();
  factory MockData() => _instance;
  MockData._internal();

  String currentRole = 'coord';
  String userEmail = 'marcos.andrade@escola.ce.gov.br';
  String userNome = 'Prof. Marcos Andrade';
  String userMatricula = '#DOC-8492';
  String userTelefone = '(11) 98765-4321';
  String userEmailPessoal = 'marcos.prof.mat@gmail.com';

  final List<Patrimonio> patrimonios = [
    const Patrimonio(
      id: '1',
      codigo: '#PAT-2024-0104',
      nome: 'Notebook Lenovo ThinkPad L14',
      marca: 'Lenovo',
      modelo: 'ThinkPad L14 Gen 2',
      serialNumber: 'LNV-883921-BR',
      categoria: CategoriaPatrimonio.informatica,
      status: StatusPatrimonio.emUso,
      localizacao: 'Sala dos Professores / Bloco B',
      dataAquisicao: '10/01/2024',
      valorEstimado: 4200.0,
      origemRecurso: 'SEDUC (Lote Centralizado)',
      professorResponsavel: 'Prof. Marcos Andrade',
      professorMatricula: '#DOC-8492',
      dataAtribuicao: '12/02/2025',
      acessorios: ['Carregador 65W', 'Mouse USB', 'Bolsa acolchoada'],
    ),
    const Patrimonio(
      id: '2',
      codigo: '#PAT-2023-0056',
      nome: 'Projetor Epson PowerLite E20',
      marca: 'Epson',
      modelo: 'PowerLite E20',
      serialNumber: 'EP-99120-X',
      categoria: CategoriaPatrimonio.audiovisual,
      status: StatusPatrimonio.disponivel,
      localizacao: 'Armário de Multimídia • Prateleira 03',
      dataAquisicao: '15/03/2023',
      valorEstimado: 2890.0,
      origemRecurso: 'Verba FNDE / MEC',
      acessorios: [
        'Cabo AC',
        'Cabo HDMI 5m',
        'Controle Remoto',
        'Bolsa Protetora',
      ],
    ),
  ];

  final List<Professor> professores = [
    const Professor(
      id: 'doc-1',
      nome: 'Prof. Marcos Andrade',
      matricula: '#DOC-8492',
      cpf: '***.492.818-**',
      email: 'marcos.andrade@escola.ce.gov.br',
      telefone: '(11) 98765-4321',
      disciplina: 'Matemática (Ensino Médio)',
      turno: 'Matutino / Vespertino',
      cargaHoraria: '40h',
      totalBens: 4,
      bensVinculadosNomes: ['Notebook Lenovo ThinkPad L14 (#PAT-2024-0104)'],
    ),
  ];

  final List<MovimentacaoRecente> movimentacoesRecentes = [
    const MovimentacaoRecente(
      id: 'm1',
      codigoPatrimonio: '#PAT-2024-089',
      nomeItem: 'Notebook Dell Inspiron',
      tipo: TipoMovimentacao.saidaEmUso,
      tempoAtras: 'Há 2h',
      professorNome: 'Prof. Carlos Silva',
      professorDisciplina: 'Ciências',
      icon: Icons.laptop_mac,
    ),
  ];

  final List<HistoricoItem> historicoProjetor = [
    const HistoricoItem(
      id: 'h1',
      dataHora: '16/04/2025 • 09:30',
      titulo: 'Atribuição de Custódia Homologada',
      descricao: 'Vinculado com sucesso ao docente Prof. Marcos Andrade.',
      badgeTexto: 'Mais Recente',
      icon: Icons.how_to_reg,
      corIcone: Color(0xFFFFFFFF),
      corFundoIcone: Color(0xFF0051D5),
    ),
  ];

  int get totalBensCount => patrimonios.length;
  int get bensEmUsoCount =>
      patrimonios.where((p) => p.status == StatusPatrimonio.emUso).length;
  int get bensDisponiveisCount =>
      patrimonios.where((p) => p.status == StatusPatrimonio.disponivel).length;
  int get bensManutencaoCount => patrimonios
      .where((p) => p.status == StatusPatrimonio.emManutencao)
      .length;
  int get bensBaixaCount => patrimonios
      .where((p) => p.status == StatusPatrimonio.baixaInativo)
      .length;
  double get valorTotalEstimado =>
      patrimonios.fold(0.0, (acc, item) => acc + item.valorEstimado);

  List<Patrimonio> getBensDoProfessor(String matricula) =>
      patrimonios.where((p) => p.professorMatricula == matricula).toList();

  void adicionarPatrimonio(Patrimonio novo) => patrimonios.insert(0, novo);
  void adicionarProfessor(Professor novo) => professores.insert(0, novo);

  void atribuirPatrimonio({
    required String patrimonioId,
    required Professor professor,
    required String localizacao,
  }) {
    final idx = patrimonios.indexWhere((p) => p.id == patrimonioId);
    if (idx != -1) {
      patrimonios[idx] = patrimonios[idx].copyWith(
        status: StatusPatrimonio.emUso,
        professorResponsavel: professor.nome,
        professorMatricula: professor.matricula,
        localizacao: localizacao,
      );
    }
  }

  void registrarDevolucao({
    required String patrimonioId,
    required String condicaoRetorno,
    required String justificativa,
    required bool enviarParaManutencao,
  }) {
    final idx = patrimonios.indexWhere((p) => p.id == patrimonioId);
    if (idx != -1) {
      patrimonios[idx] = patrimonios[idx].copyWith(
        status: enviarParaManutencao
            ? StatusPatrimonio.emManutencao
            : StatusPatrimonio.disponivel,
        professorResponsavel: null,
        professorMatricula: null,
      );
    }
  }
}
