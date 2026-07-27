import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: const BoxDecoration(
            color: AppColors.cardWhite,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: AppTextStyles.cardSubtitle,
        ),
      ],
    );
  }
}
