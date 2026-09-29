import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/professor.dart';
import '../services/api_service.dart';

class ProfessorController extends ChangeNotifier {
  static final ProfessorController _instance = ProfessorController._internal();
  factory ProfessorController() => _instance;
  ProfessorController._internal();

  final ApiService _api = ApiService();
  final MockData _mockData = MockData();

  bool _isLoading = false;
  String _selectedFilter = 'all';
  String _searchQuery = '';

  bool get isLoading => _isLoading;
  String get selectedFilter => _selectedFilter;
  String get searchQuery => _searchQuery;

  List<Professor> get professores => _mockData.professores;

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Professor> get filteredProfessores {
    return _mockData.professores.where((prof) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          prof.nome.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          prof.disciplina.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          prof.matricula.toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesFilter = true;
      if (_selectedFilter == 'bens') {
        matchesFilter = prof.totalBens > 0;
      } else if (_selectedFilter == 'pendencias') {
        matchesFilter = prof.totalBens == 0;
      } else if (_selectedFilter == 'exatas') {
        matchesFilter =
            prof.disciplina.toLowerCase().contains('matemática') ||
            prof.disciplina.toLowerCase().contains('ciências') ||
            prof.disciplina.toLowerCase().contains('física');
      } else if (_selectedFilter == 'humanas') {
        matchesFilter =
            prof.disciplina.toLowerCase().contains('história') ||
            prof.disciplina.toLowerCase().contains('portuguesa') ||
            prof.disciplina.toLowerCase().contains('filosofia');
      }

      return matchesSearch && matchesFilter;
    }).toList();
  }

  Future<bool> cadastrarProfessor(Professor novo) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _api.criarProfessor({
        'nome': novo.nome,
        'email': novo.email,
        'matricula': novo.matricula,
        'cpf': novo.cpf,
        'telefone': novo.telefone,
        'departamento': novo.disciplina,
      });
    } catch (_) {}
    _mockData.adicionarProfessor(novo);
    _isLoading = false;
    notifyListeners();
    return true;
  }
}
