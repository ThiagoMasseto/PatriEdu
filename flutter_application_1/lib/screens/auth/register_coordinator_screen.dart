import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/app_logo.dart';

class RegisterCoordinatorScreen extends StatefulWidget {
  const RegisterCoordinatorScreen({super.key});

  @override
  State<RegisterCoordinatorScreen> createState() => _RegisterCoordinatorScreenState();
}

class _RegisterCoordinatorScreenState extends State<RegisterCoordinatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _inepController = TextEditingController();
  final _schoolNameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _selectedSphere = 'Estadual';
  bool _isLoadingInep = false;
  bool _obscurePassword = true;

  void _searchInep() async {
    if (_inepController.text.length < 8) return;
    setState(() => _isLoadingInep = true);

    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _schoolNameController.text = 'E.E.F.M. Escola de Exemplo INEP';
      _isLoadingInep = false;
    });
  }

  void _handleRegister() {
    if (!_formKey.currentState!.validate()) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cadastro de Coordenador realizado com sucesso!')),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _inepController.dispose();
    _schoolNameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Credenciamento de Coordenador'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: AppLogo(size: 56, showBadge: true)),
                const SizedBox(height: 16),
                Text('Cadastro Inicial da Unidade Escolar', style: AppTextStyles.headlineLgMobile),
                const SizedBox(height: 20),
                Text('Código INEP da Escola', style: AppTextStyles.labelMd),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _inepController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.school_outlined),
                    suffixIcon: IconButton(
                      icon: _isLoadingInep
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.search),
                      onPressed: _searchInep,
                    ),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Informe o código INEP' : null,
                ),
                const SizedBox(height: 16),
                Text('Nome da Escola', style: AppTextStyles.labelMd),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _schoolNameController,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.domain_outlined)),
                  validator: (v) => v == null || v.isEmpty ? 'Informe o nome da escola' : null,
                ),
                const SizedBox(height: 16),
                Text('Esfera Administrativa', style: AppTextStyles.labelMd),
                const SizedBox(height: 6),
                DropdownButtonFormField<String>(
                  value: _selectedSphere,
                  items: ['Estadual', 'Municipal', 'Federal', 'Privada']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (val) => setState(() => _selectedSphere = val!),
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.account_balance_outlined)),
                ),
                const SizedBox(height: 16),
                Text('Nome do Coordenador Responsável', style: AppTextStyles.labelMd),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.person_outline)),
                  validator: (v) => v == null || v.isEmpty ? 'Informe o nome do responsável' : null,
                ),
                const SizedBox(height: 16),
                Text('E-mail Institucional', style: AppTextStyles.labelMd),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.email_outlined)),
                  validator: (v) => v == null || v.isEmpty ? 'Informe o e-mail' : null,
                ),
                const SizedBox(height: 16),
                Text('Senha de Acesso', style: AppTextStyles.labelMd),
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
                  validator: (v) => v == null || v.length < 6 ? 'Mínimo de 6 caracteres' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _handleRegister,
                  child: const Text('Concluir Credenciamento'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}