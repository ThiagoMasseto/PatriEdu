import 'package:flutter/material.dart';
import '../../models/patrimonio.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class StatusBadge extends StatelessWidget {
  final StatusPatrimonio status;
  final bool compact;

  const StatusBadge({super.key, required this.status, this.compact = false});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    Color dotColor;
    String text;

    switch (status) {
      case StatusPatrimonio.emUso:
        bg = AppColors.secondaryFixed;
        fg = AppColors.onSecondaryFixed;
        dotColor = AppColors.secondary;
        text = 'EM USO';
        break;
      case StatusPatrimonio.disponivel:
        bg = AppColors.tertiaryFixed;
        fg = AppColors.onTertiaryFixedVariant;
        dotColor = AppColors.onTertiaryFixedVariant;
        text = 'DISPONÍVEL';
        break;
      case StatusPatrimonio.emManutencao:
        bg = AppColors.warningContainer;
        fg = AppColors.onWarning;
        dotColor = AppColors.warning;
        text = 'EM MANUTENÇÃO';
        break;
      case StatusPatrimonio.baixaInativo:
        bg = AppColors.errorContainer;
        fg = AppColors.onErrorContainer;
        dotColor = AppColors.error;
        text = 'BAIXA / INATIVO';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: AppTextStyles.labelSm.copyWith(
              color: fg,
              fontWeight: FontWeight.bold,
              fontSize: compact ? 9.5 : 11,
            ),
          ),
        ],
      ),
    );
  }
}
