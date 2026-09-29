import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../controllers/patrimonio_controller.dart';
import '../../controllers/professor_controller.dart';
import '../../models/patrimonio.dart';
import '../../models/professor.dart';

class AtribuirPatrimonioScreen extends StatefulWidget {
  final Patrimonio? patrimonio;
  final Professor? professorPreSelecionado;

  const AtribuirPatrimonioScreen({super.key, this.patrimonio, this.professorPreSelecionado});

  @override
  State<AtribuirPatrimonioScreen> createState() => _AtribuirPatrimonioScreenState();
}

class _AtribuirPatrimonioScreenState extends State<AtribuirPatrimonioScreen> {
  Patrimonio? _patrimonioSel;
  Professor? _professorSel;

  @override
  void initState() {
    super.initState();
    final patrimoniosDisp = PatrimonioController().patrimonios.where((p) => p.status == StatusPatrimonio.disponivel).toList();
    _patrimonioSel = widget.patrimonio ?? (patrimoniosDisp.isNotEmpty ? patrimoniosDisp.first : null);
    _professorSel = widget.professorPreSelecionado ?? (ProfessorController().professores.isNotEmpty ? ProfessorController().professores.first : null);
  }

  void _confirmar() async {
    if (_patrimonioSel == null || _professorSel == null) return;

    await PatrimonioController().atribuirPatrimonio(
      patrimonioId: _patrimonioSel!.id,
      professor: _professorSel!,
      localizacao: 'Sala dos Professores / Bloco B',
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Termo de custódia homologado com sucesso!')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Atribuir Custódia'), backgroundColor: AppColors.surfaceContainerLowest),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.inventory_2, color: AppColors.primary),
                title: Text(_patrimonioSel?.nome ?? 'Selecione o bem'),
                subtitle: Text(_patrimonioSel?.codigo ?? ''),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                leading: const Icon(Icons.person, color: AppColors.secondary),
                title: Text(_professorSel?.nome ?? 'Selecione o docente'),
                subtitle: Text(_professorSel?.disciplina ?? ''),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(50)),
              onPressed: _confirmar,
              icon: const Icon(Icons.assignment_turned_in),
              label: const Text('Confirmar e Emitir Termo'),
            ),
          ],
        ),
      ),
    );
  }
}
