class LoginState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? error;
  final String? token;
  final String? role;

  const LoginState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.error,
    this.token,
    this.role,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
    String? token,
    String? role,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error,
      token: token ?? this.token,
      role: role ?? this.role,
    );
  }
}
