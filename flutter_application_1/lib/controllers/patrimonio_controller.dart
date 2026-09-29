import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/movimentacao.dart';
import '../models/patrimonio.dart';
import '../models/professor.dart';
import '../services/api_service.dart';

class PatrimonioController extends ChangeNotifier {
  static final PatrimonioController _instance =
      PatrimonioController._internal();
  factory PatrimonioController() => _instance;
  PatrimonioController._internal();

  final ApiService _api = ApiService();
  final MockData _mockData = MockData();

  bool _isLoading = false;
  String _selectedCategory = 'Todas';
  String _selectedStatus = 'all';
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  String get selectedStatus => _selectedStatus;
  String get searchQuery => _searchQuery;

  List<Patrimonio> get patrimonios => _mockData.patrimonios;
  List<HistoricoItem> get historico => _mockData.historicoProjetor;
  List<MovimentacaoRecente> get movimentacoesRecentes =>
      _mockData.movimentacoesRecentes;

  int get totalBensCount => _mockData.totalBensCount;
  int get bensEmUsoCount => _mockData.bensEmUsoCount;
  int get bensDisponiveisCount => _mockData.bensDisponiveisCount;
  int get bensManutencaoCount => _mockData.bensManutencaoCount;
  int get bensBaixaCount => _mockData.bensBaixaCount;
  double get valorTotalEstimado => _mockData.valorTotalEstimado;

  void setCategoryFilter(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setStatusFilter(String status) {
    _selectedStatus = status;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Patrimonio> get filteredPatrimonios {
    return _mockData.patrimonios.where((p) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          p.nome.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.codigo.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.serialNumber.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesCategory =
          _selectedCategory == 'Todas' ||
          p.categoria.label.toLowerCase().contains(
            _selectedCategory.toLowerCase(),
          );

      bool matchesStatus = true;
      if (_selectedStatus == 'emUso') {
        matchesStatus = p.status == StatusPatrimonio.emUso;
      } else if (_selectedStatus == 'disponivel') {
        matchesStatus = p.status == StatusPatrimonio.disponivel;
      } else if (_selectedStatus == 'emManutencao') {
        matchesStatus = p.status == StatusPatrimonio.emManutencao;
      }

      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  List<Patrimonio> getMeusBens(String matricula) =>
      _mockData.getBensDoProfessor(matricula);

  Future<bool> cadastrarPatrimonio(Patrimonio novo) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _api.criarPatrimonio({
        'codigo': novo.codigo,
        'nome': novo.nome,
        'marca': novo.marca,
        'modelo': novo.modelo,
        'serial': novo.serialNumber,
        'categoria': novo.categoria.label,
        'valor': novo.valorEstimado,
        'localizacao': novo.localizacao,
        'origem': novo.origemRecurso,
      });
    } catch (_) {}
    _mockData.adicionarPatrimonio(novo);
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> atribuirPatrimonio({
    required String patrimonioId,
    required Professor professor,
    required String localizacao,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _api.atribuirPatrimonio(patrimonioId, {
        'professorId': professor.id,
        'localizacao': localizacao,
      });
    } catch (_) {}
    _mockData.atribuirPatrimonio(
      patrimonioId: patrimonioId,
      professor: professor,
      localizacao: localizacao,
    );
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> registrarDevolucao({
    required String patrimonioId,
    required String condicaoRetorno,
    required String justificativa,
    required bool enviarParaManutencao,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _api.desatribuirPatrimonio(patrimonioId, {
        'condicao': condicaoRetorno,
        'justificativa': justificativa,
        'enviarParaManutencao': enviarParaManutencao,
      });
    } catch (_) {}
    _mockData.registrarDevolucao(
      patrimonioId: patrimonioId,
      condicaoRetorno: condicaoRetorno,
      justificativa: justificativa,
      enviarParaManutencao: enviarParaManutencao,
    );
    _isLoading = false;
    notifyListeners();
    return true;
  }
}
