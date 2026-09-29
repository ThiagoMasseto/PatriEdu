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

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: itens.length,
                  itemBuilder: (context, index) {
                    final item = itens[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${item.codigo} • ${item.serialNumber}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 11)),
                                StatusBadge(status: item.status),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(item.nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                            Text(
                              item.professorResponsavel != null
                                  ? 'Responsável: ${item.professorResponsavel}'
                                  : 'Local: ${item.localizacao}',
                              style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PatrimonioHistoricoScreen(patrimonio: item))),
                                  child: const Text('Histórico'),
                                ),
                                if (item.status == StatusPatrimonio.emUso)
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.surfaceContainer, foregroundColor: AppColors.primary),
                                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegistrarDevolucaoScreen(patrimonio: item))),
                                    child: const Text('Devolver'),
                                  ),
                                if (item.status == StatusPatrimonio.disponivel)
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
                                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AtribuirPatrimonioScreen(patrimonio: item))),
                                    child: const Text('Atribuir'),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, String statusKey) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        final isSelected = _controller.selectedStatus == statusKey;
        return ChoiceChip(
          selected: isSelected,
          label: Text(label),
          selectedColor: AppColors.primary,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          onSelected: (val) {
            if (val) _controller.setStatusFilter(statusKey);
          },
        );
      },
    );
  }
}