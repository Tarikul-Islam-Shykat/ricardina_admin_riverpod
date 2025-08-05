// features/auth/login_repository.dart

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ricardina_admin_riverpod/core/network_caller/endpoints.dart';
import 'package:ricardina_admin_riverpod/core/network_caller/network_config.dart';
import 'package:ricardina_admin_riverpod/feature/auth/forget_password/model/forget_req_model.dart';
import 'package:ricardina_admin_riverpod/feature/auth/forget_password/model/forget_res_model.dart';

final forgetPassRepoProvider = Provider<ForgetPasswordRepo>((ref) {
  return ForgetPasswordRepo();
});

class ForgetPasswordRepo {
  final NetworkConfig _networkConfig = NetworkConfig();

  Future<ForgetPasswordResponse> resetPassword(String email) async {
    if (email.isEmpty) {
      throw Exception("Please Fill All The Fields");
    }
    try {
      final request = ForgetReqModel(email: email);
      final response = await _networkConfig.ApiRequestHandler(
        RequestMethod.POST,
        Urls.forgotPass,
        json.encode(request.toJson()),
        is_auth: false,
      );

      if (response != null && response['success'] == true) {
        return ForgetPasswordResponse(
          success: response['success'] ?? false,
          message: response['message'] ?? '',
          data: ForgetPasswordData.fromJson(response['data'] ?? {}),
        );
      } else {
        throw Exception(response?['message'] ?? 'Failed');
      }
    } catch (e) {
      throw Exception('Error Occurred While Processing The Request.');
    }
  }
}
