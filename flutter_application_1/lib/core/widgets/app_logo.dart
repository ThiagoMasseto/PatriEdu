import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showBadge;

  const AppLogo({super.key, this.size = 36, this.showBadge = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(size * 0.25),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.15),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.shield_rounded,
              color: AppColors.secondaryFixedDim,
              size: size * 0.65,
            ),
          ),
        ),
        if (showBadge)
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: size * 0.35,
              height: size * 0.35,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: AppColors.onSecondary,
                size: size * 0.22,
              ),
            ),
          ),
      ],
    );
  }
}
