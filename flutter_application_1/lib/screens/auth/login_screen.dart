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
    return const Scaffold();
  }
}