import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pas_mobile_11pplg2_11/network/api_service.dart';
import 'package:pas_mobile_11pplg2_11/routes/routes.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final registerUrl = 'https://mediadwi.com/api/latihan/register-user';
  final loginUrl = 'https://mediadwi.com/api/latihan/login';

  Future<void> register(String username, String fullName, String email, String password) async {
    try {
      isLoading.value = true;
      final res = await ApiService.client.post(Uri.parse(registerUrl), body: {
        'username': username,
        'full_name': fullName,
        'email': email,
        'password': password,
      });

      final body = json.decode(res.body);
      isLoading.value = false;

      if (res.statusCode == 200) {
        Get.snackbar('Success', body['message'] ?? 'Register success');
        Get.toNamed(AppRoutes.login);
      } else {
        Get.snackbar('Error', body['message'] ?? 'Register failed');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Register error: $e');
    }
  }

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      final res = await ApiService.client.post(Uri.parse(loginUrl), body: {
        'username': username,
        'password': password,
      });

      final body = json.decode(res.body);
      isLoading.value = false;

      if (res.statusCode == 200) {
        String? token;
        if (body['token'] != null) token = body['token'];
        else if (body['data'] != null && body['data']['token'] != null) token = body['data']['token'];
        else if (body is String) token = body;

        if (token != null && token.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          if (body['username'] != null) {
            await prefs.setString('username', body['username']);
          }
          if (body['email'] != null) {
            await prefs.setString('email', body['email']);
          }
          Get.offAllNamed(AppRoutes.home);
          Get.snackbar('Success', 'Login berhasil');
        } else {
          if (body['status'] == true && body['data'] != null) {
            final prefs = await SharedPreferences.getInstance();
            final tokenFromData = body['data']['token'] ?? body['data']['access_token'];
            if (tokenFromData != null) {
              await prefs.setString('token', tokenFromData);
              Get.offAllNamed(AppRoutes.home);
              return;
            }
          }
          Get.snackbar('Error', body['message'] ?? 'Login gagal: token tidak ditemukan');
        }
      } else {
        Get.snackbar('Error', 'Login failed: ${res.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Login error: $e');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Get.offAllNamed(AppRoutes.login);
  }
}
