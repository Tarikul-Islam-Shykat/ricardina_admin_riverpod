// features/auth/login/repo/login_repo.dart

import 'dart:convert';
import 'package:ricardina_admin_riverpod/core/local/local_data.dart';
import 'package:ricardina_admin_riverpod/core/network_caller/endpoints.dart';
import 'package:ricardina_admin_riverpod/core/network_caller/network_config.dart';

class LoginRepository {
  final NetworkConfig _networkConfig = NetworkConfig();
  final LocalService _localService = LocalService();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Create request body directly without model
      final requestBody = {
        "email": email,
        "password": password,
        "role": "SUPER_ADMIN",
      };

      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        Urls.login,
        json.encode(requestBody),
        is_auth: false,
      );

      if (response != null && response['success'] == true) {
        // Save user data
        await _localService.clearUserData();
        await _localService.setToken(response["data"]["token"]);
        await _localService.setRole(response["data"]["role"]);

        return {
          'success': true,
          'token': response["data"]["token"],
          'role': response["data"]["role"],
        };
      } else {
        return {
          'success': false,
          'message': response?['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': "Failed to login: $e"};
    }
  }
}
