import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ricardina_admin_riverpod/feature/auth/forget_password/model/forget_res_model.dart';
import 'package:ricardina_admin_riverpod/feature/auth/forget_password/repo/forget_password_repo.dart';

final forgetPasswordProvider =
    AsyncNotifierProvider<ForgetPasswordNotifier, ForgetPasswordResponse?>(
      () => ForgetPasswordNotifier(),
    );

class ForgetPasswordNotifier extends AsyncNotifier<ForgetPasswordResponse?> {
  final TextEditingController emailController = TextEditingController();
  late final ForgetPasswordRepo _forgetPasswordRepository;

  @override
  Future<ForgetPasswordResponse?> build() async {
    _forgetPasswordRepository = ref.read(forgetPassRepoProvider);
    return null; // Initial state
  }

  Future<void> forgetPassword() async {
    state = const AsyncLoading();

    try {
      final result = await _forgetPasswordRepository.resetPassword(
        emailController.text,
      );
      state = AsyncData(result);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
