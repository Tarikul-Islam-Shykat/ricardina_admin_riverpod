class ForgetReqModel {
  final String email;
  ForgetReqModel({required this.email});
  Map<String, dynamic> toJson() => {"email": email};
}
