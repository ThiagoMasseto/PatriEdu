import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_app_bar.dart';

class TermosTab extends StatelessWidget {
  const TermosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(roleBadgeText: 'DOCENTE'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Termos de Custódia e Guarda', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
          const SizedBox(height: 4),
          const Text('Histórico oficial de termos emitidos e assinados digitalmente.', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const CircleAvatar(backgroundColor: AppColors.surfaceContainerHigh, child: Icon(Icons.assignment, color: AppColors.primary)),
              title: const Text('Termo de Responsabilidade 2025/084', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 4),
                  Text('4 bens vinculados • Assinado em 12/02/2025', style: TextStyle(fontSize: 12)),
                  SizedBox(height: 4),
                  Text('Autenticado ICP-Brasil / Gov.br', style: TextStyle(fontSize: 11, color: AppColors.onTertiaryContainer, fontWeight: FontWeight.bold)),
                ],
              ),
              trailing: const Icon(Icons.download, color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
