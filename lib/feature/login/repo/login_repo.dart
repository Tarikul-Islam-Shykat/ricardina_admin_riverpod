// features/auth/login_repository.dart

import 'dart:convert';

import 'package:ricardina_admin_riverpod/core/local/local_data.dart';
import 'package:ricardina_admin_riverpod/core/network_caller/endpoints.dart';
import 'package:ricardina_admin_riverpod/core/network_caller/network_config.dart';
import 'package:ricardina_admin_riverpod/feature/login/model/login_request_model.dart';
import 'package:ricardina_admin_riverpod/feature/login/model/login_state_model.dart';

class LoginRepository {
  final NetworkConfig _networkConfig = NetworkConfig();
  final LocalService _localService = LocalService();

  Future<LoginState> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return const LoginState(error: 'Please fill all fields');
    }

    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        Urls.login,
        json.encode(request.toJson()),
        is_auth: false,
      );

      if (response != null && response['success'] == true) {
        // Save user data
        await _localService.clearUserData();
        await _localService.setToken(response["data"]["token"]);
        await _localService.setRole(response["data"]["role"]);

        return LoginState(
          isAuthenticated: true,
          token: response["data"]["token"],
          role: response["data"]["role"],
        );
      } else {
        return LoginState(error: response?['message'] ?? 'Login failed');
      }
    } catch (e) {
      return LoginState(error: "Failed to login: $e");
    }
  }

  Future<bool> isAuthenticated() async {
    final token = await _localService.getToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async {
    await _localService.clearUserData();
  }
}
