import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/patrimonio_controller.dart';
import '../../models/patrimonio.dart';

class RegistrarDevolucaoScreen extends StatelessWidget {
  final Patrimonio patrimonio;

  const RegistrarDevolucaoScreen({super.key, required this.patrimonio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Registrar Devolução'), backgroundColor: AppColors.surfaceContainerLowest),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.assignment_return, color: AppColors.primary),
                title: Text(patrimonio.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('${patrimonio.codigo} • ${patrimonio.professorResponsavel ?? ""}'),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(50)),
              onPressed: () async {
                await PatrimonioController().registrarDevolucao(
                  patrimonioId: patrimonio.id,
                  condicaoRetorno: 'Perfeito Estado',
                  justificativa: 'Fim do período letivo',
                  enviarParaManutencao: false,
                );
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Devolução registrada e termo de baixa emitido!')));
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('Confirmar Devolução e Dar Baixa'),
            ),
          ],
        ),
      ),
    );
  }
}