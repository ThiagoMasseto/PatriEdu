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