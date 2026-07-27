import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DateSelector extends StatefulWidget {
  const DateSelector({super.key});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  int selectedIndex = 2; // which date pill is highlighted (0-based)

  // dummy dates just for the UI - we'll make this dynamic later
  final List<Map<String, String>> dates = [
    {"day": "03", "label": "Sun"},
    {"day": "04", "label": "Mon"},
    {"day": "05", "label": "Tue"},
    {"day": "06", "label": "Wed"},
    {"day": "07", "label": "Thu"},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index; // updates which pill is highlighted
              });
            },
            child: Container(
              width: 55,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryLight : AppColors.cardWhite,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dates[index]["day"]!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dates[index]["label"]!,
                    style: TextStyle(
                      fontSize: 11,
                      color: isSelected ? Colors.white70 : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
