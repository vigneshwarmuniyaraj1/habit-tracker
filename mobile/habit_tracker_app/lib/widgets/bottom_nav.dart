import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;

  final icons = [
    Icons.home_rounded,
    Icons.bar_chart_rounded,
    Icons.calendar_today_rounded,
    Icons.person_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.textPrimary, // dark pill background
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(icons.length, (index) {
          final isSelected = index == selectedIndex;
          return GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: Icon(
              icons[index],
              color: isSelected ? AppColors.primaryLight : Colors.white54,
              size: 24,
            ),
          );
        }),
      ),
    );
  }
}
