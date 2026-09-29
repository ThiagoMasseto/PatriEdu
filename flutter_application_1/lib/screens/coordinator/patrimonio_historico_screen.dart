import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/patrimonio.dart';

class PatrimonioHistoricoScreen extends StatelessWidget {
  final Patrimonio patrimonio;

  const PatrimonioHistoricoScreen({super.key, required this.patrimonio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: Text('Histórico: ${patrimonio.codigo}'), backgroundColor: AppColors.surfaceContainerLowest),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.how_to_reg, color: AppColors.secondary),
              title: const Text('Atribuição de Custódia Homologada', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Docente: ${patrimonio.professorResponsavel ?? "Prof. Marcos Andrade"} • 16/04/2025'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.build_circle, color: Color(0xFFB45309)),
              title: Text('Manutenção Preventiva', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Revisão e limpeza de filtros concluída • 14/04/2025'),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.inventory_2, color: AppColors.primary),
              title: Text('Tombamento e Entrada no Acervo', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Recepção do lote SEDUC • NF-e 004.819 • 15/03/2023'),
            ),
          ),
        ],
      ),
    );
  }
}