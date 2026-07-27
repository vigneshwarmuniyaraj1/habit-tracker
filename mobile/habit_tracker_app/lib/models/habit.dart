import 'package:flutter/material.dart';

class Habit {
  final String name;
  final String progressText; // e.g. "5/8 Of Glass"
  final double progressPercent; // e.g. 0.25 for 25%
  final Color iconBackgroundColor;
  final IconData icon;

  Habit({
    required this.name,
    required this.progressText,
    required this.progressPercent,
    required this.iconBackgroundColor,
    required this.icon,
  });
}

// dummy sample data just so we can see the UI working
List<Habit> dummyHabits = [
  Habit(
    name: "Drink Water",
    progressText: "5/8 Of Glass",
    progressPercent: 0.25,
    iconBackgroundColor: const Color(0xFFDCEBFB),
    icon: Icons.water_drop,
  ),
  Habit(
    name: "Daily Steps",
    progressText: "2556/5000",
    progressPercent: 0.54,
    iconBackgroundColor: const Color(0xFFFBE1E1),
    icon: Icons.directions_walk,
  ),
  Habit(
    name: "Sleep",
    progressText: "6/8 hrs",
    progressPercent: 0.75,
    iconBackgroundColor: const Color(0xFFEDE7FB),
    icon: Icons.nightlight_round,
  ),
];
