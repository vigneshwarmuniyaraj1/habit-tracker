import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_storage.dart';

class ApiService {
  // 👇 Default to Android emulator alias (10.0.2.2:5174). Change to your computer's IP if testing on a physical phone.
  static const String baseUrl = "http://10.0.2.2:5174";

  // ---------- AUTH ----------

  static Future<Map<String, dynamic>?> register(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null; // registration failed (e.g. email already exists)
  }

  static Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null; // wrong email/password
  }

  // ---------- HABITS ----------

  static Future<List<dynamic>?> getAllHabits() async {
    final token = await AuthStorage.getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/api/habit"),
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> createHabit({
    required String name,
    required String category,
    required int frequencyType,
    required List<int> targetDays,
  }) async {
    final token = await AuthStorage.getToken();

    final response = await http.post(
      Uri.parse("$baseUrl/api/habit"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "name": name,
        "category": category,
        "frequencyType": frequencyType,
        "targetDays": targetDays,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    }
    return null;
  }

  static Future<bool> deleteHabit(String habitId) async {
    final token = await AuthStorage.getToken();

    final response = await http.delete(
      Uri.parse("$baseUrl/api/habit/$habitId"),
      headers: {"Authorization": "Bearer $token"},
    );

    return response.statusCode == 204;
  }
}
