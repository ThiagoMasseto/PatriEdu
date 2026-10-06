import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/custom_app_bar.dart';
import '../../controllers/auth_controller.dart';
import '../auth/login_screen.dart';

class MeuPerfilTab extends StatefulWidget {
  const MeuPerfilTab({super.key});

  @override
  State<MeuPerfilTab> createState() => _MeuPerfilTabState();
}

class _MeuPerfilTabState extends State<MeuPerfilTab> {
  final _phoneCtrl = TextEditingController(text: '(11) 98765-4321');
  final _emailSecCtrl = TextEditingController(text: 'marcos.prof.mat@gmail.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(roleBadgeText: 'DOCENTE'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Card Perfil
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundColor: AppColors.primaryContainer,
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    const Text('Prof. Marcos Andrade', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text('#DOC-8492 • Matemática (Ensino Médio)', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(12)),
                      child: const Text('marcos.andrade@escola.ce.gov.br', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Contato
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Informações de Contato', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 12),
                    TextField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: 'Telefone / WhatsApp', prefixIcon: Icon(Icons.call))),
                    const SizedBox(height: 12),
                    TextField(controller: _emailSecCtrl, decoration: const InputDecoration(labelText: 'E-mail Secundário', prefixIcon: Icon(Icons.email))),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryContainer, minimumSize: const Size.fromHeight(44)),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contatos atualizados com sucesso!')));
                      },
                      child: const Text('Salvar Contatos', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Logout
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.errorContainer,
                foregroundColor: AppColors.onErrorContainer,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                AuthController().logout();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (r) => false);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Encerrar Sessão', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
