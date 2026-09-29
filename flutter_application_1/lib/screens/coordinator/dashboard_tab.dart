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