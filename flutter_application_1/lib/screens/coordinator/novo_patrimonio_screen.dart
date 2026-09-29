import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/patrimonio_controller.dart';
import '../../models/patrimonio.dart';

class NovoPatrimonioScreen extends StatefulWidget {
  const NovoPatrimonioScreen({super.key});

  @override
  State<NovoPatrimonioScreen> createState() => _NovoPatrimonioScreenState();
}

class _NovoPatrimonioScreenState extends State<NovoPatrimonioScreen> {
  final _tombamentoCtrl = TextEditingController(text: 'PAT-2025-0142');
  final _nomeCtrl = TextEditingController(text: 'Notebook Dell Latitude 3420');
  final _marcaCtrl = TextEditingController(text: 'Dell');
  final _modeloCtrl = TextEditingController(text: 'Latitude 3420');
  final _serialCtrl = TextEditingController(text: 'CN-0J138X');
  final _nfCtrl = TextEditingController(text: 'NF-e 004.819');
  final _valorCtrl = TextEditingController(text: '3450.00');

  CategoriaPatrimonio _categoria = CategoriaPatrimonio.informatica;
  String _local = 'Sala de Informática (Lab 1)';

  void _salvar() async {
    final novo = Patrimonio(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      codigo: _tombamentoCtrl.text.trim(),
      nome: _nomeCtrl.text.trim(),
      marca: _marcaCtrl.text.trim(),
      modelo: _modeloCtrl.text.trim(),
      serialNumber: _serialCtrl.text.trim(),
      categoria: _categoria,
      status: StatusPatrimonio.disponivel,
      localizacao: _local,
      dataAquisicao: '16/04/2025',
      valorEstimado: double.tryParse(_valorCtrl.text) ?? 0.0,
      origemRecurso: 'FNDE / MEC',
      notaFiscal: _nfCtrl.text.trim(),
      acessorios: const ['Carregador 65W', 'Cabo de Força'],
    );

    await PatrimonioController().cadastrarPatrimonio(novo);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Patrimônio ${novo.codigo} cadastrado!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Novo Tombamento'), backgroundColor: AppColors.surfaceContainerLowest),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _tombamentoCtrl, decoration: const InputDecoration(labelText: 'Tombamento (Plaqueta)', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _nomeCtrl, decoration: const InputDecoration(labelText: 'Nome / Descrição', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _marcaCtrl, decoration: const InputDecoration(labelText: 'Marca', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _modeloCtrl, decoration: const InputDecoration(labelText: 'Modelo', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _serialCtrl, decoration: const InputDecoration(labelText: 'Número de Série (S/N)', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: _valorCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Valor (R\$)', border: OutlineInputBorder())),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(50)),
              onPressed: _salvar,
              icon: const Icon(Icons.save),
              label: const Text('Cadastrar no Acervo'),
            ),
          ],
        ),
      ),
    );
  }
}