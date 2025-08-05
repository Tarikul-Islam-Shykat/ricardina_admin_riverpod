// features/auth/login_provider.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ricardina_admin_riverpod/feature/auth/login/model/login_state_model.dart';
import 'package:ricardina_admin_riverpod/feature/auth/login/repo/login_repo.dart';

// Repository provider
final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepository();
});

// Login state notifier
class LoginNotifier extends StateNotifier<LoginState> {
  final LoginRepository _repository;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginNotifier(this._repository) : super(const LoginState());

  Future<bool> login() async {
    state = state.copyWith(isLoading: true, error: null);

    final result = await _repository.login(
      emailController.text,
      passwordController.text,
    );

    state = result.copyWith(isLoading: false);
    return result.isAuthenticated;
  }

  void setUpValues() {
    emailController.text = "super.admin@gmail.com";
    passwordController.text = "12345678";
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

// Main login provider
final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final repository = ref.read(loginRepositoryProvider);
  return LoginNotifier(repository);
});
