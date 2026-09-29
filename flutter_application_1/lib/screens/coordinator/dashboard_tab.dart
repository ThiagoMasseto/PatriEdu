import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../controllers/patrimonio_controller.dart';
import 'novo_patrimonio_screen.dart';
import 'atribuir_patrimonio_screen.dart';
import 'registrar_devolucao_screen.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PatrimonioController();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(
        userRole: 'Gestora',
        title: 'PatriEdu',
        subtitle: 'E.E. Cecília Meireles',
      ),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          final total = controller.totalBensCount;
          final emUso = controller.bensEmUsoCount;
          final disponiveis = controller.bensDisponiveisCount;
          final manutencao = controller.bensManutencaoCount;
          final baixa = controller.bensBaixaCount;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá, Profa. Márcia 👋',
                  style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.onSurface),
                ),
                Text(
                  'Painel de controle e inventário atualizado',
                  style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 16),

                // Hero Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryContainer, AppColors.secondary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'INVENTÁRIO GLOBAL ATIVO',
                            style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppColors.tertiaryFixed,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Auditado 100%',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.onTertiaryFixed),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Bens Registrados', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                Text('$total itens', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Valor Estimado', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                Text(
                                  'R\$ ${controller.valorTotalEstimado.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Status Operacional 2x2
                Text('Status Operacional', style: AppTextStyles.headlineSm.copyWith(color: AppColors.onSurface)),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.4,
                  children: [
                    _metricCard('Em Uso', emUso, total > 0 ? emUso / total : 0, Icons.devices, AppColors.secondary),
                    _metricCard('Disponíveis', disponiveis, total > 0 ? disponiveis / total : 0, Icons.check_circle, AppColors.onTertiaryContainer),
                    _metricCard('Manutenção', manutencao, total > 0 ? manutencao / total : 0, Icons.build_circle, const Color(0xFFB45309)),
                    _metricCard('Baixa/Inativo', baixa, total > 0 ? baixa / total : 0, Icons.archive, AppColors.error),
                  ],
                ),
                const SizedBox(height: 20),

                // Ações Rápidas
                Text('Ações de Gestão', style: AppTextStyles.headlineSm.copyWith(color: AppColors.onSurface)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NovoPatrimonioScreen())),
                        icon: const Icon(Icons.add_box),
                        label: const Text('Tombamento', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AtribuirPatrimonioScreen())),
                        icon: const Icon(Icons.assignment_ind),
                        label: const Text('Atribuir', style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }