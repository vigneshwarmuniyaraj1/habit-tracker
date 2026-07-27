import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final nameController = TextEditingController();
  String selectedCategory = "Health";
  String selectedFrequency = "Daily";

  final categories = ["Health", "Study", "Fitness", "Productivity"];
  final frequencies = ["Daily", "Weekly", "Custom"];

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text("Add New Habit", style: AppTextStyles.heading.copyWith(fontSize: 18)),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              const SizedBox(height: 10),

              Text("Habit Name", style: AppTextStyles.cardTitle),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "e.g. Drink Water",
                    hintStyle: AppTextStyles.cardSubtitle,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text("Category", style: AppTextStyles.cardTitle),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: categories.map((category) {
                  final isSelected = category == selectedCategory;
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = category),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.cardWhite,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              Text("Frequency", style: AppTextStyles.cardTitle),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: frequencies.map((freq) {
                  final isSelected = freq == selectedFrequency;
                  return GestureDetector(
                    onTap: () => setState(() => selectedFrequency = freq),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.cardWhite,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        freq,
                        style: TextStyle(
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: connect to real Create Habit API later
                    Navigator.pop(context); // just go back for now
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    "Create Habit",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
