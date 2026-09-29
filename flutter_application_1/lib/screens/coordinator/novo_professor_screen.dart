import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/professor_controller.dart';
import '../../models/professor.dart';

class NovoProfessorScreen extends StatefulWidget {
  const NovoProfessorScreen({super.key});

  @override
  State<NovoProfessorScreen> createState() => _NovoProfessorScreenState();
}

class _NovoProfessorScreenState extends State<NovoProfessorScreen> {
  final _nomeCtrl = TextEditingController();
  final _matriculaCtrl = TextEditingController(text: '#DOC-');
  final _emailCtrl = TextEditingController();
  final _disciplinaCtrl = TextEditingController();

  void _salvar() async {
    final novo = Professor(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      matricula: _matriculaCtrl.text.trim(),
      nome: _nomeCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      disciplina: _disciplinaCtrl.text.trim(),
      telefone: '(85) 98765-4321',
      turno: 'Matutino / Vespertino',
      cargaHoraria: '40h',
    );

    await ProfessorController().cadastrarProfessor(novo);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Docente ${novo.nome} cadastrado!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Cadastrar Docente'), backgroundColor: AppColors.surfaceContainerLowest),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nomeCtrl, decoration: const InputDecoration(labelText: 'Nome Completo', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _matriculaCtrl, decoration: const InputDecoration(labelText: 'Matrícula Funcional', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _emailCtrl, decoration: const InputDecoration(labelText: 'E-mail Institucional', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _disciplinaCtrl, decoration: const InputDecoration(labelText: 'Disciplina / Área', border: OutlineInputBorder())),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(50)),
              onPressed: _salvar,
              icon: const Icon(Icons.person_add),
              label: const Text('Cadastrar Professor'),
            ),
          ],
        ),
      ),
    );
  }
}