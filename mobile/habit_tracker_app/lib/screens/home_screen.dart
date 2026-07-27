import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/habit.dart';
import '../widgets/date_selector.dart';
import '../widgets/category_item.dart';
import '../widgets/habit_card.dart';
import '../widgets/bottom_nav.dart';
import 'add_habit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHabitScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Stack(
        children: [
          // main scrollable content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const SizedBox(height: 10),

                  // header row: profile pic + name + search icon
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.primaryLight,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Welcome back,", style: AppTextStyles.cardSubtitle),
                            Text("Your Name", style: AppTextStyles.cardTitle),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: AppColors.cardWhite,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.search, color: AppColors.textPrimary),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  Text("Track Your Habits", style: AppTextStyles.heading),
                  const SizedBox(height: 14),

                  // date selector row
                  const DateSelector(),

                  const SizedBox(height: 24),
                  Text("Featured Categories", style: AppTextStyles.heading),
                  const SizedBox(height: 14),

                  // categories row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CategoryItem(icon: Icons.self_improvement, label: "Yoga"),
                      CategoryItem(icon: Icons.fitness_center, label: "Gym"),
                      CategoryItem(icon: Icons.directions_run, label: "Fitness"),
                      CategoryItem(icon: Icons.sports, label: "Run"),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // habit cards list (from our dummy data)
                  ...dummyHabits.map((habit) => HabitCard(habit: habit)),

                  const SizedBox(height: 100), // space so content isn't hidden behind nav bar
                ],
              ),
            ),
          ),

          // floating bottom nav bar
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: const BottomNav(),
          ),
        ],
      ),
    );
  }
}
