import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import '../services/api_service.dart';
import '../services/auth_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordHidden = true;

  @override
  void dispose() {
    // always clean up controllers when the screen is closed - avoids memory leaks
    emailController.dispose();
    passwordController.dispose();
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

              Text("Welcome Back", style: AppTextStyles.heading.copyWith(fontSize: 26)),
              const SizedBox(height: 6),
              Text(
                "Login to continue tracking your habits",
                style: AppTextStyles.subheading,
              ),

              const SizedBox(height: 40),

              // email field
              _buildLabel("Email"),
              const SizedBox(height: 8),
              _buildTextField(
                controller: emailController,
                hint: "you@example.com",
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 20),

              // password field
              _buildLabel("Password"),
              const SizedBox(height: 8),
              _buildTextField(
                controller: passwordController,
                hint: "Enter your password",
                icon: Icons.lock_outline,
                isPassword: true,
              ),

              const SizedBox(height: 32),

              // login button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () async {
                    final result = await ApiService.login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );

                    if (result != null) {
                      // save the token so future API calls work
                      await AuthStorage.saveToken(result["token"]);

                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      }
                    } else {
                      // show error if login failed
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Invalid email or password")),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // link to register screen
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: AppTextStyles.subheading,
                      children: [
                        TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
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

  // small reusable helper - avoids repeating the same label style everywhere
  Widget _buildLabel(String text) {
    return Text(text, style: AppTextStyles.cardTitle);
  }

  // reusable text field styled to match the app's card look
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
                  onPressed: () {
                    setState(() => isPasswordHidden = !isPasswordHidden);
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }
}
