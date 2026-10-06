import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/app_logo.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int _currentStep = 1;
  final _emailController = TextEditingController();
  final List<TextEditingController> _pinControllers = List.generate(6, (_) => TextEditingController());
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Senha redefinida com sucesso!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Recuperação de Senha'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const AppLogo(size: 48, showBadge: false),
              const SizedBox(height: 16),
              Text(
                'Etapa $_currentStep de 3',
                style: AppTextStyles.labelMd.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              if (_currentStep == 1) _buildStep1Email(),
              if (_currentStep == 2) _buildStep2Pin(),
              if (_currentStep == 3) _buildStep3NewPassword(),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                onPressed: _isLoading ? null : _nextStep,
                child: Text(_currentStep == 3 ? 'Concluir e Entrar' : 'Avançar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep1Email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Informe seu E-mail Cadastrado', style: AppTextStyles.headlineLgMobile),
        const SizedBox(height: 8),
        Text('Enviaremos um código de verificação de 6 dígitos para o seu e-mail.', style: AppTextStyles.bodySm),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'E-mail Institucional',
            prefixIcon: Icon(Icons.email_outlined),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2Pin() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Digite o Código PIN', style: AppTextStyles.headlineLgMobile),
        const SizedBox(height: 8),
        Text('Insira o código de 6 dígitos enviado para o seu e-mail.', style: AppTextStyles.bodySm),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            6,
            (index) => SizedBox(
              width: 45,
              child: TextFormField(
                controller: _pinControllers[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                decoration: const InputDecoration(counterText: ''),
                onChanged: (value) {
                  if (value.isNotEmpty && index < 5) {
                    FocusScope.of(context).nextFocus();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3NewPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Crie a Nova Senha', style: AppTextStyles.headlineLgMobile),
        const SizedBox(height: 16),
        TextFormField(
          controller: _newPasswordController,
          obscureText: _obscureNewPassword,
          decoration: InputDecoration(
            labelText: 'Nova Senha',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(_obscureNewPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              onPressed: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          decoration: InputDecoration(
            labelText: 'Confirmar Nova Senha',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(_obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
            ),
          ),
        ),
      ],
    );
  }
}