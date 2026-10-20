import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../controllers/patrimonio_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../models/patrimonio.dart';

class MeusPatrimoniosTab extends StatefulWidget {
  const MeusPatrimoniosTab({super.key});

  @override
  State<MeusPatrimoniosTab> createState() => _MeusPatrimoniosTabState();
}

class _MeusPatrimoniosTabState extends State<MeusPatrimoniosTab> {
  String _search = '';
  String _filterCat = 'Todas';

  @override
  Widget build(BuildContext context) {
    final controller = PatrimonioController();
    final auth = AuthController();
    final matricula = auth.currentUser?['matricula'] ?? '#DOC-8492';
    final nomeDocente = auth.currentUser?['nome'] ?? 'Prof. Marcos';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(roleBadgeText: 'DOCENTE'),
      body: ListenableBuilder(
        listenable: controller,
        builder: (context, _) {
          final meusBens = controller.getMeusBens(matricula);
          final filtered = meusBens.where((b) {
            final matchQuery = b.nome.toLowerCase().contains(_search.toLowerCase()) ||
                b.codigo.toLowerCase().contains(_search.toLowerCase());
            final matchCat = _filterCat == 'Todas' || b.categoria.label.contains(_filterCat);
            return matchQuery && matchCat;
          }).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Olá, $nomeDocente 👋', style: AppTextStyles.headlineLgMobile.copyWith(color: AppColors.primary)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(matricula, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Equipamentos escolares sob sua responsabilidade de uso e guarda.',
                  style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 16),

                // Banner Termo de Responsabilidade
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.primaryContainer, AppColors.primary, Color(0xFF001850)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('TERMO DE RESPONSABILIDADE', style: TextStyle(color: Color(0xFFDCE1FF), fontSize: 11, fontWeight: FontWeight.bold)),
                              Text('Vigente (Ano Letivo 2025)', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Icon(Icons.verified_user, color: AppColors.tertiaryFixed, size: 28),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${meusBens.length} Bens sob custódia',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppColors.primary,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            onPressed: () => _mostrarTermoAssinado(context, nomeDocente),
                            icon: const Icon(Icons.description, size: 16, color: AppColors.secondary),
                            label: const Text('Ver Termo', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Campo de Busca
                TextField(
                  onChanged: (v) => setState(() => _search = v),
                  decoration: InputDecoration(
                    hintText: 'Buscar por tombamento, modelo ou sala...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.outline),
                    filled: true,
                    fillColor: AppColors.surfaceContainerLowest,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 12),

                // Lista de Bens
                if (filtered.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(child: Text('Nenhum bem sob custódia localizado.')),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item.codigo, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(10)),
                                    child: const Text('Em Uso Regular', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.onTertiaryContainer)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(item.nome, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.meeting_room, size: 16, color: AppColors.secondary),
                                  const SizedBox(width: 4),
                                  Text(item.localizacao, style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(8)),
                                child: Text('S/N: ${item.serialNumber} • Atribuição: ${item.dataAquisicao}', style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                              ),
                              const SizedBox(height: 10),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  minimumSize: const Size.fromHeight(40),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                onPressed: () => _mostrarFichaCompleta(context, item),
                                icon: const Icon(Icons.visibility, size: 16),
                                label: const Text('Ver Ficha Completa'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _mostrarFichaCompleta(BuildContext context, Patrimonio item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ficha de Consulta Cadastral', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.secondary)),
            const SizedBox(height: 4),
            Text(item.nome, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 20),
            Text('Tombamento: ${item.codigo}', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Nº de Série: ${item.serialNumber}'),
            Text('Local: ${item.localizacao}'),
            Text('Data de Atribuição: ${item.dataAquisicao}'),
            const SizedBox(height: 8),
            Text('Acessórios: ${item.acessorios.join(", ")}', style: const TextStyle(color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, minimumSize: const Size.fromHeight(46)),
              onPressed: () => Navigator.pop(context),
              child: const Text('Concluir Leitura', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _mostrarTermoAssinado(BuildContext context, String nome) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Termo de Guarda e Responsabilidade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
            const SizedBox(height: 8),
            Text('Protocolo Eletrônico: TR-2025-EE-CM', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.secondary)),
            const SizedBox(height: 12),
            Text('Certifico que o docente $nome recebeu os equipamentos sob tutela provisória para o ano letivo de 2025, comprometendo-se ao zelo e reporte de anormalidades.'),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(Icons.verified, color: AppColors.onTertiaryContainer, size: 18),
                SizedBox(width: 6),
                Text('Assinado digitalmente via Gov.br', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onTertiaryContainer)),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.surfaceContainer, minimumSize: const Size.fromHeight(46)),
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar Documento', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
      ),
    );
  }
}
