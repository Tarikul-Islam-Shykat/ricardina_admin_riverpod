// features/auth/login/repo/login_repo.dart

import 'dart:convert';
import 'package:ricardina_admin_riverpod/core/local/local_data.dart';
import 'package:ricardina_admin_riverpod/core/network_caller/endpoints.dart';
import 'package:ricardina_admin_riverpod/core/network_caller/network_config.dart';

class DashboardRepository {
  final NetworkConfig _networkConfig = NetworkConfig();
  final LocalService _localService = LocalService();

  Future<Map<String, dynamic>> getDashboardData() async {
    try {
      // Create request body directly without model
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.GET,
        Urls.getDashboardData,
        json.encode({}),
        is_auth: true,
      );

      if (response != null && response['success'] == true) {
        return {'success': true, 'data': response};
      } else {
        return {
          'success': false,
          'message': response?['message'] ?? 'Failed To Get Dashboard Data',
        };
      }
    } catch (e) {
      return {'success': false, 'message': "Failed to Get Dashboard Data: $e"};
    }
  }
}
