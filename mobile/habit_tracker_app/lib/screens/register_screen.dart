import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isPasswordHidden = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              const SizedBox(height: 60),

              Text("Create Account", style: AppTextStyles.heading.copyWith(fontSize: 26)),
              const SizedBox(height: 6),
              Text(
                "Sign up to start building better habits",
                style: AppTextStyles.subheading,
              ),

              const SizedBox(height: 40),

              Text("Email", style: AppTextStyles.cardTitle),
              const SizedBox(height: 8),
              _buildTextField(controller: emailController, hint: "you@example.com", icon: Icons.email_outlined),

              const SizedBox(height: 20),

              Text("Password", style: AppTextStyles.cardTitle),
              const SizedBox(height: 8),
              _buildTextField(controller: passwordController, hint: "Create a password", icon: Icons.lock_outline, isPassword: true),

              const SizedBox(height: 20),

              Text("Confirm Password", style: AppTextStyles.cardTitle),
              const SizedBox(height: 8),
              _buildTextField(controller: confirmPasswordController, hint: "Re-enter your password", icon: Icons.lock_outline, isPassword: true),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () async {
                    if (passwordController.text != confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }

                    final result = await ApiService.register(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );

                    if (result != null) {
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      }
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Email already registered")),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context), // goes back to login screen
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: AppTextStyles.subheading,
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? isPasswordHidden : false,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.cardSubtitle,
          prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  onPressed: () => setState(() => isPasswordHidden = !isPasswordHidden),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }
}
