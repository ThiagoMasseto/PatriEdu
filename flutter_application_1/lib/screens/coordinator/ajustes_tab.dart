import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../auth/login_screen.dart';

class AjustesTab extends StatelessWidget {
  const AjustesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Ajustes do Sistema', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: AppColors.surfaceContainerLowest,
        elevation: 0.5,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: const ListTile(
              leading: Icon(Icons.school, color: AppColors.primary),
              title: Text('E.E. Cecília Meireles', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Código INEP: 35019822 • SEDUC'),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorContainer,
              foregroundColor: AppColors.onErrorContainer,
              minimumSize: const Size.fromHeight(48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.logout),
            label: const Text('Encerrar Sessão', style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              AuthController().logout();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (r) => false);
            },
          ),
        ],
      ),
    );
  }
}