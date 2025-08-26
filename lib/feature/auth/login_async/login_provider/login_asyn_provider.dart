import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ricardina_admin_riverpod/feature/auth/login_async/login_repo/login_repo.dart';

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepository();
});

final loginAsynProvider = AsyncNotifierProvider<LoginAsyncProvider, bool>(() {
  return LoginAsyncProvider();
});

class LoginAsyncProvider extends AsyncNotifier<bool> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<bool> build() async {
    return false;
  }

  Future<bool> login() async {
    state = const AsyncValue.loading();

    try {
      final repository = ref.read(loginRepositoryProvider);
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        state = AsyncValue.error("Please Fill All Fields", StackTrace.current);
        return false;
      }

      final result = await repository.login(
        emailController.text,
        passwordController.text,
      );

      if (result['success'] == true) {
        state = const AsyncValue.data(true);
        return true;
      } else {
        state = AsyncValue.error(
          result['message'] ?? 'Login failed',
          StackTrace.current,
        );
        return false;
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
    }
  }

  void setUpValues() {
    emailController.text = "super.admin@gmail.com";
    passwordController.text = "12345678";
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
