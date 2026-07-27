import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../theme/app_theme.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;

  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // icon circle on the left
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: habit.iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(habit.icon, color: AppColors.textPrimary, size: 22),
          ),
          const SizedBox(width: 14),

          // habit name + progress text in the middle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(habit.name, style: AppTextStyles.cardTitle),
                const SizedBox(height: 4),
                Text(habit.progressText, style: AppTextStyles.cardSubtitle),
              ],
            ),
          ),

          // circular progress ring on the right
          SizedBox(
            width: 44,
            height: 44,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: habit.progressPercent, // e.g. 0.25 = 25%
                  strokeWidth: 5,
                  backgroundColor: AppColors.background,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
                Text(
                  "${(habit.progressPercent * 100).toInt()}%",
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
