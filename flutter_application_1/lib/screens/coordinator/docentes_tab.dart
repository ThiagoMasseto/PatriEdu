import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/professor_controller.dart';
import 'novo_professor_screen.dart';
import 'atribuir_patrimonio_screen.dart';

class DocentesTab extends StatelessWidget {
  const DocentesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProfessorController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Gestão de Docentes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppColors.surfaceContainerLowest,
        elevation: 0.5,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.person_add, color: Colors.white),
        label: const Text('+ Docente', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NovoProfessorScreen())),
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          final professores = controller.professores;
          if (professores.isEmpty) {
            return const Center(child: Text('Nenhum docente cadastrado.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: professores.length,
            itemBuilder: (context, index) {
              final prof = professores[index];
              return Card(
                color: AppColors.surfaceContainerLowest,
                elevation: 0.5,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primaryContainer,
                            child: Text(prof.nome[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(prof.nome, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                Text('${prof.matricula} • ${prof.disciplina}', style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            prof.bensVinculadosNomes.isNotEmpty
                                ? '${prof.bensVinculadosNomes.length} bens vinculados'
                                : 'Nenhum bem vinculado',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.secondary),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.surfaceContainer,
                              foregroundColor: AppColors.primary,
                              elevation: 0,
                              minimumSize: const Size(0, 36),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            ),
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AtribuirPatrimonioScreen(professorPreSelecionado: prof))),
                            child: const Text('Atribuir Bem'),
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
    );
  }
}