import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/app_logo.dart';
import '../../controllers/auth_controller.dart';
import '../coordinator/coordinator_main_screen.dart';
import '../teacher/teacher_main_screen.dart';
import 'forgot_password_screen.dart';
import 'register_coordinator_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController(text: 'marcos.andrade@escola.ce.gov.br');
  final _passwordController = TextEditingController(text: '12345678');

  String _selectedRole = 'coord';
  bool _obscurePassword = true;
  bool _rememberMe = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _switchRole(String role) {
    setState(() {
      _selectedRole = role;
      if (role == 'coord') {
        _identifierController.text = 'admin@admin.com';
        _passwordController.text = 'admin123';
      } else {
        _identifierController.text = 'professor@escola.com';
        _passwordController.text = 'prof123';
      }
    });
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    final email = _identifierController.text.trim();
    final password = _passwordController.text;

    final success = await AuthController().login(email, password);
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      final isCoord = AuthController().isAdmin || _selectedRole == 'coord';
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => isCoord ? const CoordinatorMainScreen() : const TeacherMainScreen(),
        ),
      );
    }
  }

  void _triggerBiometrics() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: const Row(
          children: [
            Icon(Icons.fingerprint, color: AppColors.tertiaryFixed),
            SizedBox(width: 10),
            Text('Biometria autenticada com sucesso!'),
          ],
        ),
      ),
    );
    Future.delayed(const Duration(milliseconds: 500), _handleLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              Center(
                child: Column(
                  children: [
                    const AppLogo(size: 64, showBadge: true),
                    const SizedBox(height: 12),
                    Text(
                      'PatriEdu',
                      style: AppTextStyles.headlineLgMobile.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Gestão e Acompanhamento de Patrimônio Escolar',
                      style: AppTextStyles.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Switcher Role
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _switchRole('coord'),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedRole == 'coord' ? AppColors.surfaceContainerLowest : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.admin_panel_settings_outlined, size: 18, color: _selectedRole == 'coord' ? AppColors.primary : AppColors.onSurfaceVariant),
                              const SizedBox(width: 6),
                              Text('Coordenador', style: AppTextStyles.labelMd.copyWith(color: _selectedRole == 'coord' ? AppColors.primary : AppColors.onSurfaceVariant, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _switchRole('prof'),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _selectedRole == 'prof' ? AppColors.surfaceContainerLowest : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.school_outlined, size: 18, color: _selectedRole == 'prof' ? AppColors.primary : AppColors.onSurfaceVariant),
                              const SizedBox(width: 6),
                              Text('Professor', style: AppTextStyles.labelMd.copyWith(color: _selectedRole == 'prof' ? AppColors.primary : AppColors.onSurfaceVariant, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('E-mail Institucional ou Matrícula', style: AppTextStyles.labelMd),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _identifierController,
                      decoration: const InputDecoration(prefixIcon: Icon(Icons.badge_outlined)),
                      validator: (v) => v == null || v.isEmpty ? 'Informe seu login' : null,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Senha de Acesso', style: AppTextStyles.labelMd),
                        GestureDetector(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())),
                          child: Text('Esqueceu a senha?', style: AppTextStyles.labelSm.copyWith(color: AppColors.secondary, decoration: TextDecoration.underline)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      validator: (v) => v == null || v.isEmpty ? 'Informe sua senha' : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Entrar no Sistema'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: _triggerBiometrics,
                      icon: const Icon(Icons.fingerprint, color: AppColors.secondary),
                      label: const Text('Entrar com Biometria / Touch ID'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}