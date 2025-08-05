class ForgetPasswordResponse {
  final bool success;
  final String message;
  final ForgetPasswordData data;

  ForgetPasswordResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: ForgetPasswordData.fromJson(json['data'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': data.toJson()};
  }
}

class ForgetPasswordData {
  final String message;
  ForgetPasswordData({required this.message});
  factory ForgetPasswordData.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordData(message: json['message'] ?? '');
  }
  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
