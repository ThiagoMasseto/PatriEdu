import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  static String get defaultBaseUrl {
    if (!kIsWeb && Platform.isAndroid) {
      return 'http://10.0.2.2:8081';
    }
    return 'http://localhost:8081';
  }

  String baseUrl = defaultBaseUrl;
  String? _token;

  String? get token => _token;
  bool get isAuthenticated => _token != null && _token!.isNotEmpty;

  void setToken(String? token) {
    _token = token;
  }

  Map<String, String> _headers({bool requiresAuth = true}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (requiresAuth && _token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  // POST /api/auth/login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login'),
      headers: _headers(requiresAuth: false),
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (data['token'] != null) setToken(data['token']);
      return data;
    } else {
      throw Exception(data['error'] ?? 'Falha na autenticação');
    }
  }

  // POST /api/auth/register
  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/register'),
      headers: _headers(requiresAuth: false),
      body: jsonEncode(userData),
    );
    final data = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw Exception(data['error'] ?? 'Erro no cadastro');
    }
  }

  // POST /api/admin/patrimonios
  Future<Map<String, dynamic>> criarPatrimonio(
    Map<String, dynamic> data,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/admin/patrimonios'),
      headers: _headers(),
      body: jsonEncode(data),
    );
    final res = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return res;
    } else {
      throw Exception(res['error'] ?? 'Erro ao cadastrar patrimônio');
    }
  }

  // POST /api/admin/patrimonios/{id}/atribuir
  Future<Map<String, dynamic>> atribuirPatrimonio(
    dynamic id,
    Map<String, dynamic> body,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/admin/patrimonios/$id/atribuir'),
      headers: _headers(),
      body: jsonEncode(body),
    );
    final res = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return res;
    } else {
      throw Exception(res['error'] ?? 'Erro ao atribuir patrimônio');
    }
  }

  // POST /api/admin/patrimonios/{id}/desatribuir
  Future<Map<String, dynamic>> desatribuirPatrimonio(
    dynamic id,
    Map<String, dynamic> body,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/admin/patrimonios/$id/desatribuir'),
      headers: _headers(),
      body: jsonEncode(body),
    );
    final res = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return res;
    } else {
      throw Exception(res['error'] ?? 'Erro ao registrar devolução');
    }
  }

  // GET /api/patrimonios
  Future<List<dynamic>> getPatrimonios() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/patrimonios'),
      headers: _headers(),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erro ao carregar patrimônios');
    }
  }

  // GET /api/admin/professores
  Future<List<dynamic>> getProfessores() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/admin/professores'),
      headers: _headers(),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erro ao carregar professores');
    }
  }

  // POST /api/admin/professores
  Future<Map<String, dynamic>> criarProfessor(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/admin/professores'),
      headers: _headers(),
      body: jsonEncode(data),
    );
    final res = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return res;
    } else {
      throw Exception(res['error'] ?? 'Erro ao cadastrar professor');
    }
  }
}
