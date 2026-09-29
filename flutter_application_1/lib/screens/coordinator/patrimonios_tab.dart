import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/status_badge.dart';
import '../../controllers/patrimonio_controller.dart';
import '../../models/patrimonio.dart';
import 'novo_patrimonio_screen.dart';
import 'atribuir_patrimonio_screen.dart';
import 'registrar_devolucao_screen.dart';
import 'patrimonio_historico_screen.dart';

class PatrimoniosTab extends StatefulWidget {
  const PatrimoniosTab({super.key});

  @override
  State<PatrimoniosTab> createState() => _PatrimoniosTabState();
}

class _PatrimoniosTabState extends State<PatrimoniosTab> {
  final _controller = PatrimonioController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Gestão de Patrimônios', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppColors.surfaceContainerLowest,
        elevation: 0.5,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.secondary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Novo Patrimônio', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NovoPatrimonioScreen())),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (val) => _controller.setSearchQuery(val),
              decoration: InputDecoration(
                hintText: 'Buscar tombamento, modelo ou série...',
                prefixIcon: const Icon(Icons.search, color: AppColors.outline),
                filled: true,
                fillColor: AppColors.surfaceContainerLowest,
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildStatusChip('Todos', 'all'),
                const SizedBox(width: 8),
                _buildStatusChip('Em Uso', 'emUso'),
                const SizedBox(width: 8),
                _buildStatusChip('Disponíveis', 'disponivel'),
                const SizedBox(width: 8),
                _buildStatusChip('Manutenção', 'emManutencao'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListenableBuilder(
              listenable: _controller,
              builder: (context, _) {
                final itens = _controller.filteredPatrimonios;
                if (itens.isEmpty) {
                  return const Center(child: Text('Nenhum patrimônio encontrado.'));
                }